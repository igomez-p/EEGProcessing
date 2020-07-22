% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

%% PROMEDIO Y PORCENTAJE DE MATRICES DE CONFUSIÓN PARA UNA CANCIÓN

% ESCOGER SEGÚN LOS DATOS USADOS

 Tabla = T9ica1;
% Tabla = T9eeg1;

%% PARA UNA CANCIÓN (2 pistas)

unos = length(find(Tabla.Tipo == 1));  % Número de 1's
ceros = length(find(Tabla.Tipo == 0)); % Número de 0's

M = [ceros ceros; unos unos];

%% PARA TODAS LAS CANCIONES (5 pistas)

% ceros = length(find(Tabla.Tipo == 0));
% unos = length(find(Tabla.Tipo == 1));
% dos = length(find(Tabla.Tipo == 2));
% tres = length(find(Tabla.Tipo == 3));
% cuatro = length(find(Tabla.Tipo == 4));
% 
% M = [ceros ceros ceros ceros ceros;
%     unos unos unos unos unos;
%     dos dos dos dos dos;
%     tres tres tres tres tres;
%     cuatro cuatro cuatro cuatro cuatro];

%% VALORES

% xvalues = {'Speech','Magic Flute','Emperor Waltz', 'Universal Mind', 'Adios Nomino'};
% yvalues = {'Speech','Magic Flute','Emperor Waltz', 'Universal Mind', 'Adios Nomino'};

% xvalues = {'Speech','Magic Flute'};
% yvalues = {'Speech','Magic Flute'};

%% ICA

%Sujeto 9
yfit9ica2 = trainedModel9ica1.predictFcn(T9ica2(:,2:width(T9ica2)));
yfit9ica1 = trainedModel9ica2.predictFcn(T9ica1(:,2:width(T9ica1)));

yfit9ica2knn3 = trainedModel9ica1knn3.predictFcn(T9ica2(:,2:width(T9ica2)));
yfit9ica1knn3 = trainedModel9ica2knn3.predictFcn(T9ica1(:,2:width(T9ica1)));

yfit9ica2knn5 = trainedModel9ica1knn5.predictFcn(T9ica2(:,2:width(T9ica2)));
yfit9ica1knn5 = trainedModel9ica2knn5.predictFcn(T9ica1(:,2:width(T9ica1)));

yfit9ica2svm = trainedModel9ica1svm.predictFcn(T9ica2(:,2:width(T9ica2)));
yfit9ica1svm = trainedModel9ica2svm.predictFcn(T9ica1(:,2:width(T9ica1)));

h9 = (confusionmat(T9ica2.Tipo,yfit9ica2)+confusionmat(T9ica1.Tipo,yfit9ica1))/2;
h9knn3 = (confusionmat(T9ica2.Tipo,yfit9ica2knn3)+confusionmat(T9ica1.Tipo,yfit9ica1knn3))/2;
h9knn5 = (confusionmat(T9ica2.Tipo,yfit9ica2knn5)+confusionmat(T9ica1.Tipo,yfit9ica1knn5))/2;
h9svm = (confusionmat(T9ica2.Tipo,yfit9ica2svm)+confusionmat(T9ica1.Tipo,yfit9ica1svm))/2;

% Sujeto 10
yfit10ica2 = trainedModel10ica1.predictFcn(T10ica2(:,2:width(T10ica2)));
yfit10ica1 = trainedModel10ica2.predictFcn(T10ica1(:,2:width(T10ica1)));

yfit10ica2knn3 = trainedModel10ica1knn3.predictFcn(T10ica2(:,2:width(T10ica2)));
yfit10ica1knn3 = trainedModel10ica2knn3.predictFcn(T10ica1(:,2:width(T10ica1)));

yfit10ica2knn5 = trainedModel10ica1knn5.predictFcn(T10ica2(:,2:width(T10ica2)));
yfit10ica1knn5 = trainedModel10ica2knn5.predictFcn(T10ica1(:,2:width(T10ica1)));

