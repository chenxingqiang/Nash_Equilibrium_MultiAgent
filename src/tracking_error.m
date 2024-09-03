function error = tracking_error(states, i, E, G)
    n = size(states, 2);
    error = zeros(size(states, 1), 1);
    for j = 1:n
        if E(i,j) ~= 0
            error = error + E(i,j) * (states(:,j) - states(:,i));
        end
    end
    if G(i) ~= 0
        error = error + G(i) * (states(:,1) - states(:,i)); % Assuming first agent is the leader
    end
end
