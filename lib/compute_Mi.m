function Mi = compute_Mi(Rii, gi, di, E, Bi, i)
    n = size(E, 2);
    eji = E(i, :);  % 获取第i行，这代表了当前智能体与其他智能体的连接
    eji(i) = [];    % 移除自身的连接
    Mi_temp = [gi + di, -eji];
    
    disp(['Mi_temp dimensions: ', num2str(size(Mi_temp))]);
    disp(['Bi dimensions: ', num2str(size(Bi))]);
    disp(['Rii value: ', num2str(Rii)]);
    
    Mi = (Mi_temp(1:2) * Bi) / Rii;  % 只使用前两个元素
    
    disp(['Computed Mi dimensions: ', num2str(size(Mi))]);
    disp(['Mi value: ', num2str(Mi)]);
end