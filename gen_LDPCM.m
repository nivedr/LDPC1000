function [ LDPCM ] = gen_LDPCM( lambda, rho, n, k )
% Generate the LDPC matrix from lambda, rho, n & k
% Algorithm used is a variation of the Neal Mckay construction in such a
% way as to eliminate 4-cycles

    LDPCM = zeros(n-k,1);
    % degrees with at-least 1 edge in that category
    idx = find(fliplr(lambda));
    
    % Fill up the higher degree columns first
    check_degrees = fliplr(idx-1);
    counts = fliplr(n*lambda(length(lambda) - idx + 1));
    
    retry = 0;
    
    get_degree_index = @(index) find(cumsum(counts) >= index, 1);
    
    % bad_set for a column is inititalized to those rows (bits) that are already
    % filled with corresponding number of 1's (saturated)
    
    column = 1;
    while column <= n
        % exclude saturated check nodes
        bad_set = query_row(LDPCM, rho);
        disp(column);
        % set of 4-cycle rows
        worse_set = [];
        
        % iterate, spanning the number of check nodes that need to be placed in that column
        for i = 1:check_degrees(get_degree_index(column))
       
            % find the new row to put a bit in. It shouldn't come from bad_set or worse_set
            if ~isempty(setdiff(1:n-k, union(bad_set,worse_set)))
                row = datasample(setdiff(1:n-k, union(bad_set,worse_set)), 1);
            % if there are no rows, restart filling the column. If failure
            % after 5 attempts, modify ? slightly to allow more higher
            % degree columns and continue filling into these columns
            else
                if retry >= 5
                    disp('Snipping edge to meet 4-cycle constraint');
                    rho(1) = rho(1) + 1/(n-k);    % add 1 higher degree CN
                    rho(2) = rho(2) - 1/(n-k);    % remove 1 lower degree CN
                    retry = 0;                    % fresh start
                end
                retry = retry + 1;
                LDPCM = LDPCM(:,1:column-1);
                column = column-1;
                disp('Retrying to hopefully avoid errors due to randomness');
                break;
            end
            % Add the '1' to the row chosen
            LDPCM(row, column) = 1;
            
            % row is the row in which the new bit was placed
            % add the row itself and corresponding new 4-cycle rows to bad_set
            worse_set = unique(cat(2, worse_set, query_4C(LDPCM, row)));
        end
        column = column + 1;
    end
end

