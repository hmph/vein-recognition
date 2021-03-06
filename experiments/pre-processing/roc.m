% Calcualtes the ROC curve I guess

% False rejection rate
frr = false_rejection_record(:,1) ./ length(veins);
frr_adjusted = (false_rejection_record(:,1) - outlier_frr_record(:,1)) ./ (length(veins) - outlier_frr_record(:,1));

% I screwed up here. My denominator should include the false acceptances
% when I was testing against positive cases. 
far = false_acceptance_record(:,1) ./ length(veins_unreg);
far_adjusted = (false_acceptance_record(:,1) - outlier_far_record(:,1)) ./ (length(veins_unreg) - outlier_far_record(:,1));

gar = ( correct_record(:,1) + correct_neg_record(:,1) ) ./ ( length(veins) +  length(veins_unreg) );
gar_adjusted = (correct_record(:,1) + correct_neg_record(:,1) ) ./ ( length(veins) +  length(veins_unreg) - outlier_far_record(:,1) - outlier_frr_record(:,1) );

positive_detection = correct_record(:,1) ./ length(veins);
positive_detection_adjusted = correct_record(:,1) ./ (length(veins) - outlier_far_record(:,1) - outlier_frr_record(:,1));
negative_detection = correct_neg_record(:,1) ./ length(veins);

figure 
plot (frr.*100, far.*100, 'blue');
hold on
plot (frr_adjusted.*100, far_adjusted.*100, 'red');

% create the line y=x to work out the Equal Error Rate
x = ones(100, 1);
x = cumsum(x);
plot (x, x, 'green');
legend ('ROC curve with outliers', 'ROC curve without outliers', 'Equal Error Rate');
xlabel ('False Rejection Rate');
ylabel ('False Acceptance Rate');

% Lets plot the GAR, with the threshold being used
figure
plot (thresholds, gar, 'blue');
hold on 
plot (thresholds, gar_adjusted, 'red');
legend ('General acceptance rate', 'Adjusted general acceptance rate', 'Location', 'SouthEast');
xlabel('Threshold');
ylabel('Accuracy');

figure
plot (thresholds, positive_detection, 'blue');
hold on
plot (thresholds, positive_detection_adjusted, 'green');
plot (thresholds, negative_detection, 'red');
legend ('Correct positives detected', 'Correct positives adjusted with outliers', 'Correct negatives detected', 'Location', 'SouthEast');
xlabel('Threshold');
ylabel('Accuracy');