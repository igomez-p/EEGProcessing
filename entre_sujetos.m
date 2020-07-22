% -------------------------------------------------------------------------
% ----- Irene Gomez Plazas, 2019 - github.com/igomez-p/EEGProcessing ------
% -------------------------------------------------------------------------

%% ENTRE SUJETOS (para señales EEG) (canales comunes)

% Se entrena una tabla que contenga las relaciones de voz y música de 4
% sujetos y se clasifica el sujeto restante

z = 1;

% Creación de tablas
T9eeg = audio_analysis_eeg(eeg_clean9,z);
T10eeg = audio_analysis_eeg(eeg_clean10,z);
T12eeg = audio_analysis_eeg(eeg_clean12,z);
T18eeg = audio_analysis_eeg(eeg_clean18,z);
T19eeg = audio_analysis_eeg(eeg_clean19,z);

%% Creación de tablas a entrenar (TX) para clasificar sujeto restante X
T9 = [T10eeg; T12eeg; T18eeg; T19eeg];
T10 = [T9eeg; T12eeg; T18eeg; T19eeg];
T12 = [T9eeg; T10eeg; T18eeg; T19eeg];
T18 = [T9eeg; T10eeg; T12eeg; T19eeg];
T19 = [T9eeg; T10eeg; T12eeg; T18eeg];

%% Para realizar el porcentaje
Tabla = T9eeg; % Todos los sujetos tienen el mismo número de variables

unos = length(find(Tabla.Tipo == 1));  % Número de 1's
ceros = length(find(Tabla.Tipo == 0)); % Número de 0's

M = [ceros ceros; unos unos];

% Valores
xvalues = {'Speech','Magic Flute'};
yvalues = {'Speech','Magic Flute'};

% Modelo exportado -> trainedModelX (con X el sujeto a clasificar)
% Clasificación -> yfitX (con X el sujeto clasificado)

%% REPRESENTACIONES

% knn
yfit9 = trainedModel9.predictFcn(T9eeg(:,2:width(T9eeg)));
yfit10 = trainedModel10.predictFcn(T10eeg(:,2:width(T10eeg)));
yfit12 = trainedModel12.predictFcn(T12eeg(:,2:width(T12eeg)));
yfit18 = trainedModel18.predictFcn(T18eeg(:,2:width(T18eeg)));
yfit19 = trainedModel19.predictFcn(T19eeg(:,2:width(T19eeg)));

h9 = confusionmat(T9eeg.Tipo,yfit9);
h10 = confusionmat(T10eeg.Tipo,yfit10);
h12 = confusionmat(T12eeg.Tipo,yfit12);
h18 = confusionmat(T18eeg.Tipo,yfit18);
h19 = confusionmat(T19eeg.Tipo,yfit19);

figure('Name', 'Porcentaje predicciones entre sujetos, kNN1','NumberTitle','off');
subplot(2,3,1); heatmap(xvalues,yvalues,h9*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9+h10+h12+h18+h19)/5)*100./M); title('Promedio sujetos con EEG kNN1');

% knn3
yfit9knn3 = trainedModel9knn3.predictFcn(T9eeg(:,2:width(T9eeg)));
yfit10knn3 = trainedModel10knn3.predictFcn(T10eeg(:,2:width(T10eeg)));
yfit12knn3 = trainedModel12knn3.predictFcn(T12eeg(:,2:width(T12eeg)));
yfit18knn3 = trainedModel18knn3.predictFcn(T18eeg(:,2:width(T18eeg)));
yfit19knn3 = trainedModel19knn3.predictFcn(T19eeg(:,2:width(T19eeg)));

h9knn3 = confusionmat(T9eeg.Tipo,yfit9knn3);
h10knn3 = confusionmat(T10eeg.Tipo,yfit10knn3);
h12knn3 = confusionmat(T12eeg.Tipo,yfit12knn3);
h18knn3 = confusionmat(T18eeg.Tipo,yfit18knn3);
h19knn3 = confusionmat(T19eeg.Tipo,yfit19knn3);

figure('Name', 'Porcentaje predicciones entre sujetos, kNN3','NumberTitle','off');
subplot(2,3,1); heatmap(xvalues,yvalues,h9knn3*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10knn3*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12knn3*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18knn3*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19knn3*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9knn3+h10knn3+h12knn3+h18knn3+h19knn3)/5)*100./M); title('Promedio sujetos con EEG kNN3');

% knn5
yfit9knn5 = trainedModel9knn5.predictFcn(T9eeg(:,2:width(T9eeg)));
yfit10knn5 = trainedModel10knn5.predictFcn(T10eeg(:,2:width(T10eeg)));
yfit12knn5 = trainedModel12knn5.predictFcn(T12eeg(:,2:width(T12eeg)));
yfit18knn5 = trainedModel18knn5.predictFcn(T18eeg(:,2:width(T18eeg)));
yfit19knn5 = trainedModel19knn5.predictFcn(T19eeg(:,2:width(T19eeg)));

h9knn5 = confusionmat(T9eeg.Tipo,yfit9knn5);
h10knn5 = confusionmat(T10eeg.Tipo,yfit10knn5);
h12knn5 = confusionmat(T12eeg.Tipo,yfit12knn5);
h18knn5 = confusionmat(T18eeg.Tipo,yfit18knn5);
h19knn5 = confusionmat(T19eeg.Tipo,yfit19knn5);

figure('Name', 'Porcentaje predicciones entre sujetos, kNN5','NumberTitle','off');
subplot(2,3,1); heatmap(xvalues,yvalues,h9knn5*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10knn5*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12knn5*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18knn5*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19knn5*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9knn5+h10knn5+h12knn5+h18knn5+h19knn5)/5)*100./M); title('Promedio sujetos con EEG kNN5');

% svm
yfit9svm = trainedModel9svm.predictFcn(T9eeg(:,2:width(T9eeg)));
yfit10svm = trainedModel10svm.predictFcn(T10eeg(:,2:width(T10eeg)));
yfit12svm = trainedModel12svm.predictFcn(T12eeg(:,2:width(T12eeg)));
yfit18svm = trainedModel18svm.predictFcn(T18eeg(:,2:width(T18eeg)));
yfit19svm = trainedModel19svm.predictFcn(T19eeg(:,2:width(T19eeg)));

h9svm = confusionmat(T9eeg.Tipo,yfit9svm);
h10svm = confusionmat(T10eeg.Tipo,yfit10svm);
h12svm = confusionmat(T12eeg.Tipo,yfit12svm);
h18svm = confusionmat(T18eeg.Tipo,yfit18svm);
h19svm = confusionmat(T19eeg.Tipo,yfit19svm);

figure('Name', 'Porcentaje predicciones entre sujetos, SVM','NumberTitle','off');
subplot(2,3,1); heatmap(xvalues,yvalues,h9svm*100./M); title('Sujeto 9');
subplot(2,3,2); heatmap(xvalues,yvalues,h10svm*100./M); title('Sujeto 10');
subplot(2,3,3); heatmap(xvalues,yvalues,h12svm*100./M); title('Sujeto 12');
subplot(2,3,4); heatmap(xvalues,yvalues,h18svm*100./M); title('Sujeto 18');
subplot(2,3,5); heatmap(xvalues,yvalues,h19svm*100./M); title('Sujeto 19');
subplot(2,3,6); heatmap(xvalues,yvalues,((h9svm+h10svm+h12svm+h18svm+h19svm)/5)*100./M); title('Promedio sujetos con EEG SVM');
