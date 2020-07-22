% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function [T1,T2] = double_audio_analysis(data)
    
% -------------------------------------------------------------------------
%   Crea dos tablas con todas las relaciones de música y voz, 
%   dividiendo la mitad de datos de cada pista en las dos tablas
%
%   INPUT -----------------------------------
%
%   data                    Estructura de datos tras haber realizado ICA de
%                           un sujeto procesado
%
%   OUTPUT ----------------------------------
%
%   T1                      Tabla de relaciones con la primera mitad de
%                           música y voz
%
%   T2                      Tabla de relaciones con la segunda mitad de
%                           música y voz
%
% -------------------------------------------------------------------------

    DATA = data.relations;

    %% Creacion de una Tabla:

    T1 = table();
    T2 = table();
    
    % DATA{1} = Flauta mágica;   DATA{2} = Vals strauss
    % DATA{3} = Universal mind;  DATA{4} = Adios nomino
    
    z = 1; % NÚMERO DE PISTA MUSICAL (modificar según la canción deseada)
    
    M1 = round(length(DATA{z}{1,2})/2); % Mitad nº ventanas música
    M2 = length(DATA{z}{1,2});          % Nº ventanas música
    
    V1 = round(length(DATA{5}{1,2})/2); % Mitad nº ventanas voz
    V2 = length(DATA{5}{1,2});          % Nº ventanas voz
    
    m1(1:M1) = 1;      % Tipo = 1 -> 1a mitad música
    v1(1:V1) = 0;      % Tipo = 0 -> 1a mitad voz
    
    m2(1:(M2-M1)) = 1; % 2a mitad música
    v2(1:(V2-V1)) = 0; % 2a mitad voz

    T1.Tipo = [m1'; v1'];
    T2.Tipo = [m2'; v2'];
    
    
    % PRIMERA MITAD
    for k = 1:length(DATA{z})
        for c = 1:size(DATA{z}{k,2},1)

            create_data_str = sprintf('Variable_aux = [(DATA{%d}{%d,2}(%d,1:%d))''; (DATA{5}{%d,2}(%d,1:%d))'']; ',z,k,c,M1,k,c,V1); %%%% DATA{X}{XX,2}{XX,:}
            eval(create_data_str); 
            create_table_colum_str = sprintf('T1.%s = Variable_aux; ', strcat(DATA{z}{k,1},'C',int2str(c)));
            eval(create_table_colum_str);

        end

        for c = 1:size(DATA{z}{k,3},1)
            
            create_data_str = sprintf('Variable_aux = [(DATA{%d}{%d,3}{%d,2}(1:%d))''; (DATA{5}{%d,3}{%d,2}(1:%d))''];',z,k,c,M1,k,c,V1); %%%% DATA{X}{XX,3}{XX,2}
            eval(create_data_str); 
            create_table_colum_str = sprintf('T1.%s = Variable_aux; ', DATA{z}{k,3}{c,1});
            eval(create_table_colum_str);

        end
    end
    
    % SEGUNDA MITAD
    for k = 1:length(DATA{z})
        for c = 1:size(DATA{z}{k,2},1)

            create_data_str = sprintf('Variable_aux = [(DATA{%d}{%d,2}(%d,%d:%d))''; (DATA{5}{%d,2}(%d,%d:%d))'']; ',z,k,c,M1+1,M2,k,c,V1+1,V2); %%%% DATA{X}{XX,2}{XX,:}
            eval(create_data_str); 
            create_table_colum_str = sprintf('T2.%s = Variable_aux; ', strcat(DATA{z}{k,1},'C',int2str(c)));
            eval(create_table_colum_str);

        end

        for c = 1:size(DATA{z}{k,3},1) 
            
            create_data_str = sprintf('Variable_aux = [(DATA{%d}{%d,3}{%d,2}(%d:%d))''; (DATA{5}{%d,3}{%d,2}(%d:%d))''];',z,k,c,M1+1,M2,k,c,V1+1,V2); %%%% DATA{X}{XX,3}{XX,2}
            eval(create_data_str); 
            create_table_colum_str = sprintf('T2.%s = Variable_aux; ', DATA{z}{k,3}{c,1});
            eval(create_table_colum_str);

        end
    end

end
