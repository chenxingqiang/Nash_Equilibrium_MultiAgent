function test_system_model()
    % 初始化参数
    [A, B, ~, ~, ~, ~, ~] = initialize_params();
    
    % 测试用例
    x = [1; 2];
    u = 0.5;
    
    % 计算预期结果
    expected_x_next = A * x + B{1} * u;
    
    % 调用被测函数
    x_next = system_model(x, u, A, B{1});
    
    % 验证结果
    assert(all(abs(x_next - expected_x_next) < 1e-6), '系统模型测试失败');
    
    disp('系统模型测试通过');
end