yfit10ica2svm = trainedModel10ica1svm.predictFcn(T10ica2(:,2:width(T10ica2)));
yfit10ica1svm = trainedModel10ica2svm.predictFcn(T10ica1(:,2:width(T10ica1)));

h10 = (confusionmat(T10ica2.Tipo,yfit10ica2)+confusionmat(T10ica1.Tipo,yfit10ica1))/2;
h10knn3 = (confusionmat(T10ica2.Tipo,yfit10ica2knn3)+confusionmat(T10ica1.Tipo,yfit10ica1knn3))/2;
h10knn5 = (confusionmat(T10ica2.Tipo,yfit10ica2knn5)+confusionmat(T10ica1.Tipo,yfit10ica1knn5))/2;
h10svm = (confusionmat(T10ica2.Tipo,yfit10ica2svm)+confusionmat(T10ica1.Tipo,yfit10ica1svm))/2;

% Sujeto 12
yfit12ica2 = trainedModel12ica1.predictFcn(T12ica2(:,2:width(T12ica2)));
yfit12ica1 = trainedModel12ica2.predictFcn(T12ica1(:,2:width(T12ica1)));

yfit12ica2knn3 = trainedModel12ica1knn3.predictFcn(T12ica2(:,2:width(T12ica2)));
yfit12ica1knn3 = trainedModel12ica2knn3.predictFcn(T12ica1(:,2:width(T12ica1)));

yfit12ica2knn5 = trainedModel12ica1knn5.predictFcn(T12ica2(:,2:width(T12ica2)));
yfit12ica1knn5 = trainedModel12ica2knn5.predictFcn(T12ica1(:,2:width(T12ica1)));

yfit12ica2svm = trainedModel12ica1svm.predictFcn(T12ica2(:,2:width(T12ica2)));
yfit12ica1svm = trainedModel12ica2svm.predictFcn(T12ica1(:,2:width(T12ica1)));

h12 = (confusionmat(T12ica2.Tipo,yfit12ica2)+confusionmat(T12ica1.Tipo,yfit12ica1))/2;
h12knn3 = (confusionmat(T12ica2.Tipo,yfit12ica2knn3)+confusionmat(T12ica1.Tipo,yfit12ica1knn3))/2;
h12knn5 = (confusionmat(T12ica2.Tipo,yfit12ica2knn5)+confusionmat(T12ica1.Tipo,yfit12ica1knn5))/2;
h12svm = (confusionmat(T12ica2.Tipo,yfit12ica2svm)+confusionmat(T12ica1.Tipo,yfit12ica1svm))/2;

% Sujeto 18
yfit18ica2 = trainedModel18ica1.predictFcn(T18ica2(:,2:width(T18ica2)));
yfit18ica1 = trainedModel18ica2.predictFcn(T18ica1(:,2:width(T18ica1)));

yfit18ica2knn3 = trainedModel18ica1knn3.predictFcn(T18ica2(:,2:width(T18ica2)));
yfit18ica1knn3 = trainedModel18ica2knn3.predictFcn(T18ica1(:,2:width(T18ica1)));

yfit18ica2knn5 = trainedModel18ica1knn5.predictFcn(T18ica2(:,2:width(T18ica2)));
yfit18ica1knn5 = trainedModel18ica2knn5.predictFcn(T18ica1(:,2:width(T18ica1)));

yfit18ica2svm = trainedModel18ica1svm.predictFcn(T18ica2(:,2:width(T18ica2)));
yfit18ica1svm = trainedModel18ica2svm.predictFcn(T18ica1(:,2:width(T18ica1)));

h18 = (confusionmat(T18ica2.Tipo,yfit18ica2)+confusionmat(T18ica1.Tipo,yfit18ica1))/2;
h18knn3 = (confusionmat(T18ica2.Tipo,yfit18ica2knn3)+confusionmat(T18ica1.Tipo,yfit18ica1knn3))/2;
h18knn5 = (confusionmat(T18ica2.Tipo,yfit18ica2knn5)+confusionmat(T18ica1.Tipo,yfit18ica1knn5))/2;
h18svm = (confusionmat(T18ica2.Tipo,yfit18ica2svm)+confusionmat(T18ica1.Tipo,yfit18ica1svm))/2;

