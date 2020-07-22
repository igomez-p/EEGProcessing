% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function T = table_eeg(data,trial)

% -------------------------------------------------------------------------
%   Se crea una tabla a partir de las combinaciones obtenidas con la
%   funci�n energias_canal.m, donde cada columna corresponde al vector de
%   energ�a que tiene un canal seg�n su energ�a total o la banda cerebral.
%
%   INPUT -----------------------
%
%   data                Estructura de datos EEG de un sujeto procesado
%
%   trial               N�mero que corresponde a la pista musical deseada
%                       1 = Flauta m�gica;   2 = Vals strauss
%                       3 = Universal mind;  4 = Adios nomino
%
%   OUTPUT ----------------------
%
%   T                   Tabla con los canales seg�n sus distintas energ�as
%
% -------------------------------------------------------------------------

    DATA = data.relations;

    %% Creacion de una Tabla:

    T = table();
    
    m(1:length(DATA{trial}{1,2})) = 1;      % Tipo = 1 -> m�sica
    v(1:length(DATA{5}{1,2})) = 0;      % Tipo = 0 -> voz

    T.Tipo = [m'; v'];

    for k = 1:length(DATA{trial})
        for c = 1:size(DATA{trial}{k,2},1)

            create_data_str = sprintf('Variable_aux = [(DATA{%d}{%d,2}(%d,:))''; (DATA{5}{%d,2}(%d,:))'']; ',trial,k,c,k,c); %%%% DATA{X}{XX,2}{XX,:}
            eval(create_data_str); 
            create_table_colum_str = sprintf('T.%s = Variable_aux; ', strcat(DATA{trial}{k,1}));
            eval(create_table_colum_str);

        end
    end

end
