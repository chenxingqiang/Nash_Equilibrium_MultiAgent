#!/bin/bash

# 创建主目录
mkdir -p Nash_Equilibrium_MultiAgent

# 创建子目录
cd Nash_Equilibrium_MultiAgent
mkdir -p src lib tests results

# 在src目录中创建主要的源文件
touch src/system_model.m
touch src/tracking_error.m
touch src/q_function.m
touch src/optimal_policy.m
touch src/value_iteration.m
touch src/actor_critic.m
touch src/main.m

# 在lib目录中创建辅助函数文件
touch lib/initialize_params.m
touch lib/update_state.m

# 在tests目录中创建测试文件
touch tests/test_system_model.m
touch tests/test_tracking_error.m
touch tests/test_q_function.m
touch tests/test_optimal_policy.m
touch tests/test_value_iteration.m
touch tests/test_actor_critic.m

echo "项目结构创建完成"