% Sujeto 19
yfit19ica2 = trainedModel19ica1.predictFcn(T19ica2(:,2:width(T19ica2)));
yfit19ica1 = trainedModel19ica2.predictFcn(T19ica1(:,2:width(T19ica1)));

yfit19ica2knn3 = trainedModel19ica1knn3.predictFcn(T19ica2(:,2:width(T19ica2)));
yfit19ica1knn3 = trainedModel19ica2knn3.predictFcn(T19ica1(:,2:width(T19ica1)));

yfit19ica2knn5 = trainedModel19ica1knn5.predictFcn(T19ica2(:,2:width(T19ica2)));
yfit19ica1knn5 = trainedModel19ica2knn5.predictFcn(T19ica1(:,2:width(T19ica1)));

yfit19ica2svm = trainedModel19ica1svm.predictFcn(T19ica2(:,2:width(T19ica2)));
yfit19ica1svm = trainedModel19ica2svm.predictFcn(T19ica1(:,2:width(T19ica1)));

h19 = (confusionmat(T19ica2.Tipo,yfit19ica2)+confusionmat(T19ica1.Tipo,yfit19ica1))/2;
h19knn3 = (confusionmat(T19ica2.Tipo,yfit19ica2knn3)+confusionmat(T19ica1.Tipo,yfit19ica1knn3))/2;
h19knn5 = (confusionmat(T19ica2.Tipo,yfit19ica2knn5)+confusionmat(T19ica1.Tipo,yfit19ica1knn5))/2;
h19svm = (confusionmat(T19ica2.Tipo,yfit19ica2svm)+confusionmat(T19ica1.Tipo,yfit19ica1svm))/2;

% Representaciones
% % knn1
figure('Name','Porcentaje predicciones ICA knn1','NumberTitle','off'); 
subplot(2,3,1); heatmap(xvalues,yvalues,h9*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9+h10+h12+h18+h19)/5)*100./M); title('Promedio sujetos con ICA knn1');

% % % knn3
figure('Name','Porcentaje predicciones ICA knn3','NumberTitle','off'); 
subplot(2,3,1); heatmap(xvalues,yvalues,h9knn3*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10knn3*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12knn3*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18knn3*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19knn3*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9knn3+h10knn3+h12knn3+h18knn3+h19knn3)/5)*100./M); title('Promedio sujetos con ICA knn3');

% % % knn5
figure('Name','Porcentaje predicciones ICA knn5','NumberTitle','off'); 
subplot(2,3,1); heatmap(xvalues,yvalues,h9knn5*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10knn5*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12knn5*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18knn5*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19knn5*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9knn5+h10knn5+h12knn5+h18knn5+h19knn5)/5)*100./M); title('Promedio sujetos con ICA knn5');

% % svm
figure('Name','Porcentaje predicciones ICA svm','NumberTitle','off'); 
subplot(2,3,1); heatmap(xvalues,yvalues,h9svm*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10svm*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12svm*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18svm*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19svm*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9svm+h10svm+h12svm+h18svm+h19svm)/5)*100./M); title('Promedio sujetos con ICA svm');

%% EEG

