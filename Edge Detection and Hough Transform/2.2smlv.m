clear;

% Input image
house = godthem256;

% smooth tools
house_smoothed = discgaussfft(house, 4);

% 1 for the simple differences operator
% 2 for the central differences operator
% 3 for the Roberts cross edge operator
% 4 for the Sobel operator
gradmagnhouse_1 = sqrt(Lv(house_smoothed, 1));
gradmagnhouse_2 = sqrt(Lv(house_smoothed, 2));
gradmagnhouse_3 = sqrt(Lv(house_smoothed, 3));
gradmagnhouse_4 = sqrt(Lv(house_smoothed, 4));

figure

subplot(2,2,1);
showgrey(gradmagnhouse_1);
title('SDO')

subplot(2,2,2);
showgrey(gradmagnhouse_2);
title('CDO')

subplot(2,2,3);
showgrey(gradmagnhouse_3);
title('Roberts')

subplot(2,2,4);
showgrey(gradmagnhouse_4);
title('Sobel')


figure
subplot(2,2,1);
hist(gradmagnhouse_1);
title('SDOs histogram')

subplot(2,2,2);
hist(gradmagnhouse_2);
title('CDOs histogram')

subplot(2,2,3);
hist(gradmagnhouse_3);
title('Roberts histogram')

subplot(2,2,4);
hist(gradmagnhouse_4);
title('Sobel histogram')


% Threshold on first component
figure
threshold_1 = 30;
threshold_2 = 15;
threshold_3 = 35;
threshold_4 = 100;

subplot(2,2,1);
showgrey((gradmagnhouse_1 - threshold_1) > 0);
str_1 = sprintf('SDO thresholded to %d', threshold_1);
title(str_1)

subplot(2,2,2);
showgrey((gradmagnhouse_2 - threshold_2) > 0);
str_2 = sprintf('CDO thresholded to %d', threshold_2);
title(str_2)

subplot(2,2,3);
showgrey((gradmagnhouse_3 - threshold_3) > 0);
str_3 = sprintf('Roberts thresholded to %d', threshold_3);
title(str_3)

subplot(2,2,4);
showgrey((gradmagnhouse_4 - threshold_4) > 0);
str_4 = sprintf('Sobel thresholded to %d', threshold_4);
title(str_4)



% Threshold on second component

figure
threshold_1 = 60;
threshold_2 = 30;
threshold_3 = 70;
threshold_4 = 200;

subplot(2,2,1);
showgrey((gradmagnhouse_1 - threshold_1) > 0);
str_1 = sprintf('SDO thresholded to %d', threshold_1);
title(str_1)

subplot(2,2,2);
showgrey((gradmagnhouse_2 - threshold_2) > 0);
str_2 = sprintf('CDO thresholded to %d', threshold_2);
title(str_2)

subplot(2,2,3);
showgrey((gradmagnhouse_3 - threshold_3) > 0);
str_3 = sprintf('Roberts thresholded to %d', threshold_3);
title(str_3)

subplot(2,2,4);
showgrey((gradmagnhouse_4 - threshold_4) > 0);
str_4 = sprintf('Sobel thresholded to %d', threshold_4);
title(str_4)
