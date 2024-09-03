function [Q_hat, u_hat, err_critic, err_actor] = actor_critic_network(epsilon, u, W_ic, W_ia, Q, R)
    L = [epsilon; u];
    Q_hat = 0.5 * L' * W_ic * L;
    u_hat = W_ia' * epsilon;
    
    target_Q = 0.5 * (epsilon' * Q * epsilon + u' * R * u) + Q_hat;
    
    err_critic = target_Q - Q_hat;
    err_actor = u_hat - u;
end







