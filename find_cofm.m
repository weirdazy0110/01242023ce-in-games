function A1 = find_cofm(P1)   
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
end