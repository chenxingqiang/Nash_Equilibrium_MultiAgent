function plot_all_results(states, errors, controls, W_ic_history, W_ia_history)
    % 确保 result 目录存在
    if ~exist('result', 'dir')
        mkdir('result');
    end

    T = size(states, 3);
    num_agents = size(states, 2);

    % 1. Critic权重和Actor权重的变化
    figure('Position', [100, 100, 1200, 800]);
    for i = 1:num_agents
        subplot(2, num_agents, i);
        W_ic_agent = cell2mat(W_ic_history(i, :));
        if ~isempty(W_ic_agent)
            plot(1:size(W_ic_agent, 2), W_ic_agent');
            title(['Agent ', num2str(i), ' Critic Weights']);
            xlabel('Time Step');
            ylabel('Weight Value');
        else
            text(0.5, 0.5, 'No data', 'HorizontalAlignment', 'center');
        end
        subplot(2, num_agents, i + num_agents);
        W_ia_agent = cell2mat(W_ia_history(i, :));
        if ~isempty(W_ia_agent)
            plot(1:size(W_ia_agent, 2), W_ia_agent');
            title(['Agent ', num2str(i), ' Actor Weights']);
            xlabel('Time Step');
            ylabel('Weight Value');
        else
            text(0.5, 0.5, 'No data', 'HorizontalAlignment', 'center');
        end
    end
    saveas(gcf, fullfile('result', 'weights_change.png'));
    close;

    % 2. 跟踪误差动态对比
    figure('Position', [100, 100, 1200, 800]);
    for i = 1:num_agents
        subplot(num_agents, 1, i);
        plot(1:T, squeeze(errors(:, i, :))');
        title(['Agent ', num2str(i), ' Tracking Error']);
        xlabel('Time Step');
        ylabel('Error');
        legend('e1', 'e2');
    end
    saveas(gcf, fullfile('result', 'tracking_errors.png'));
    close;

    % 3. 智能体动态对比
    figure('Position', [100, 100, 1200, 800]);
    for i = 1:num_agents
        subplot(num_agents, 1, i);
        plot(1:T, squeeze(states(:, i, :))');
        title(['Agent ', num2str(i), ' State']);
        xlabel('Time Step');
        ylabel('State');
        legend('x1', 'x2');
    end
    saveas(gcf, fullfile('result', 'agent_states.png'));
    close;

    % 4. 控制输入变化
    figure('Position', [100, 100, 1200, 800]);
    for i = 1:num_agents
        subplot(num_agents, 1, i);
        plot(1:T, squeeze(controls(1, i, :)));
        title(['Agent ', num2str(i), ' Control Input']);
        xlabel('Time Step');
        ylabel('Control');
    end
    saveas(gcf, fullfile('result', 'control_inputs.png'));
    close;
end