

function U = utility(e, u, Q, R)
    U = -0.5 * (e' * Q * e + u' * R * u);  % 注意这里使用负号，因为我们要最大化效用
end