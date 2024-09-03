function tests = test_actor_critic_network
    tests = functiontests(localfunctions);
end

function test_network_output(testCase)
    % 设置测试参数
    epsilon = [0.1; 0.2];
    u = 0.5;
    W_ic = [1 0.5 0.3; 0.5 1 0.4; 0.3 0.4 1];
    W_ia = [0.5; 0.7];
    Q_ii = eye(2);
    R_ii = 1;
    
    % 调用被测函数
    [Q_hat, u_hat, err_critic, err_actor] = actor_critic_network(epsilon, u, W_ic, W_ia, Q_ii, R_ii);
    
    % 计算预期结果
    L = [epsilon; u];
    expected_Q_hat = 0.5 * L' * W_ic * L;
    expected_u_hat = W_ia' * epsilon;
    expected_J_Q = 0.5 * (epsilon' * Q_ii * epsilon + u^2 * R_ii) + expected_Q_hat;
    expected_err_critic = 0.5 * norm(expected_J_Q - expected_Q_hat)^2;
    expected_err_actor = 0.5 * norm(expected_u_hat - u)^2;
    
    % 验证结果
    testCase.verifyEqual(Q_hat, expected_Q_hat, 'AbsTol', 1e-6, '估计的Q值不正确');
    testCase.verifyEqual(u_hat, expected_u_hat, 'AbsTol', 1e-6, '估计的控制输入不正确');
    testCase.verifyEqual(err_critic, expected_err_critic, 'AbsTol', 1e-6, '评论者网络误差计算不正确');
    testCase.verifyEqual(err_actor, expected_err_actor, 'AbsTol', 1e-6, '演员网络误差计算不正确');
end