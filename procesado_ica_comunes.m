% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function [comp_ica_sujeto,T1,T2] = procesado_ica_comunes(data,t)

% -------------------------------------------------------------------------
%   PROCESADO_ICA ordena las matrices unmixing a partir del sujeto 9 y,
%   después, realiza cinco filtros paso banda centrados en las
%   distintas bandas cerebrales a los datos obtenidos tras haber aplicado 
%   ICA a las señales de EEG. Posteriormente, realiza un enventanado de los
%   datos agrupando muestras cada t segundos y obteniendo el total de 
%   energía (en dB) de cada ventana.
%
%   Por otro lado, se obtiene la energía total realizando un enventanado a
%   los datos iniciales.
%   
%   Además, con las energías obtenidas se crean relaciones mediante
%   la diferencia de dos bandas y, de las resultantes, también entre
%   canales. Las relaciones se guardan en dos tablas que contendrán la
%   primera y segunda mitad de los datos, respectivamente, de los estímulos
%   seleccionados (por defecto se selecciona la primera pista musical lo
%   cual hay que modificar en double_audio_analysis.m)
%
%   INPUT ---------------------------------------------
%
%   data                        Datos tras ICA de un sujeto cargado 
%                               previamente
%   t                           Tiempo empleado en ventanes [seg]
%
%   OUTPUT --------------------------------------------
%
%   eeg_clean_sujeto            Datos tras ICA del sujeto tras el procesado
%
%   T1                          Tabla de relaciones con la primera mitad de
%                               los datos de la pista seleccionada.
%
%   T2                          Tabla de relaciones con la segunda mitad de
%                               los datos de la pista seleccionada.
%
% -------------------------------------------------------------------------


%% Número de pistas/estímulos
L = length(data.trial);

%% COMPONENTES ORDENADAS
% Ambas matrices tienen el mismo número de componentes (9x9) y se ordenan
% respecto a la matriz unmixing del sujeto 9.

% Sujeto utilizado como referencia
origen = load('C:\Users\irenegp\Desktop\TFG\20181019_archivos_irene\archivos_eeg\ica_9\sujeto_9.mat');

% Vector distancia entre ambas unmixing antes de ordenar
dist_inicial = sum(origen.comp_ica.unmixing - data.unmixing,2);

new_index = fta_sort_matrix(origen.comp_ica.unmixing,data.unmixing);
data.unmixing = data.unmixing(new_index,:);
for z = 1:L
    data.trial{z} = data.trial{z}(new_index,:);
end

% Vector distancia entre ambas unmixing después de ordenar
dist_final = sum(origen.comp_ica.unmixing - data.unmixing,2);

% La distancia después de ordenar debe ser menor que la primera
dist = abs(dist_final) <= abs(dist_inicial);

%% ENERGÍA TOTAL POR VENTANA
% Se realiza el enventanado y, posteriormente, se obtiene la energía total
% de cada ventana.

TIME = t;                           % segundos
OVERLAP = 50;                       % porcentaje (%)

N = TIME*data.fsample;              % Número de muestras por ventana
displacement = N*OVERLAP/100;       % Desplazamiento de ventana del 50%

data.total_energy = e_total(data,N,displacement);

%% FILTRADO PASO BANDA

Bandas = [1, 3, 7, 14, 30, 50];
data.bandpass = cell(1,L);

for z = 1:L
    
    [f,c] = size(data.trial{z});
     
    data.bandpass{z} = cell(1,L);

    for k = 1:(length(Bandas)-1)

        for t = 1:f

            data.bandpass{z}{k}(t,:) = bandpass(data.trial{z}(t,:),[Bandas(k) Bandas(k+1)],data.fsample,'ImpulseResponse','iir','Steepness',0.95);

        end

        max = 2*floor(c/N)-1;          

        m = 1;
        n = N;

        for x = 1:max

            data.windowed{z}{k}{x} = data.bandpass{z}{k}(:,m:n);

            n = n + displacement;
            m = m + displacement;

            data.energy{z}{k}(:,x) = log10(sum((data.windowed{z}{k}{x}.^2),2));

        end

        % Últimas muestras cuyo tamaño es menor a una ventana N
        data.windowed{z}{k}{max+1} = data.bandpass{z}{k}(:,m:c);
        data.energy{z}{k}(:,max+1) = log10(sum((data.windowed{z}{k}{max+1}.^2),2));

    end
end

%% RELACIONES DE ENERGÍA POR BANDA

data.relations = cell(1,L); 
e_string = ['d','t','a','b','g']; % delta, theta, alpha, beta, gamma

for z = 1:L
     
    data.relations{z} = cell((length(Bandas)-1)*(length(Bandas)-1),3);

    k = 1;

    for i = 1:(length(Bandas)-1)
        for j = 0:(length(Bandas)-1)

            if j == 0
                data.relations{z}{k,1} = strcat('E',e_string(i),'E');
                data.relations{z}{k,2} = data.energy{z}{i}-data.total_energy{z};
                k = k + 1;
            else
                if j ~= i
                    data.relations{z}{k,1} = strcat('E',e_string(i),'E',e_string(j));
                    data.relations{z}{k,2} = data.energy{z}{i}-data.energy{z}{j};
                    k = k + 1;
                end
            end
        end
    end
end

%% RELACIONES DE ENERGÍA POR COMPONENTES

for z = 1:5
    
    for i = 1:length(data.relations{z})
            
        data.relations{z}{i,3} = cell((size(data.trial{z},1)-1)*size(data.trial{z},1),2);
        % COLUMNA 1 -> STRINGs -> Ej: EdEgC1_EdEgC2, EdEgC2_EdEgC1
        % COLUMNA 2 -> DATOS 

        k = 1;
        for j = 1:(size(data.trial{z},1))
            for x = 1:(size(data.trial{z},1))

                if j ~= x

                    data.relations{z}{i,3}{k,1} = strcat(data.relations{z}{i,1},'C',int2str(j),'_',data.relations{z}{i,1},'C',int2str(x));
                    data.relations{z}{i,3}{k,2} = data.relations{z}{i,2}(j,:)-data.relations{z}{i,2}(x,:);
                    k = k + 1;

                end
            end
        end
    end
end

%% TABLAS CON RELACIONES para usar classificationLearner

[T1,T2] = double_audio_analysis(data);
%[T1,T2] = total_audio_analysis(data);

%% Sujeto
comp_ica_sujeto = data;

end
