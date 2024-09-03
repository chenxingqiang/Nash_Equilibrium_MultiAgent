function run_all_tests()
    test_system_model();
    test_tracking_error();
    test_q_function();
    test_optimal_policy();
    test_value_iteration();
    test_actor_critic_network();
    integration_test();
    
    disp('所有测试通过');
end