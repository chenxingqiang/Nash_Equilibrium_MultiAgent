function [A, B, G, E, Q, R, D, initial_states] = initialize_params()
    % 系统动力学矩阵
    A = [0.995 0.09983; 0.09983 0.995];
    
    % 控制输入矩阵
    B = {[0.2; 0.1], [0.2047; 0.08984], [0.2097; 0.1897]};
    % 打印 B 的维度以进行验证
    for i = 1:length(B)
        disp(['B{', num2str(i), '} dimensions: ', num2str(size(B{i}))]);
    end
    
    % 领导者连接增益
    G = [1 0 0];
    
    % 连接矩阵
    E = [0 0.8 0.8; 0.7 0 0.6; 0 0 0];
    
    % 状态权重矩阵
    Q = eye(2);
    
    % 控制权重矩阵
    R = 1;   % 或者 R = 1; 如果所有智能体共享相同的R
    
    % 输入度矩阵
    D = diag(sum(E, 2));
    
    % 初始状态
    initial_states = 0.1 * randn(2, 3);
end