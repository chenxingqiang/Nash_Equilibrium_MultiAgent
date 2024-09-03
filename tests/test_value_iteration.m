function tests = test_value_iteration
    tests = functiontests(localfunctions);
end

function test_value_update(testCase)
    % 设置测试参数
    Q_old = 1;
    u_old = 0.5;
    epsilon = [0.1; 0.2];
    epsilon_next = [0.05; 0.1];
    U_i = @(e, u) 0.5 * (e' * e + u^2);
    
    % 调用被测函数
    [Q_new, u_new] = value_iteration(Q_old, u_old, epsilon, epsilon_next, U_i);
    
    % 计算预期结果
    expected_Q_new = Q_old + U_i(epsilon, u_old);
    
    % 验证结果
    testCase.verifyEqual(Q_new, expected_Q_new, 'AbsTol', 1e-6, 'Q值更新不正确');
    testCase.verifyTrue(isscalar(u_new), '更新的控制输入应该是标量');
end