
function next_state = system_dynamics(current_state, control_input, A, B)
    next_state = A * current_state + B * control_input;
end