% % Sujeto 9
% yfit9eeg2 = trainedModel9eeg1.predictFcn(T9eeg2(:,2:width(T9eeg2)));
% yfit9eeg1 = trainedModel9eeg2.predictFcn(T9eeg1(:,2:width(T9eeg1)));
% 
% yfit9eeg2knn3 = trainedModel9eeg1knn3.predictFcn(T9eeg2(:,2:width(T9eeg2)));
% yfit9eeg1knn3 = trainedModel9eeg2knn3.predictFcn(T9eeg1(:,2:width(T9eeg1)));
% 
% yfit9eeg2knn5 = trainedModel9eeg1knn5.predictFcn(T9eeg2(:,2:width(T9eeg2)));
% yfit9eeg1knn5 = trainedModel9eeg2knn5.predictFcn(T9eeg1(:,2:width(T9eeg1)));
% 
% yfit9eeg2svm = trainedModel9eeg1svm.predictFcn(T9eeg2(:,2:width(T9eeg2)));
% yfit9eeg1svm = trainedModel9eeg2svm.predictFcn(T9eeg1(:,2:width(T9eeg1)));
% 
% h9 = (confusionmat(T9eeg2.Tipo,yfit9eeg2)+confusionmat(T9eeg1.Tipo,yfit9eeg1))/2;
% h9knn3 = (confusionmat(T9eeg2.Tipo,yfit9eeg2knn3)+confusionmat(T9eeg1.Tipo,yfit9eeg1knn3))/2;
% h9knn5 = (confusionmat(T9eeg2.Tipo,yfit9eeg2knn5)+confusionmat(T9eeg1.Tipo,yfit9eeg1knn5))/2;
% h9svm = (confusionmat(T9eeg2.Tipo,yfit9eeg2svm)+confusionmat(T9eeg1.Tipo,yfit9eeg1svm))/2;
% 
% % Sujeto 10
% yfit10eeg2 = trainedModel10eeg1.predictFcn(T10eeg2(:,2:width(T10eeg2)));
% yfit10eeg1 = trainedModel10eeg2.predictFcn(T10eeg1(:,2:width(T10eeg1)));
% 
% yfit10eeg2knn3 = trainedModel10eeg1knn3.predictFcn(T10eeg2(:,2:width(T10eeg2)));
% yfit10eeg1knn3 = trainedModel10eeg2knn3.predictFcn(T10eeg1(:,2:width(T10eeg1)));
% 
% yfit10eeg2knn5 = trainedModel10eeg1knn5.predictFcn(T10eeg2(:,2:width(T10eeg2)));
% yfit10eeg1knn5 = trainedModel10eeg2knn5.predictFcn(T10eeg1(:,2:width(T10eeg1)));
% 
% yfit10eeg2svm = trainedModel10eeg1svm.predictFcn(T10eeg2(:,2:width(T10eeg2)));
% yfit10eeg1svm = trainedModel10eeg2svm.predictFcn(T10eeg1(:,2:width(T10eeg1)));
% 
% h10 = (confusionmat(T10eeg2.Tipo,yfit10eeg2)+confusionmat(T10eeg1.Tipo,yfit10eeg1))/2;
% h10knn3 = (confusionmat(T10eeg2.Tipo,yfit10eeg2knn3)+confusionmat(T10eeg1.Tipo,yfit10eeg1knn3))/2;
% h10knn5 = (confusionmat(T10eeg2.Tipo,yfit10eeg2knn5)+confusionmat(T10eeg1.Tipo,yfit10eeg1knn5))/2;
% h10svm = (confusionmat(T10eeg2.Tipo,yfit10eeg2svm)+confusionmat(T10eeg1.Tipo,yfit10eeg1svm))/2;
% 
% % Sujeto 12
% yfit12eeg2 = trainedModel12eeg1.predictFcn(T12eeg2(:,2:width(T12eeg2)));
% yfit12eeg1 = trainedModel12eeg2.predictFcn(T12eeg1(:,2:width(T12eeg1)));
% 
% yfit12eeg2knn3 = trainedModel12eeg1knn3.predictFcn(T12eeg2(:,2:width(T12eeg2)));
% yfit12eeg1knn3 = trainedModel12eeg2knn3.predictFcn(T12eeg1(:,2:width(T12eeg1)));
% 
% yfit12eeg2knn5 = trainedModel12eeg1knn5.predictFcn(T12eeg2(:,2:width(T12eeg2)));
% yfit12eeg1knn5 = trainedModel12eeg2knn5.predictFcn(T12eeg1(:,2:width(T12eeg1)));
% 
% yfit12eeg2svm = trainedModel12eeg1svm.predictFcn(T12eeg2(:,2:width(T12eeg2)));
% yfit12eeg1svm = trainedModel12eeg2svm.predictFcn(T12eeg1(:,2:width(T12eeg1)));
% 
% h12 = (confusionmat(T12eeg2.Tipo,yfit12eeg2)+confusionmat(T12eeg1.Tipo,yfit12eeg1))/2;
% h12knn3 = (confusionmat(T12eeg2.Tipo,yfit12eeg2knn3)+confusionmat(T12eeg1.Tipo,yfit12eeg1knn3))/2;
% h12knn5 = (confusionmat(T12eeg2.Tipo,yfit12eeg2knn5)+confusionmat(T12eeg1.Tipo,yfit12eeg1knn5))/2;
% h12svm = (confusionmat(T12eeg2.Tipo,yfit12eeg2svm)+confusionmat(T12eeg1.Tipo,yfit12eeg1svm))/2;
% 
% % Sujeto 18
% yfit18eeg2 = trainedModel18eeg1.predictFcn(T18eeg2(:,2:width(T18eeg2)));
% yfit18eeg1 = trainedModel18eeg2.predictFcn(T18eeg1(:,2:width(T18eeg1)));
% 
% yfit18eeg2knn3 = trainedModel18eeg1knn3.predictFcn(T18eeg2(:,2:width(T18eeg2)));
% yfit18eeg1knn3 = trainedModel18eeg2knn3.predictFcn(T18eeg1(:,2:width(T18eeg1)));
% 
% yfit18eeg2knn5 = trainedModel18eeg1knn5.predictFcn(T18eeg2(:,2:width(T18eeg2)));
% yfit18eeg1knn5 = trainedModel18eeg2knn5.predictFcn(T18eeg1(:,2:width(T18eeg1)));
% 
% yfit18eeg2svm = trainedModel18eeg1svm.predictFcn(T18eeg2(:,2:width(T18eeg2)));
% yfit18eeg1svm = trainedModel18eeg2svm.predictFcn(T18eeg1(:,2:width(T18eeg1)));
% 
% h18 = (confusionmat(T18eeg2.Tipo,yfit18eeg2)+confusionmat(T18eeg1.Tipo,yfit18eeg1))/2;
% h18knn3 = (confusionmat(T18eeg2.Tipo,yfit18eeg2knn3)+confusionmat(T18eeg1.Tipo,yfit18eeg1knn3))/2;
% h18knn5 = (confusionmat(T18eeg2.Tipo,yfit18eeg2knn5)+confusionmat(T18eeg1.Tipo,yfit18eeg1knn5))/2;
% h18svm = (confusionmat(T18eeg2.Tipo,yfit18eeg2svm)+confusionmat(T18eeg1.Tipo,yfit18eeg1svm))/2;
% 
% % Sujeto 19
% yfit19eeg2 = trainedModel19eeg1.predictFcn(T19eeg2(:,2:width(T19eeg2)));
% yfit19eeg1 = trainedModel19eeg2.predictFcn(T19eeg1(:,2:width(T19eeg1)));
% 
% yfit19eeg2knn3 = trainedModel19eeg1knn3.predictFcn(T19eeg2(:,2:width(T19eeg2)));
% yfit19eeg1knn3 = trainedModel19eeg2knn3.predictFcn(T19eeg1(:,2:width(T19eeg1)));
% 
% yfit19eeg2knn5 = trainedModel19eeg1knn5.predictFcn(T19eeg2(:,2:width(T19eeg2)));
% yfit19eeg1knn5 = trainedModel19eeg2knn5.predictFcn(T19eeg1(:,2:width(T19eeg1)));
% 
% yfit19eeg2svm = trainedModel19eeg1svm.predictFcn(T19eeg2(:,2:width(T19eeg2)));
% yfit19eeg1svm = trainedModel19eeg2svm.predictFcn(T19eeg1(:,2:width(T19eeg1)));
% 
% h19 = (confusionmat(T19eeg2.Tipo,yfit19eeg2)+confusionmat(T19eeg1.Tipo,yfit19eeg1))/2;
% h19knn3 = (confusionmat(T19eeg2.Tipo,yfit19eeg2knn3)+confusionmat(T19eeg1.Tipo,yfit19eeg1knn3))/2;
% h19knn5 = (confusionmat(T19eeg2.Tipo,yfit19eeg2knn5)+confusionmat(T19eeg1.Tipo,yfit19eeg1knn5))/2;
% h19svm = (confusionmat(T19eeg2.Tipo,yfit19eeg2svm)+confusionmat(T19eeg1.Tipo,yfit19eeg1svm))/2;
% 
% % Representaciones
% % knn1
% figure('Name','Porcentaje predicciones EEG knn1','NumberTitle','off'); 
% subplot(2,3,1); heatmap(xvalues,yvalues,h9*100./M); title('Sujeto 9');
% subplot(2,3,2); heatmap(xvalues,yvalues,h10*100./M); title('Sujeto 10');
% subplot(2,3,3); heatmap(xvalues,yvalues,h12*100./M); title('Sujeto 12');
% subplot(2,3,4); heatmap(xvalues,yvalues,h18*100./M); title('Sujeto 18');
% subplot(2,3,5); heatmap(xvalues,yvalues,h19*100./M); title('Sujeto 19');
% subplot(2,3,6); heatmap(xvalues,yvalues,((h9+h10+h12+h18+h19)/5)*100./M); title('Promedio sujetos con EEG knn1');
% 
% % knn3
% figure('Name','Porcentaje predicciones EEG knn3','NumberTitle','off'); 
% subplot(2,3,1); heatmap(xvalues,yvalues,h9knn3*100./M); title('Sujeto 9');
% subplot(2,3,2); heatmap(xvalues,yvalues,h10knn3*100./M); title('Sujeto 10');
% subplot(2,3,3); heatmap(xvalues,yvalues,h12knn3*100./M); title('Sujeto 12');
% subplot(2,3,4); heatmap(xvalues,yvalues,h18knn3*100./M); title('Sujeto 18');
% subplot(2,3,5); heatmap(xvalues,yvalues,h19knn3*100./M); title('Sujeto 19');
% subplot(2,3,6); heatmap(xvalues,yvalues,((h9knn3+h10knn3+h12knn3+h18knn3+h19knn3)/5)*100./M); title('Promedio sujetos con EEG knn3');
% 
% % knn5
% figure('Name','Porcentaje predicciones EEG knn5','NumberTitle','off'); 
% subplot(2,3,1); heatmap(xvalues,yvalues,h9knn5*100./M); title('Sujeto 9');
% subplot(2,3,2); heatmap(xvalues,yvalues,h10knn5*100./M); title('Sujeto 10');
% subplot(2,3,3); heatmap(xvalues,yvalues,h12knn5*100./M); title('Sujeto 12');
% subplot(2,3,4); heatmap(xvalues,yvalues,h18knn5*100./M); title('Sujeto 18');
% subplot(2,3,5); heatmap(xvalues,yvalues,h19knn5*100./M); title('Sujeto 19');
% subplot(2,3,6); heatmap(xvalues,yvalues,((h9knn5+h10knn5+h12knn5+h18knn5+h19knn5)/5)*100./M); title('Promedio sujetos con EEG knn5');
% 
% % svm
% figure('Name','Porcentaje predicciones EEG svm','NumberTitle','off'); 
% subplot(2,3,1); heatmap(xvalues,yvalues,h9svm*100./M); title('Sujeto 9');
% subplot(2,3,2); heatmap(xvalues,yvalues,h10svm*100./M); title('Sujeto 10');
% subplot(2,3,3); heatmap(xvalues,yvalues,h12svm*100./M); title('Sujeto 12');
% subplot(2,3,4); heatmap(xvalues,yvalues,h18svm*100./M); title('Sujeto 18');
% subplot(2,3,5); heatmap(xvalues,yvalues,h19svm*100./M); title('Sujeto 19');
% subplot(2,3,6); heatmap(xvalues,yvalues,((h9svm+h10svm+h12svm+h18svm+h19svm)/5)*100./M); title('Promedio sujetos con EEG svm');
