% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

function [new_idx] = fta_sort_matrix(orig,matrix_to_sort)

% -------------------------------------------------------------------------
%   Esta función ordena las filas de una matriz con respecto a las filas de
%   otra matriz de referencia de forma que las distancias entre vectores
%   filas de una y otra sean las mínimas posibles, buscando la mejor
%   combinación.
%
%   INPUT ----------------------------------------------
%
%   orig                    Matriz de referencia
%
%   matrix_to_sort          Matriz a ordenar
%
%   OUTPUT ---------------------------------------------
%
%   new_idx                 Vector que contiene el nuevo orden de las filas
%
% -------------------------------------------------------------------------


    distance = [];
    channels_number = length(orig);
    stage = 1;
    
    for j = 1:channels_number
        for a = 1:channels_number
            aux_matrix(a,:) = orig(j,:) - matrix_to_sort(a,:);
        end
        distance(:,j) = sum(abs(aux_matrix'))';
    end
    
    [sorted_dist, perm] = sort(distance);
    new_comp_idx = perm(1,:);
    new_comp_idx_aux(stage,:) = new_comp_idx;
    stage_dist = sorted_dist(1, :);
    
    while ~(length(unique(new_comp_idx)) == length(new_comp_idx))
        
        idx_next_stage = [];
        
        for a = 1:channels_number
            
            repeated_idx = find(new_comp_idx_aux(stage,:) == a);
            if length(repeated_idx) > 1
                [min_val, pos] = min(stage_dist(repeated_idx));
                idx_next_stage = repeated_idx(find(repeated_idx ~= find(stage_dist == min_val)));
                new_comp_idx(idx_next_stage) = perm(stage+1, idx_next_stage);
                
            end
            stage_dist(idx_next_stage) = sorted_dist(stage+1, idx_next_stage);
        end
        
        stage = stage + 1;
        new_comp_idx_aux(stage,:) = new_comp_idx;
        
    end
    
    new_idx = new_comp_idx;
    
end

