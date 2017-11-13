classdef bitnode < handle
% bitnode class implementation
    properties
        edges = edge.empty;
    end
    
    methods
        % For the 1st iteration of SPA, init edges of a node with the received bit
        function initMessage(mynode, y)
            for i = 1:length(mynode.edges)
                mynode.edges(i).BIT = y;
            end
        end
    
        % Output the estimate for the codeword at the current iteration
        function y_est = getEstimate(mynode,init)
            if init ~=2
                y_est = init;
                return;
            end
            for i = 1:length(mynode.edges)
                if mynode.edges(i).BIT ~= 2
                    y_est = mynode.edges(i).BIT;
                    break;
                else
                    y_est = 2;
                end
            end
        end
        
        % Pass message from the VN to CN. init is the received vector and
        % is used for the channel LLR term (here it is simply 0/1/e(2), since
        % the LLR can be equated to one of the 3)
        function passMessage(mynode,init)
            tempBIT = zeros(1,length(mynode.edges));
            if init ~=2
                for i = 1:length(mynode.edges)
                    mynode.edges(i).BIT = init;
                end
                return;
            end
            for i = 1:length(mynode.edges)
                % iterate over other neighboring edges to get message
                for j = setdiff(1:length(mynode.edges),i)
                    if mynode.edges(j).BIT ~= 2
                        tempBIT(i) = mynode.edges(j).BIT;
                        break;
                    else
                        tempBIT(i) = 2;
                    end
                end
            end
            for i = 1:length(mynode.edges)
                mynode.edges(i).BIT = tempBIT(i);
            end
        end
        
    end
end