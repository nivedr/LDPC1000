function [ CW_est, errors ] = SPA( VN, CN, CW )
% Run the sum-product (erasure filling algorithm) on the input vector based
% on the given decoder and output the per-iteration BER and the final
% decoded vector

    % maximum number of iterations to run the SPA decoder
    Imax = 100;
    count = 0;

    % Initialize the messages from VN to CN
    for i = 1:length(VN)
        VN(i).initMessage( CW(i) );
    end
    
    % Initialize the error as the input CW 2-weight
    errors = sum(CW==2);
    if sum(CW) == 0
        CW_est = CW;
        return;
    end
    
    % Pass CW through the message passing decoder
    while count < Imax
        for i = 1:length(CN)
            CN(i).passMessage();
        end
        
        for j = 1:length(VN)
            CW_est(j) = VN(j).getEstimate(CW(j));
        end
        
        for k = 1:length(VN)
            VN(k).passMessage(CW(k));
        end
        
        errors = [ errors , sum(CW_est==2) ];
        % If no erasures persist, return
        if sum(CW_est == 2) == 0
            break;
        end
        
        % If for the past 10 iterations, the weight of the current decoded
        % codeword has not changed, return with failure. This is purely for
        % faster runtime of the code and in some border cases may be
        % detrimental to performance.
        if length(errors) > 10
            if all(errors(end-9:end) == errors(end))
                disp('decoding failure. Stopping set reached');
                break;
            end
        end
        
        count = count + 1;
    end    
    
end

