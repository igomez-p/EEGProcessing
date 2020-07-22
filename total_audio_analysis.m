% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function [TBL1,TBL2] = total_audio_analysis(data)

% -------------------------------------------------------------------------
%   Crea dos tablas con todas las relaciones de todas las pistas usadas 
%   dividiendo la mitad de datos de cada pista en las dos tablas
%
%   INPUT -----------------------------------
%
%   data                    Estructura de datos tras haber realizado ICA de
%                           un sujeto procesado
%
%   OUTPUT ----------------------------------
%
%   T1                      Tabla de relaciones con la primera mitad de las
%                           pistas musicales y la grabación
%
%   T2                      Tabla de relaciones con la segunda mitad de las
%                           pistas musicales y la grabación
%
% -------------------------------------------------------------------------

    DATA = data.relations;

    %% Creacion de una Tabla:

    TBL1 = table();
    TBL2 = table();
    
    % DATA{1} = Flauta mágica;   DATA{2} = Vals strauss
    % DATA{3} = Universal mind;  DATA{4} = Adios nomino
    
    %z = 4; % NÚMERO DE PISTA MUSICAL
    
    % Flauta mágica
    M1 = round(length(DATA{1}{1,2})/2); % Mitad nº ventanas música
    M2 = length(DATA{1}{1,2});          % Nº ventanas música
    
    % Vals strauss
    W1 = round(length(DATA{2}{1,2})/2); % Mitad nº ventanas música
    W2 = length(DATA{2}{1,2});          % Nº ventanas música
    
    % Universal mind
    R1 = round(length(DATA{3}{1,2})/2); % Mitad nº ventanas música
    R2 = length(DATA{3}{1,2});          % Nº ventanas música
    
    % Adios nomino
    T1 = round(length(DATA{4}{1,2})/2); % Mitad nº ventanas música
    T2 = length(DATA{4}{1,2});          % Nº ventanas música
    
    % Voz
    V1 = round(length(DATA{5}{1,2})/2); % Mitad nº ventanas voz
    V2 = length(DATA{5}{1,2});          % Nº ventanas voz
    
    m1(1:M1) = 1;      % Tipo = 1 -> 1a mitad música (flauta magica)
    w1(1:W1) = 2;      % Tipo = 2 -> 1a mitad vals
    r1(1:R1) = 3;      % Tipo = 3 -> 1a mitad rock
    t1(1:T1) = 4;      % Tipo = 4 -> 1a mitad tango
    v1(1:V1) = 0;      % Tipo = 0 -> 1a mitad voz
    
    m2(1:(M2-M1)) = 1; % 2a mitad música (flauta mágica)
    w2(1:(W2-W1)) = 2; % 2a mitad vals
    r2(1:(R2-R1)) = 3; % 2a mitad rock
    t2(1:(T2-T1)) = 4; % 2a mitad tango
    v2(1:(V2-V1)) = 0; % 2a mitad voz

    TBL1.Tipo = [m1'; w1'; r1'; t1'; v1'];
    TBL2.Tipo = [m2'; w2'; r2'; t2'; v2'];
    
    NRE = length(DATA{1});      % Número de Relaciones de Energía 
                                % (igual para todas las pistas)
    
    % PRIMERA MITAD
    for k = 1:NRE
        for c = 1:size(DATA{1}{k,2},1)

            create_data_str = sprintf('Variable_aux = [(DATA{1}{%d,2}(%d,1:%d))''; (DATA{2}{%d,2}(%d,1:%d))''; (DATA{3}{%d,2}(%d,1:%d))''; (DATA{4}{%d,2}(%d,1:%d))''; (DATA{5}{%d,2}(%d,1:%d))'']; ',k,c,M1,k,c,W1,k,c,R1,k,c,T1,k,c,V1); %%%% DATA{X}{XX,2}{XX,:}
            eval(create_data_str); 
            create_table_colum_str = sprintf('TBL1.%s = Variable_aux; ', strcat(DATA{1}{k,1},'C',int2str(c)));
            eval(create_table_colum_str);

        end

        for c = 1:size(DATA{1}{k,3},1)
            
            create_data_str = sprintf('Variable_aux = [(DATA{1}{%d,3}{%d,2}(1:%d))''; (DATA{2}{%d,3}{%d,2}(1:%d))''; (DATA{3}{%d,3}{%d,2}(1:%d))''; (DATA{4}{%d,3}{%d,2}(1:%d))''; (DATA{5}{%d,3}{%d,2}(1:%d))''];',k,c,M1,k,c,W1,k,c,R1,k,c,T1,k,c,V1); %%%% DATA{X}{XX,3}{XX,2}
            eval(create_data_str); 
            create_table_colum_str = sprintf('TBL1.%s = Variable_aux; ', DATA{1}{k,3}{c,1});
            eval(create_table_colum_str);

        end
    end
    
    % SEGUNDA MITAD
    for k = 1:NRE
        for c = 1:size(DATA{1}{k,2},1)

            create_data_str = sprintf('Variable_aux = [(DATA{1}{%d,2}(%d,%d:%d))''; (DATA{2}{%d,2}(%d,%d:%d))''; (DATA{3}{%d,2}(%d,%d:%d))''; (DATA{4}{%d,2}(%d,%d:%d))''; (DATA{5}{%d,2}(%d,%d:%d))'']; ',k,c,M1+1,M2,k,c,W1+1,W2,k,c,R1+1,R2,k,c,T1+1,T2,k,c,V1+1,V2); %%%% DATA{X}{XX,2}{XX,:}
            eval(create_data_str); 
            create_table_colum_str = sprintf('TBL2.%s = Variable_aux; ', strcat(DATA{1}{k,1},'C',int2str(c)));
            eval(create_table_colum_str);

        end

        for c = 1:size(DATA{1}{k,3},1) 
            
            create_data_str = sprintf('Variable_aux = [(DATA{1}{%d,3}{%d,2}(%d:%d))''; (DATA{2}{%d,3}{%d,2}(%d:%d))''; (DATA{3}{%d,3}{%d,2}(%d:%d))''; (DATA{4}{%d,3}{%d,2}(%d:%d))''; (DATA{5}{%d,3}{%d,2}(%d:%d))''];',k,c,M1+1,M2,k,c,W1+1,W2,k,c,R1+1,R2,k,c,T1+1,T2,k,c,V1+1,V2); %%%% DATA{X}{XX,3}{XX,2}
            eval(create_data_str); 
            create_table_colum_str = sprintf('TBL2.%s = Variable_aux; ', DATA{1}{k,3}{c,1});
            eval(create_table_colum_str);

        end
    end
end
