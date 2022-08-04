//Aluno: Francilândio Lima Serafim (472644)
clear;
clc;

//Variáveis de entrada: pressão no pedal = pres_pedal; velocidade das rodas = vel_rodas; velocidade do carro = vel_carro.

//Valores linguísticos:
//-Pressão no Pedal: Alto = {(50,0),(100,1)} = pres_alta; Medio = {(30,0),(50,1),(70,0)} = pres_media; Baixo = {(0,1),(50,0)} = pres_baixa.
//-Velocidade das rodas: Devagar = {(0,1),(60,0)} = v_roda_devagar; Medio = {(20,0),(50,1),(80,0)} = v_roda_media; Rápido = {(40,0),(100,1)} = v_roda_rapida.
//-Velocidade do carro: Devagar = {(0,1),(60,0)} = v_carro_devagar; Medio = {(20,0),(50,1),(80,0)} = v_carro_media; Rápido = {(40,0),(100,1)} = v_carro_rapida.

//Entradas presentes no slide:
//pres_pedal = 60;
//vel_rodas = 55;
//vel_carro = 80;

//Receber os valores de entrada:
pres_pedal = input("Digite o valor da pressão no pedal (0-100):");
vel_rodas = input("Digite o valor da velocidade nas rodas (0-100):");
vel_carro = input("Digite o valor da velocidade do carro (0-100):");

//Categorizando os valores de pressão no pedal:
//-Alto:
if(pres_pedal > 50 && pres_pedal <= 100) then
    pres_alta = (pres_pedal-50)/50;
else
    pres_alta = 0;
end
//Médio:
if(pres_pedal > 30 && pres_pedal < 70) then
    pres_media = [20-abs(pres_pedal-50)]/20;
else
    pres_media = 0;
end
//-Baixo:
if(pres_pedal >= 0 && pres_pedal < 50) then
    pres_baixa = (50-pres_pedal)/50;
else
    pres_baixa = 0;
end

//Categorizando os valores de velocidade das rodas:
//-Rápido:
if(vel_rodas > 40 && vel_rodas <= 100) then
    v_roda_rapida = (vel_rodas-40)/60;
else
    v_roda_rapida = 0;
end
//-Médio:
if(vel_rodas > 20 && vel_rodas < 80) then
    v_roda_media = [30-abs(vel_rodas-50)]/30;
else
    v_roda_media = 0;
end
//-Devagar:
if(vel_rodas >= 0 && vel_rodas < 60) then
    v_roda_devagar = (60-vel_rodas)/60;
else
    v_roda_devagar = 0;
end

//Categorizando os valores de velocidade do carro:
//-Rápido:
if(vel_carro > 40 && vel_carro <= 100) then
    v_carro_rapida = (vel_carro-40)/60;
else
    v_carro_rapida = 0;
end
//-Médio:
if(vel_carro > 20 && vel_carro < 80) then
    v_carro_media = [30-abs(vel_carro-50)]/30;
else
    v_carro_media = 0;
end
//-Devagar:
if(vel_carro >= 0 && vel_carro < 60) then
    v_carro_devagar = (60-vel_carro)/60;
else
    v_carro_devagar = 0;
end

//Aplicando as regras:
//-Aplicar o freio: Regra 1 OU Regra 2:
inferencia_1 = pres_media + min(pres_alta, v_carro_rapida, v_roda_rapida);
//-Liberar o freio: Regra 3 OU Regra 4:
inferencia_2 = min(pres_alta, v_carro_rapida, v_roda_devagar) + pres_baixa;

//Preparando o Cálculo do centróide:
soma = 0;
passo = 2;
denominador = 0;

if(inferencia_1 > inferencia_2) then
    limite_1 = inferencia_2*100;
    limite_2 = inferencia_1*100;
    for(i = 2: passo: limite_1 - passo)
        soma = soma + inferencia_2*i;
        denominador = denominador + inferencia_2;
    end
    for(i = limite_1: passo: limite_2 - passo)
        soma = soma + (i**2)/100;
        denominador = denominador + i/100;
    end
    for(i = limite_2: passo: 100)
        soma = soma + inferencia_1*i;
        denominador = denominador + inferencia_1;
    end
else
    limite_1 = 100*(1-inferencia_2);
    limite_2 = 100*(1-inferencia_1);
    for(i = 2: passo: limite_1 - passo)
        soma = soma + inferencia_2*i;
        denominador = denominador + inferencia_2;
    end
    for(i = limite_1: passo: limite_2 - passo)
        soma = soma + [i*(100-i)]/100;
        denominador = denominador + (100-i)/100;
    end
    for(i = limite_2: passo: 100)
        soma = soma + inferencia_1*i;
        denominador = denominador + inferencia_1;
    end
end

//Pressão no freio dado pelo centroide:
centroide = soma/denominador;
if(isnan(centroide)) then
    printf("Não é possível inferir a pressão com os valores fornecidos.");
else
    printf('A pressão no freio é %f unidades de pressão.',centroide);
end

//Plotando formato do gráfico do "corte" das funções de pertinência:
x = [0, limite_1, limite_2, 100];
y = [inferencia_2, inferencia_2, inferencia_1, inferencia_1];
plot(x,y);
plot([centroide,centroide],[0,1], 'r','LineWidth',3);
legend(['União dos gráficos'],['Reta que toca o Centróide'],2);
title('Área abaixo do gráfico para cálculo do Centróide.');
xlabel('Pressão no freio');
