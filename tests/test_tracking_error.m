function test_tracking_error()
    % 初始化参数
    [~, ~, G, E, ~, ~, ~] = initialize_params();
    
    % 测试用例
    states = [1, 2, 3; 4, 5, 6];
    i = 2;
    
    % 计算预期结果
    expected_epsilon = E(i, 1) * (states(:, 1) - states(:, i)) + ...
                       E(i, 3) * (states(:, 3) - states(:, i)) + ...
                       G(i, i) * (states(:, 1) - states(:, i));
    
    % 调用被测函数
    epsilon = tracking_error(states, i, E, G);
    
    % 验证结果
    assert(all(abs(epsilon - expected_epsilon) < 1e-6), '跟踪误差测试失败');
    
    disp('跟踪误差测试通过');
end