clear;

% Input image
tools = few256;

% smooth tools
tools_smoothed = discgaussfft(tools, 4);

% 1 for the simple differences operator
% 2 for the central differences operator
% 3 for the Roberts cross edge operator
% 4 for the Sobel operator
gradmagntools_1 = sqrt(Lv(tools_smoothed, 1));
gradmagntools_2 = sqrt(Lv(tools_smoothed, 2));
gradmagntools_3 = sqrt(Lv(tools_smoothed, 3));
gradmagntools_4 = sqrt(Lv(tools_smoothed, 4));

figure

subplot(2,2,1);
showgrey(gradmagntools_1);
title('SDO')

subplot(2,2,2);
showgrey(gradmagntools_2);
title('CDO')

subplot(2,2,3);
showgrey(gradmagntools_3);
title('Roberts')

subplot(2,2,4);
showgrey(gradmagntools_4);
title('Sobel')


figure
subplot(2,2,1);
hist(gradmagntools_1);
title('SDOs histogram')

subplot(2,2,2);
hist(gradmagntools_2);
title('CDOs histogram')

subplot(2,2,3);
hist(gradmagntools_3);
title('Roberts histogram')

subplot(2,2,4);
hist(gradmagntools_4);
title('Sobel histogram')


% Threshold on first component
figure
threshold_1 = 25;
threshold_2 = 15;
threshold_3 = 30;
threshold_4 = 100;

subplot(2,2,1);
showgrey((gradmagntools_1 - threshold_1) > 0);
str_1 = sprintf('SDO thresholded to %d', threshold_1);
title(str_1)

subplot(2,2,2);
showgrey((gradmagntools_2 - threshold_2) > 0);
str_2 = sprintf('CDO thresholded to %d', threshold_2);
title(str_2)

subplot(2,2,3);
showgrey((gradmagntools_3 - threshold_3) > 0);
str_3 = sprintf('Roberts thresholded to %d', threshold_3);
title(str_3)

subplot(2,2,4);
showgrey((gradmagntools_4 - threshold_4) > 0);
str_4 = sprintf('Sobel thresholded to %d', threshold_4);
title(str_4)



% Threshold on second component

figure
threshold_1 = 52;
threshold_2 = 27;
threshold_3 = 65;
threshold_4 = 180;

subplot(2,2,1);
showgrey((gradmagntools_1 - threshold_1) > 0);
str_1 = sprintf('SDO thresholded to %d', threshold_1);
title(str_1)

subplot(2,2,2);
showgrey((gradmagntools_2 - threshold_2) > 0);
str_2 = sprintf('CDO thresholded to %d', threshold_2);
title(str_2)

subplot(2,2,3);
showgrey((gradmagntools_3 - threshold_3) > 0);
str_3 = sprintf('Roberts thresholded to %d', threshold_3);
title(str_3)

subplot(2,2,4);
showgrey((gradmagntools_4 - threshold_4) > 0);
str_4 = sprintf('Sobel thresholded to %d', threshold_4);
title(str_4)
