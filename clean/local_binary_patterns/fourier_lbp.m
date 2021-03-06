function [ flbp ] = fourier_lbp( histograms )
%fourier_lbp Computes fourier LBP features
% Described in Chapter 6 as well as Appendix A.2
%Each row is a histogram

flbp = histograms;

for row = 1:size(histograms,1)
    start = 3;
    finish = start + 8 - 1;
    while (finish < 58)
        flbp(row, start:finish) = abs(fft(histograms(row, start:finish)));
        start = start + 8;
        finish = start + 8 - 1;
    end
end

end

