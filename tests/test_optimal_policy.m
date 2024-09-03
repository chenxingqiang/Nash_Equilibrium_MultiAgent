function test_optimal_policy()
    % 初始化参数
    [A, B, ~, ~, ~, ~, ~] = initialize_params();
    
    % 测试用例
    epsilon = [1; 2];
    H_i = [1, 2, 3; 4, 5, 6; 7, 8, 9];
    
    % 计算预期结果
    H_uu = H_i(3, 3);
    H_ue = H_i(3, 1:2);
    expected_u = -inv(H_uu) * H_ue * epsilon;
    
    % 调用被测函数
    u = optimal_policy(epsilon, H_i);
    
    % 验证结果
    assert(abs(u - expected_u) < 1e-6, '最优策略测试失败');
    
    disp('最优策略测试通过');
end