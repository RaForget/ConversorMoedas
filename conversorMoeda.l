%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <windows.h>

// Funcoes
void setColor(int color);
void mostrarMenuComTaxas();
double converterMoeda(double valor, int opcao);
void limparBuffer();

// Variaveis globais
char *moedas[] = {"Dolar (USD)", "Euro (EUR)", "Libra (GBP)", "Iene (JPY)", "Dolar Canadense (CAD)", "Franco Suico (CHF)"};
double taxas[] = {0.17, 0.18, 0.14, 26.68, 0.24, 0.15}; // Taxas atualizadas 22/11/2024
%}

DIGITO [0-9]+
TEXTO [a-zA-Z]+

%%

{DIGITO}+("."{DIGITO}+)? {
    double valor = atof(yytext);

    setColor(11); // Azul claro
    printf("Valor inserido: %.2f\n", valor);

    while (1) {
        setColor(15); // Branco
        mostrarMenuComTaxas();

        printf("\nDigite a opcao desejada (1-6): ");
        int opcao;
        if (scanf("%d", &opcao) != 1) {
            limparBuffer();
            setColor(12); // Vermelho
            printf("Opcao invalida! Digite um numero.\n");
            continue;
        }

        if (opcao < 1 || opcao > 6) {
            setColor(12); // Vermelho
            printf("Opcao invalida! Escolha entre 1 e 6.\n");
            continue;
        }

        double resultado = converterMoeda(valor, opcao);
        setColor(10); // Verde
        printf("\n%.2f Reais equivalem a %.2f %s\n", valor, resultado, moedas[opcao - 1]);

        break;
    }

    setColor(15); // Branco
    printf("\nDeseja realizar outra conversao? (sim/nao): ");
    char resposta[10];
    scanf("%s", resposta);

    if (strcmp(resposta, "sim") == 0 || strcmp(resposta, "Sim") == 0) {
        printf("\nInsira o valor para conversao:\n");
    } else {
        setColor(14); // Amarelo
        printf("\nObrigado por usar o Conversor de Moedas!\n");
        exit(0);
    }
}

. { printf("Caractere invalido: %s\n", yytext); }

%%

// Funcao para mostrar o menu com tabela de taxas
void mostrarMenuComTaxas() {
    setColor(14); // Amarelo para o titulo
    printf("\n=== Escolha a moeda para conversao ===\n");
    setColor(15); // Branco para o cabecalho da tabela
    printf("\nOpcao\tMoeda\t\t\tTaxa (1 Real equivale a)\n");
    setColor(8); // Cinza para a linha divisoria
    printf("---------------------------------------------\n");
    for (int i = 0; i < 6; i++) {
        setColor(9); // Azul claro para os valores
        printf("%d\t%s\t%.2f\n", i + 1, moedas[i], taxas[i]);
    }
    printf("\n");
}

// Funcao para calcular a conversao
double converterMoeda(double valor, int opcao) {
    return valor * taxas[opcao - 1];
}

// Funcao para alterar a cor do texto
void setColor(int color) {
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(hConsole, color);
}

// Funcao para limpar o buffer de entrada
void limparBuffer() {
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

int yywrap() {
    return 1;
}

int main() {
    setlocale(LC_ALL, ""); // Ajusta a codificacao para o sistema
    setColor(14); // Amarelo
    printf("=== Conversor de Moedas ===\n");
    setColor(15); // Branco
    printf("Insira o valor para conversao:\n");
    yylex();
    return 0;
}
