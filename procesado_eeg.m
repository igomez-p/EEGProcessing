% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function [eeg_clean_sujeto,T1,T2] = procesado_eeg(data, t)

% -------------------------------------------------------------------------
%   PROCESADO_EEG realiza cinco filtros paso banda centrados en las
%   distintas bandas cerebrales a los datos obtenidos del
%   electroencefalograma. Posteriormente, realiza un enventanado de los
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
%   data                        Estructura de datos EEG de un sujeto
%                               previamente cargado
%
%   t                           Tiempo empleado en ventanes [seg]
%
%   OUTPUT --------------------------------------------
%
%   eeg_clean_sujeto            Datos del sujeto tras el procesado
%
%   T1                          Tabla de relaciones con la primera mitad de
%                               los datos de la pista seleccionada y voz.
%
%   T2                          Tabla de relaciones con la segunda mitad de
%                               los datos de la pista seleccionada y voz.
%
% -------------------------------------------------------------------------

%% Número de pistas/estímulos

L = length(data.trial);

%% ENERGÍA TOTAL POR VENTANA

TIME = t;                               % segundos
OVERLAP = 50;                           % porcentaje (%)

N = TIME*data.fsample;                  % Número de muestras por ventana
displacement = floor(N*OVERLAP/100);    % Desplazamiento de ventana del 50%

data.total_energy = e_total(data,N,displacement);

%% FILTRADO PASO BANDA

Bandas = [1, 3, 7, 14, 30, 50];         % Bandas de frecuencia del cerebro
data.bandpass = cell(1,L);

for z = 1:L
    
    [f,c] = size(data.trial{z});
        
    data.bandpass{z} = cell(1,L);

    for k = 1:(length(Bandas)-1)

        for t = 1:f

            % Filtro paso banda
            data.bandpass{z}{k}(t,:) = bandpass(data.trial{z}(t,:),[Bandas(k) Bandas(k+1)],data.fsample,'ImpulseResponse','iir','Steepness',0.95);

        end

        % Número de ventanas según la longitud de pista y el número de muestras
        max = 2*floor(c/N)-1;          

        m = 1;                          % Inicio de la primera ventana
        n = N;                          % Fin de la primera ventana

        for x = 1:max

            % Enventanado rectangular
            data.windowed{z}{k}{x} = data.bandpass{z}{k}(:,m:n);

            n = n + displacement;
            m = m + displacement;

            % Logaritmo de la energía (E [dB])
            data.energy{z}{k}(:,x) = log10(sum((data.windowed{z}{k}{x}.^2),2));

        end

        % Últimas muestras cuyo tamaño es menor a una ventana de N muestras
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

%% RELACIONES DE ENERGÍA POR CANAL

for z = 1:5
    
    for i = 1:length(data.relations{z})
            
        data.relations{z}{i,3} = cell((size(data.trial{z},1)-1)*size(data.trial{z},1),2);
        % COLUMNA 1 -> STRINGs -> Ej: EdEgFz_EdEgFCz, EdEgFCz_EdEgFz
        % COLUMNA 2 -> DATOS 

        k = 1;
        for j = 1:(size(data.trial{z},1))
            for x = 1:(size(data.trial{z},1))

                if j ~= x

                    data.relations{z}{i,3}{k,1} = strcat(data.relations{z}{i,1},data.label{j},'_',data.relations{z}{i,1},data.label{x});
                    data.relations{z}{i,3}{k,2} = data.relations{z}{i,2}(j,:)-data.relations{z}{i,2}(x,:);
                    k = k + 1;

                end
            end
        end
    end
end

%% TABLAS CON RELACIONES para usar classificationLearner

 [T1,T2] = double_audio_analysis_eeg(data);
%[T1,T2] = total_audio_analysis_eeg(data);

%% Sujeto
eeg_clean_sujeto = data;

end
