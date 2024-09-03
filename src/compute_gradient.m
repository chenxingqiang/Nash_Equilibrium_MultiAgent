function grad = compute_gradient(W, epsilon, u)
    L = [epsilon; u];
    grad = W * L;
    grad = grad(1:end-1);  % 只保留与状态维度相同的部分
    
    disp(['Computed gradient dimensions: ', num2str(size(grad))]);
    disp(['Gradient value: ', mat2str(grad)]);
end