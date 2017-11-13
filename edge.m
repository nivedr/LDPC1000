classdef edge < handle
    % edge class implementation. Has 3 members, head node, tail node & bit
    % value being transmitted over that edge. The member 'BIT' is ideally
    % an LLR, but for the erasure filling algorithm is equivalent to
    % 0/1/e(2)
    
    properties
        BIT;
    end
    
    properties
        C = checknode.empty;
        B = bitnode.empty;
    end
    
    methods
        % constructor
        function newedge = edge(end1, end2)
            if nargin > 0
                newedge.C = end1;
                newedge.B = end2;
                newedge.BIT = 0;
            end
        end
    end
end