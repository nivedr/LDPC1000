function [ VN, CN ] = gen_decoder( LDPCM )
% Generate bit node and check node object instances and create edges based
% on the LDPC matrix. This function is only to speeden up the process of
% SPA evaluation so that the decoder need not be generated every time a
% received vector is evaluated.
    
    % remove redundant check nodes in the LDPC matrix
    %LDPCM = unique(LDPCM, 'rows');
    
    for i = 1:size(LDPCM,2)
        VN(i) = bitnode();
    end
    
    for i = 1:size(LDPCM,1)
        CN(i) = checknode();
        for j = 1:size(LDPCM,2)
            if LDPCM(i,j) == 1
                addEdge(CN(i),VN(j));
            end
        end
    end

end

