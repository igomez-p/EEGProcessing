% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function E_total = e_total(data, N, displacement)

% -------------------------------------------------------------------------
%   Esta función realiza el enventanado de los datos de entrada para
%   obtener, posteriormente, el logaritmo de la energía de cada ventana
%   logrando la energía total.
%
%   INPUT ---------------------------------------
%
%   data                    Estructura de datos de un sujeto
%
%   N                       Número de muestras por ventana
%
%   displacement            Solapamiento entre ventanas
%
%   OUTPUT --------------------------------------
%
%   E_total                 Energía total de cada ventana
%
% -------------------------------------------------------------------------


    data.windowed = cell(1,length(data.trial));
    E_total = cell(1,length(data.trial));

    for z = 1:length(data.trial)

        [f,c] = size(data.trial{z});
        max = 2*floor(c/N)-1; 

        m = 1;
        n = N;

        for x = 1:max

            data.windowed{z}{x} = data.trial{z}(:,m:n);

            n = n + displacement;
            m = m + displacement;

            E_total{z}(:,x) = log10(sum((data.windowed{z}{x}.^2),2)); %[dB]

        end

        % Últimas muestras cuyo tamaño es menor a una ventana N
        data.windowed{z}{max+1} = data.trial{z}(:,m:c);
        E_total{z}(:,max+1) = log10(sum((data.windowed{z}{max+1}.^2),2));

        for comp = 1:f
            if E_total{z}(comp,1:(max+1)) < 0
                E_total{z}(comp,1:(max+1)) = 0;
            end
        end
    end

end
