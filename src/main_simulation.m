function main_simulation()
% 初始化参数
[A, B, G, E, Q, R, D, initial_states] = initialize_params();


% 仿真参数
T = 10000; % 时间步数
num_agents = size(initial_states, 2);

% 初始化存储结果的数组
states = zeros(size(initial_states, 1), num_agents, T);
errors = zeros(size(initial_states, 1), num_agents, T);
controls = zeros(1, num_agents, T);
W_ic_history = cell(num_agents, T);
W_ia_history = cell(num_agents, T);

% 初始化Actor-Critic网络权重
W_ic = cell(1, num_agents);
W_ia = cell(1, num_agents);
for i = 1:num_agents
    state_dim = size(initial_states, 1);
    W_ic{i} = 0.001 * randn(state_dim + 1, state_dim + 1);
    W_ia{i} = 0.001 * randn(state_dim, 1);
end

% 初始化状态
states(:,:,1) = initial_states;

% 学习率参数
learning_rate = 0.0001;
decay_rate = 0.9999;

% 主循环

for t = 1:T-1
    % 计算跟踪误差
    for i = 1:num_agents
        errors(:,i,t) = tracking_error(states(:,:,t), i, E, G);
    end

    controls = zeros(1, num_agents, T);

    % 对每个智能体进行迭代
    for i = 1:num_agents
        % 计算Mi矩阵
        if iscell(R)
            Rii = R{i};
        else
            Rii = R;
        end
        disp(['Agent ', num2str(i), ':']);
        disp(['errors(:,i,t) dimensions: ', num2str(size(errors(:,i,t)))]);
        disp(['errors(:,i,t) value: ', mat2str(errors(:,i,t))]);
        disp(['controls(1,i,t) value: ', num2str(controls(1,i,t))]);
        disp(['Q dimensions: ', num2str(size(Q))]);
        disp(['Rii value: ', num2str(Rii)]);
        disp(['W_ic{i} dimensions: ', num2str(size(W_ic{i}))]);
        disp(['W_ia{i} dimensions: ', num2str(size(W_ia{i}))]);
        Mi = compute_Mi(Rii, G(i), D(i,i), E, B{i}, i);
            disp(['Mi in main_simulation: ', num2str(size(Mi))]);
            disp(['Mi value in main_simulation: ', num2str(Mi)]);

            [Q_i, u_i] = value_iteration(errors(:,i,t), controls(1,i,t), Q, Rii, W_ic{i}, W_ia{i}, Mi, find_neighbors(E, i), R, E, B);


        disp(['Q_i value: ', num2str(Q_i)]);
        disp(['u_i value: ', num2str(u_i)]);
        
        controls(1,i,t) = u_i; 

        % Actor-Critic更新
        [Q_hat, u_hat, err_critic, err_actor] = actor_critic_network(errors(:,i,t), controls(1,i,t), W_ic{i}, W_ia{i}, Q, Rii);

        % 梯度裁剪
        max_grad_norm = 0.1;
        grad_ic = clip_gradient(err_critic * W_ic{i}, max_grad_norm);
        grad_ia = clip_gradient(err_actor * W_ia{i}, max_grad_norm);

        % 更新权重
        W_ic{i} = W_ic{i} - learning_rate * grad_ic;
        W_ia{i} = W_ia{i} - learning_rate * grad_ia;

        % 更新控制输入
        controls(1,i,t) = u_i;

        % 保存权重历史
        W_ic_history{i, t} = W_ic{i}(:);
        W_ia_history{i, t} = W_ia{i}(:);
    end

    % 更新系统状态
    for i = 1:num_agents
        states(:,i,t+1) = system_dynamics(states(:,i,t), controls(1,i,t), A, B{i});
    end

    % 衰减学习率
    learning_rate = learning_rate * decay_rate;
end

% 绘制结果
plot_all_results(states, errors, controls, W_ic_history, W_ia_history);
end