%% MICRO PS1, UCL MRES ECON TERM 2
% Ziyi Wang
% This file try to solve the LP problem and solve for a correlated equil
% What I want to achieve:
%   Input the payoff matrix only and set the max or min
%   Output the probability distribution and value function

clear;
clc;
close all;

%% PARAMETERS
% payoff matrix
P1 = [0,5,4;4,0,5;5,4,0];
P2 = [0,4,5;5,0,4;4,5,0];

% number of prob we need to solve
n = size(P1,1)*size(P1,2);

%% Construct the problem (solver approach)

% Objective function
f = reshape(P1 + P2',1,[]); % a row vector containing sum of expected payoff

% Probability constraint
Aeq = ones(1,n);
beq = 1;

% Positive probability
lb = zeros(1,n);
ub = [];

%% Generate incentive compatitive constraint matrix

% For player 1
m = size(P1,1);
A0 = repmat(P1(1,:),m,1);
for i = 2:m
    a = repmat(P1(i,:),m,1);
    A0 = blkdiag(A0,a);
end

A1 = A0 - kron(eye(m),P1);

% delete rows of no deviation
A1 = A1(any(A1,2),:);

% converse to make constraints as standard form: var <= constant
A1 = -A1;

% Here I use the function from: http://www.cs.cmu.edu/~ggordon/CE/
A2 = -celp(P2);

% Now we combine them as the coefficient matrix for the LP problem
A = [A1;A2];

b = zeros(1,size(A,1));

%% Solve the LP
% linprog solves the minimization problem
[x_min,f_min] = linprog(f,A,b,Aeq,beq,lb);

% for the max problem
[x_max,f_max] = linprog(-f,A,b,Aeq,beq,lb);

%% 
A = [1 2 3
    2 2 2]