function u_optimal = optimal_policy(Q, epsilon, W_ia)
% 最优控制策略
% 输入:
%   Q: Q函数值
%   epsilon: 误差状态
%   W_ia: Actor网络权重
% 输出:
%   u_optimal: 最优控制输入

    % 使用Actor网络计算控制输入
    u_optimal = W_ia * epsilon;
    
    % 如果需要，可以在这里添加一些约束或处理
    % 例如，限制控制输入的范围
    % u_optimal = max(min(u_optimal, u_max), u_min);
end