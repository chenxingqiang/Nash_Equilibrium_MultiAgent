function [m, v, theta] = adam_update(m, v, theta, grad, lr, beta1, beta2, epsilon, t)
    m = beta1 * m + (1 - beta1) * grad;
    v = beta2 * v + (1 - beta2) * grad.^2;
    m_hat = m / (1 - beta1^t);
    v_hat = v / (1 - beta2^t);
    theta = theta - lr * m_hat ./ (sqrt(v_hat) + epsilon);
end