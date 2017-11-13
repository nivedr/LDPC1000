classdef checknode < handle
% checknode class implementation
    properties
        edges = edge.empty;
    end
    
    methods
        % Function to add an edge between a CN and VN in the Tanner graph
        function addEdge(node1, node2)
            newedge = edge(node1, node2);
            
            node1.edges = cat(2, node1.edges, newedge);
            node2.edges = cat(2, node2.edges, newedge);
        end
        
        % Pass message from the CN to VN. This is based on the iterative
        % erasure filling algorithm
        function passMessage(mynode)
            tempBIT = zeros(1,length(mynode.edges));
            for i = 1:length(mynode.edges)
                % iterate over other neighboring edges to get message
                for j = setdiff(1:length(mynode.edges),i)
                    if mynode.edges(j).BIT == 2
                        tempBIT(i) = 2;
                        break;
                    end
                    % addition modulo 2 is equivalent to xor
                    % xor(0, x) = x : hence can init tempBIT(i) to 0
                    tempBIT(i) = xor(tempBIT(i), mynode.edges(j).BIT);
                end
            end
            for i = 1:length(mynode.edges)
                mynode.edges(i).BIT = tempBIT(i);
            end
        end
        
    end
end