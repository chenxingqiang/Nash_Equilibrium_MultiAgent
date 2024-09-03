% setup.m

function setup()
    % 获取当前脚本的路径
    current_path = fileparts(mfilename('fullpath'));
    
    % 添加项目目录到MATLAB路径
    addpath(genpath(current_path));
    
    % 检查并创建必要的目录
    directories = {'src', 'lib', 'tests', 'results'};
    for i = 1:length(directories)
        if ~exist(fullfile(current_path, directories{i}), 'dir')
            mkdir(fullfile(current_path, directories{i}));
            fprintf('Created directory: %s\n', directories{i});
        end
    end
    
    % 检查必要的工具箱
    required_toolboxes = {'Control System Toolbox', 'Optimization Toolbox'};
    missing_toolboxes = check_toolboxes(required_toolboxes);
    
    if ~isempty(missing_toolboxes)
        warning('The following toolboxes are missing:');
        for i = 1:length(missing_toolboxes)
            warning('  - %s', missing_toolboxes{i});
        end
        warning('Some functionality may be limited.');
    end
    
    % 初始化随机数生成器,以确保结果可重现
    rng(42);
    
    % 设置默认图形属性
    set(0, 'DefaultFigureColor', 'white');
    set(0, 'DefaultAxesFontSize', 12);
    set(0, 'DefaultLineLineWidth', 1.5);
    
    fprintf('Setup completed successfully.\n');
    fprintf('Project is ready to run.\n');
end

function missing_toolboxes = check_toolboxes(required_toolboxes)
    missing_toolboxes = {};
    for i = 1:length(required_toolboxes)
        if ~license('test', required_toolboxes{i})
            missing_toolboxes{end+1} = required_toolboxes{i};
        end
    end
end