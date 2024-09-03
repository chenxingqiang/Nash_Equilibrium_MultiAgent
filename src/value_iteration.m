function [Q_new, u_new] = value_iteration(epsilon, u_old, Q, R, W_ic, W_ia, Mi, Ni, Rij, E, B)

disp(['epsilon dimensions: ', num2str(size(epsilon))]);
disp(['u_old dimensions: ', num2str(size(u_old))]);

Q_old = q_function(epsilon, u_old, Q, R, W_ic);
grad_Q = compute_gradient(W_ic, epsilon, u_old);

disp(['Mi dimensions in value_iteration: ', num2str(size(Mi))]);
disp(['Mi value in value_iteration: ', num2str(Mi)]);
disp(['grad_Q dimensions: ', num2str(size(grad_Q))]);

if numel(Mi) ~= 1
    error('Mi should be a scalar, but its size is %s', mat2str(size(Mi)));
end

u_new = Mi * sum(grad_Q);  % 使用 sum 来确保 u_new 是标量

disp(['u_new dimensions: ', num2str(size(u_new))]);
disp(['u_new value: ', num2str(u_new)]);

Q_new = q_function(epsilon, u_new, Q, R, W_ic);

neighbor_contribution = 0;
for j = Ni
    if iscell(Rij)
        Rij_j = Rij{j};
    else
        Rij_j = Rij;
    end
    Mj = compute_Mi(Rij_j, 0, 0, E, B{j}, j);
    neighbor_contribution = neighbor_contribution + grad_Q' * Mj * Rij_j * Mj * grad_Q;
end

Q_new = Q_new + 0.5 * epsilon' * Q * epsilon + ...
    0.5 * grad_Q' * Mi * R * Mi * grad_Q + ...
    0.5 * neighbor_contribution;

Q_new = min(max(Q_new, -1e5), 1e5);

disp(['Final Q_new value: ', num2str(Q_new)]);
end