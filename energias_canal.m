% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function eeg_clean_sujeto = energias_canal(data)

% -------------------------------------------------------------------------
%   Se separan en vectores independientes los canales de EEG para cada una
%   de las energías de bandas de frecuencia definidas, así como para la
%   energía total.
%
%   INPUT -----------------------------------------
%
%   data                    Estructura de datos EEG de un sujeto procesado
%
%   OUTPUT ----------------------------------------
%
%   eeg_clean_sujeto        Estructura de datos en la que se incluye el
%                           resultado de la función
%
% -------------------------------------------------------------------------


    L = length(data.trial);               % Número de estímulos

    data.channel_energy = cell(1,L); 
    e_string = ['w','d','t','a','b','g']; % total, delta, theta, alpha, beta, gamma

    for z = 1:L

        f = size(data.trial{z},1);        % Número de canales          

        data.channel_energy{z} = cell(length(e_string)*f,2);

        k = 1;

        for i = 1:(length(e_string))

            for j = 1:f

                data.channel_energy{z}{k,1} = strcat('E',e_string(i),data.label{j});

                if i == 1
                    data.channel_energy{z}{k,2} = data.total_energy{z}(j,:);
                else
                    data.channel_energy{z}{k,2} = data.energy{z}{i-1}(j,:);
                end
                k = k + 1;

            end
        end
    end
    
    eeg_clean_sujeto = data;
    
end
