function [ bad_set ] = query_row( LDPCM, rho )

    if size(LDPCM,2) == 1
        bad_set = [];
        return;
    end
    idx = find(fliplr(rho));
    check_degrees = idx-1;
    % n-k = size(LDPCM,1)
    counts = size(LDPCM,1)*rho(length(rho) - idx + 1);
    bad_set = [];

    get_degree_index = @(index) find(cumsum(counts) >= index, 1);

    for i = 1:size(LDPCM,1)
        % check if the current degree of the row corresponding to that bit node
        % is equal to the threshold. If yes, the bit node is saturated
        %     current degree        total degree of that bit node
        if sum(LDPCM(i,:) == 1) >= check_degrees(get_degree_index(i))
            bad_set = [bad_set , i];
        end
    end
end

