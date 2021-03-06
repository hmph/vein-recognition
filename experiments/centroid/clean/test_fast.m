images_per_user = 6;
users = 100;
num_clusters = 60;
threshold = 300;

history = [];
count = 1;

for num_clusters = [160]

    thresh = [1:0.25:20];
    %thresh = [thresh 300:50:600];

%     clus1 = train_cluster(images_per_user, users, num_clusters, veins, [1, 2, 3, 4, 5]);
%     clus2 = train_cluster(images_per_user, users, num_clusters, veins, [0, 2, 3, 4, 5]);
%     clus3 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 3, 4, 5]);
%     clus4 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 4, 5]);
%     clus5 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 3, 5]);
%     clus6 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 3, 4]);
% 
%     [distances_centroid, imp_distances_centroid] = distance_matrix( clus1, clus2, clus3, clus4, clus5, clus6, veins, veins_unreg );
    
    correct_record = [];
    correct_neg_record = [];
    far_record = [];
    frr_record = [];
    wrong_rec_record = [];
    
    for threshold = thresh

        correct = zeros(length(veins),1);
        correct_neg = zeros(length(veins),1);
        far = zeros(length(veins),1);
        frr = zeros(length(veins),1);
        wrong_recognised = zeros(length(veins),1); % Special case of far I guess
        counter = 1;

       % for k = 0:(users-1)
            %Test with samples 2 and 5 which we did not train with
        %    for j = [k*images_per_user+2 k*images_per_user+5]
             for j = 1:length(veins)   % Can do this since the distance matrix has been set up correctly
                dis = distances_centroid(j,:);
                [dis, idx] = sort(dis, 'ascend');
                val = dis(1);
                id = idx(1);

                if (val > threshold)
                    id = -1;
                end

                if (id == ceil(j/6))
                    correct(j) = 1;
                elseif (id == -1)
                    frr(j) = 1;
                else
                    wrong_recognised(j) = 1;
                end 

                if (mod(j,100) == 0)
                   fprintf('%i\n', j); 
                end    
             end   
       %     end
       % end

        for j = 1:length(veins_unreg)

            dis = imp_distances_centroid(j,:);
            [dis, idx] = sort(dis, 'ascend');
            val = dis(1);
            id = idx(1);

            if (val > threshold)
                id = -1;
            end

            if (id == -1)
                correct_neg(j) = 1;
            else
                if (val > threshold)
                    disp('wtf');
                end
                far(j) = 1;
                fprintf('Incorrect. Should not have accepted %d. Identified as %d. Distance was %0.3f\n',j, id, val);
            end

        end

    %     correct / 200
    %     correct_neg / 600
    %     correct_array = [correct_array correct];
    %     correct_neg_array = [correct_neg_array correct_neg];
    %     far_record = [far_record far];
    %     frr_record = [frr_record frr];

        correct_record = [correct_record correct];
        correct_neg_record = [correct_neg_record correct_neg];
        far_record = [far_record far];
        frr_record = [frr_record frr];
        wrong_rec_record = [wrong_rec_record wrong_recognised];

        counter = counter + 1;
    end

    sum (correct_record)
    sum (correct_neg_record)
    
    history(count).centroids_per_cluster = num_clusters;
    history(count).correct_record = correct_record;
    history(count).correct_neg_record = correct_neg_record;
    history(count).far_record = far_record;
    history(count).frr_record = frr_record;
    history(count).wrong_rec_record = wrong_rec_record;
    count = count + 1;
    
    save test_data history
end
