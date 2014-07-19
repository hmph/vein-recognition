function [ x y ] = scatter_plot( branches, plot )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

    if (nargin < 2)
       plot = 0; 
    end
    
    x = zeros ( sum (sum (branches) ), 1 );
    y = zeros ( sum ( sum(branches) ), 1 );
    index = 1;
    
    for row = 1:size (branches, 1)
        for col = 1:size (branches, 2)
           
            if (branches(row, col) == 1)
                x(index) = col;
                y(index) = row;
                index = index + 1;
            end
        end
    end
    
    if (plot)
        figure
        scatter (x, y);
    end
end

