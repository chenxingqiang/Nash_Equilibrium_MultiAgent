function Q_value = q_function(epsilon, u, Q, R, W_ic)
    L = [epsilon; u];
    disp(['L dimensions in q_function: ', num2str(size(L))]);
    disp(['W_ic dimensions in q_function: ', num2str(size(W_ic))]);
    
    % 确保维度匹配
    if size(W_ic, 1) ~= size(L, 1) || size(W_ic, 2) ~= size(L, 1)
        disp('Adjusting W_ic dimensions');
        if size(L, 1) > size(W_ic, 1)
            % 如果 L 更大，扩展 W_ic
            W_ic_new = zeros(size(L, 1), size(L, 1));
            W_ic_new(1:size(W_ic,1), 1:size(W_ic,2)) = W_ic;
            W_ic = W_ic_new;
        else
            % 如果 W_ic 更大，裁剪 W_ic
            W_ic = W_ic(1:size(L,1), 1:size(L,1));
        end
    end
    
    disp(['Adjusted W_ic dimensions: ', num2str(size(W_ic))]);
    
    Q_value = 0.5 * L' * W_ic * L;
    
    disp(['Computed Q_value: ', num2str(Q_value)]);
end