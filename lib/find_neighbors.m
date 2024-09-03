function neighbors = find_neighbors(E, i)
    neighbors = find(E(i,:) ~= 0);
    neighbors(neighbors == i) = [];  % 移除自身
end