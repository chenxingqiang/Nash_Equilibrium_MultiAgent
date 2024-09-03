function grad_clipped = clip_gradient(gradient, max_norm)
    grad_norm = sqrt(sum(gradient(:).^2));
    if grad_norm > max_norm
        gradient = gradient * (max_norm / grad_norm);
    end
    grad_clipped = gradient;
end