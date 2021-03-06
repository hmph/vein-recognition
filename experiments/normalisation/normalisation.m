% From page 3 of the Intech Vein recognition book

function [ image ] = normalisation( image, m0, var0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    im_mean = mean2 (image);
    im_var =  ( sum(sum((image - im_mean).^2)) ) / (size(image, 1) * size(image, 2) );
    
    for row = 1:size(image, 1)
        for col = 1:size(image, 2)
            
            if (image(row, col) > im_mean)
                image(row, col) = m0 + sqrt (double(var0 / im_var * (image(row,col) - im_mean)^2 ) );
            else
                image(row, col) = m0 - sqrt (double(var0 / im_var * (image(row,col) - im_mean)^2  ) );
            end           
        end
    end

end

