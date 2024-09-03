function test_q_function()
    % 初始化参数
    [~, ~, ~, ~, Q, R, ~] = initialize_params();
    
    % 测试用例
    epsilon = [1; 2];
    u = 0.5;
    W_ic = [1, 2; 3, 4];
    
    % 计算预期结果
    L = [epsilon; u];
    expected_Q = 0.5 * L' * W_ic * L;
    
    % 调用被测函数
    Q_value = q_function(epsilon, u, Q, R, R, W_ic);
    
    % 验证结果
    assert(abs(Q_value - expected_Q) < 1e-6, 'Q函数测试失败');
    
    disp('Q函数测试通过');
end