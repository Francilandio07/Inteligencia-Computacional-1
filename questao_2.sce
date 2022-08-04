//Aluno: Francilândio Lima Serafim (472644)
clc;
clear;

//Base com os dados do problema:
base = fscanfMat('aerogerador.dat');

//Velocidade do vento:
x = base(:,1);
//Potência gerada:
y = base(:,2);

//Número de amostras:
n=length(x);

//Matriz de n linhas cuja linha i contém potências de xi de 0 a k:
X2 = [ones(n,1) x x.^2];
X3 = [ones(n,1) x x.^2 x.^3];
X4 = [ones(n,1) x x.^2 x.^3 x.^4];
X5 = [ones(n,1) x x.^2 x.^3 x.^4 x.^5];
X6 = [ones(n,1) x x.^2 x.^3 x.^4 x.^5 x.^6];
X7 = [ones(n,1) x x.^2 x.^3 x.^4 x.^5 x.^6 x.^7];

//Estimativa de quadrados mínimos:
beta2=(X2'*X2)\X2'*y;
beta3=(X3'*X3)\X3'*y;
beta4=(X4'*X4)\X4'*y;
beta5=(X5'*X5)\X5'*y;
beta6=(X6'*X6)\X6'*y;
beta7=(X7'*X7)\X7'*y;

//Modelos de regressão polinomial:
y_chap2 = beta2(1)+beta2(2)*x+beta2(3)*x.^2;//Grau 2
y_chap3 = beta3(1)+beta3(2)*x+beta3(3)*x.^2+beta3(4)*x.^3;//Grau 3
y_chap4 = beta4(1)+beta4(2)*x+beta4(3)*x.^2+beta4(4)*x.^3+beta4(5)*x.^4;//Grau 4
y_chap5 = beta5(1)+beta5(2)*x+beta5(3)*x.^2+beta5(4)*x.^3+beta5(5)*x.^4+beta5(6)*x.^5;//Grau 5
y_chap6 = beta6(1)+beta6(2)*x+beta6(3)*x.^2+beta6(4)*x.^3+beta6(5)*x.^4+beta6(6)*x.^5+beta6(7)*x.^6;//Grau 6
y_chap7 = beta7(1)+beta7(2)*x+beta7(3)*x.^2+beta7(4)*x.^3+beta7(5)*x.^4+beta7(6)*x.^5+beta7(7)*x.^6+beta7(8)*x.^7;//Grau 7

//Mostrando os gráficos de regressão:
//Grau 2
subplot(3,2,1);
plot(x, y, '*');
plot(x,y_chap2, 'r-','LineWidth',2);
ylabel('Potência gerada');
xlabel('Velocidade do vento');
title('Grau 2');
legend('Amostras','Modelo de regressão',2);
//Grau 3
subplot(3,2,2);
plot(x, y, '*');
plot(x,y_chap3, 'r-','LineWidth',2);
ylabel('Potência gerada');
xlabel('Velocidade do vento');
title('Grau 3');
legend('Amostras','Modelo de regressão',2);
//Grau 4
subplot(3,2,3);
plot(x, y, '*');
plot(x,y_chap4, 'r-','LineWidth',2);
ylabel('Potência gerada');
xlabel('Velocidade do vento');
title('Grau 4');
legend('Amostras','Modelo de regressão',2);
//Grau 5
subplot(3,2,4);
plot(x, y, '*');
plot(x,y_chap5, 'r-','LineWidth',2);
ylabel('Potência gerada');
xlabel('Velocidade do vento');
title('Grau 5');
legend('Amostras','Modelo de regressão',2);
//Grau 6
subplot(3,2,5);
plot(x, y, '*');
plot(x,y_chap6, 'r-','LineWidth',2);
ylabel('Potência gerada');
xlabel('Velocidade do vento');
title('Grau 6');
legend('Amostras','Modelo de regressão',2);
//Grau 7
subplot(3,2,6);
plot(x, y, '*');
plot(x,y_chap7, 'r-','LineWidth',2);
ylabel('Potência gerada');
xlabel('Velocidade do vento');
title('Grau 7');
legend('Amostras','Modelo de regressão',2);

/*===================== Avaliando os modelos através dos coeficientes de determinação normal e ajustado =================================
    Para avaliar um modelo de regressão calcula-se o seu coeficiente de determinação R²
que representa o quanto o modelo descreve a variabilidade dos dados.
    Em regressões múltiplas, acrescentar variáveis sempre aumenta o R².
    Por esse motivo que tenta-se achar um descritor mais fiel do modelo, e aí surge o R² ajustado.
    Uma fórmula para calcular esse novo coeficiente é 
R²aj = 1 - (1-R²)*(n-1/n-k), 
sendo n o número de amostras e k o número total de variáveis incluindo a independente.
    Nessa relação observa-se que há uma penalização dados aumentos de k e a compensação só é atingida se o acréscimo
de variáveis realmente contribuir com o valor de R².
*/
//Grau 2:
//Coeficiente de Determinação na Regressão Múltipla.
R2_2=1-sum((y-y_chap2).^2)/sum((y-mean(y)).^2);
p2 = size(X2)(2); //p = k + 1 -> Número de entradas + 1 (termo indep.) de y_i = número de colunas de X dada pelo size que retorna um vetor com 2 valores: n linhas e n colunas.
//Coeficiente de Determinação Ajustado.
R2aj_2 = 1-[sum((y-y_chap2).^2)/(n-p2)]/[sum((y-mean(y)).^2)/(n-1)];
printf('Grau 2: \n');
printf('Coeficiente de determinação: %.7f \n',R2_2);
printf('Coeficiente de determinação ajustado: %.7f \n',R2aj_2);

//Grau 3:
//Coeficiente de Determinação na Regressão Múltipla.
R2_3=1-sum((y-y_chap3).^2)/sum((y-mean(y)).^2);
p3 = size(X3)(2); 
//Coeficiente de Determinação Ajustado.
R2aj_3 = 1-[sum((y-y_chap3).^2)/(n-p3)]/[sum((y-mean(y)).^2)/(n-1)];
printf('Grau 3: \n');
printf('Coeficiente de determinação: %.7f \n',R2_3);
printf('Coeficiente de determinação ajustado: %.7f \n',R2aj_3);

//Grau 4:
//Coeficiente de Determinação na Regressão Múltipla.
R2_4=1-sum((y-y_chap4).^2)/sum((y-mean(y)).^2);
p4 = size(X4)(2); 
//Coeficiente de Determinação Ajustado.
R2aj_4 = 1-[sum((y-y_chap4).^2)/(n-p4)]/[sum((y-mean(y)).^2)/(n-1)];
printf('Grau 4: \n');
printf('Coeficiente de determinação: %.7f \n',R2_4);
printf('Coeficiente de determinação ajustado: %.7f \n',R2aj_4);

//Grau 5:
//Coeficiente de Determinação na Regressão Múltipla.
R2_5=1-sum((y-y_chap5).^2)/sum((y-mean(y)).^2);
p5 = size(X5)(2); 
//Coeficiente de Determinação Ajustado.
R2aj_5 = 1-[sum((y-y_chap5).^2)/(n-p5)]/[sum((y-mean(y)).^2)/(n-1)];
printf('Grau 5:\n');
printf('Coeficiente de determinação: %.7f \n',R2_5);
printf('Coeficiente de determinação ajustado: %.7f \n',R2aj_5);

//Grau 6:
//Coeficiente de Determinação na Regressão Múltipla.
R2_6=1-sum((y-y_chap6).^2)/sum((y-mean(y)).^2);
p6 = size(X6)(2); 
//Coeficiente de Determinação Ajustado.
R2aj_6 = 1-[sum((y-y_chap6).^2)/(n-p6)]/[sum((y-mean(y)).^2)/(n-1)];
printf('Grau 6:\n');
printf('Coeficiente de determinação: %.7f \n',R2_6);
printf('Coeficiente de determinação ajustado: %.7f \n',R2aj_6);

//Grau 7:
//Coeficiente de Determinação na Regressão Múltipla.
R2_7=1-sum((y-y_chap7).^2)/sum((y-mean(y)).^2);
p7 = size(X7)(2); 
//Coeficiente de Determinação Ajustado.
R2aj_7 = 1-[sum((y-y_chap7).^2)/(n-p7)]/[sum((y-mean(y)).^2)/(n-1)];
printf('Grau 7:\n');
printf('Coeficiente de determinação: %.7f \n',R2_7);
printf('Coeficiente de determinação ajustado: %.7f\n',R2aj_7);
printf('\nObserva-se que do grau 2 ao 4 ambos os coeficientes aumentam de modo significativo, e do grau 4 pro 5\n o coeficiente ajustado decresce um pouco e torna a crescer do grau 5 para o 6, e do 6 para o 7.\n Daí, como os coeficientes maiores são os do grau 7, poderia-se inferir que esse é o modelo mais adequado, porém o R²aj do grau 4 difere pouco do \nR²aj dos graus 6 e 7, então considerando isso e por conter menos variáveis, temos que o modelo de grau 4 é o melhor.');
