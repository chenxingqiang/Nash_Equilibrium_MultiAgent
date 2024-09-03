function tests = test_system_dynamics
    tests = functiontests(localfunctions);
end

function test_state_update(testCase)
    % 设置测试参数
    A = [0.995 -0.09983; -0.09983 0.995];
    B = [0.2; 0.1];
    x = [1; 2];
    u = 0.5;
    
    % 调用被测函数
    [x_next, ~] = system_dynamics(x, u, A, B, [], []);
    
    % 计算预期结果
    expected_x_next = A * x + B * u;
    
    % 验证结果
    testCase.verifyEqual(x_next, expected_x_next, 'AbsTol', 1e-6, '状态更新不正确');
end

function test_error_update(testCase)
    % 设置测试参数
    A = [0.995 -0.09983; -0.09983 0.995];
    B = [0.2; 0.1];
    L = [1 -0.5; -0.5 1];
    G = [1 0; 0 0];
    epsilon = [0.1; 0.2];
    u = 0.5;
    
    % 调用被测函数
    [~, epsilon_next] = system_dynamics([], u, A, B, L, G);
    
    % 计算预期结果
    expected_epsilon_next = A * epsilon - (L + G) * B * u;
    
    % 验证结果
    testCase.verifyEqual(epsilon_next, expected_epsilon_next, 'AbsTol', 1e-6, '误差状态更新不正确');
end