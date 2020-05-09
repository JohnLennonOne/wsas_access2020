function attr_details = get_attr_details(i)

load('/data3/nanyi_fei/sigir19/cub/total_attr.mat');
load('~/Desktop/sigir19/pre_work/data/attr_semantic_origin.mat');
load('~/Desktop/sigir19/pre_work/data/attr_semantic.mat');
original_attr = find(total_attr(i, :) > 0)';

attr_details = cell(0, 4);
for oai = 1:length(original_attr)
    cell_tmp = cell(1, 4);
    attr_idx_origin = original_attr(oai);
    
    % beak
    if attr_idx_origin >= 279 && attr_idx_origin <= 293
        attr_idx = attr_idx_origin - 266;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'beak';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % crown
    if attr_idx_origin >= 294 && attr_idx_origin <= 308
        attr_idx = attr_idx_origin - 266;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'crown';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % eye
    if attr_idx_origin >= 136 && attr_idx_origin <= 149
        attr_idx = attr_idx_origin - 93;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'eye';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % belly
    if attr_idx_origin >= 198 && attr_idx_origin <= 212
        attr_idx = attr_idx_origin - 141;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'belly';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % upper tail
    if attr_idx_origin >= 80 && attr_idx_origin <= 94
        attr_idx = attr_idx_origin + 2;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'upper-tail';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % under tail
    if attr_idx_origin >= 168 && attr_idx_origin <= 182
        attr_idx = attr_idx_origin - 71;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'under-tail';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % back
    if attr_idx_origin >= 59 && attr_idx_origin <= 73
        attr_idx = attr_idx_origin + 57;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'back';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % wing
    if attr_idx_origin >= 10 && attr_idx_origin <= 24
        attr_idx = attr_idx_origin + 125;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'wing';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % breast
    if attr_idx_origin >= 106 && attr_idx_origin <= 120
        attr_idx = attr_idx_origin + 57;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'breast';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
    % leg
    if attr_idx_origin >= 264 && attr_idx_origin <= 278
        attr_idx = attr_idx_origin - 86;
        if ~strcmp(attr_semantic_origin(attr_idx_origin), attr_semantic(attr_idx))
            fprintf('Error!!!\n');
            break;
        end
        cell_tmp{1, 1} = 'leg';
        cell_tmp{1, 2} = attr_idx_origin;
        cell_tmp{1, 3} = attr_idx;
        cell_tmp{1, 4} = attr_semantic(attr_idx);
        attr_details = [attr_details; cell_tmp];
    end
    
end

for j = 1:(size(attr_details, 1) - 1)
    for k = 1:(size(attr_details, 1) - j)
        if attr_details{k, 3} > attr_details{k+1, 3}
            cell_tmp = attr_details(k, :);
            attr_details(k, :) = attr_details(k+1, :);
            attr_details(k+1, :) = cell_tmp;
        end
    end
end

end




















