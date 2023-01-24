% Build the linear inequalities that represent the rationality constraints
% for a player with payoff matrix R.  Constraints are returned in the
% matrix A: if P is the probability distribution over joint actions (a
% matrix of the same size as R), and if X=P(:), the constraints are
% A * X >= 0.

function [A] = celp(R)

[n, m] = size(R);
A = zeros(n*(n-1), n*m);

for i = 1:n
  for j = [1:i-1 i+1:n]
    constr = R(i,:) - R(j,:);
    A((i-1)*(n-1) + j - (j>i), i:m:end) = constr;
  end
end

return