%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarações externas
extern int yylex();        // Função gerada pelo Flex
extern int yylineno;       // Linha atual do parser
extern char *yytext;       // Texto do token atual
void yyerror(const char *s); // Função para tratar erros

// Prototipos das funções
double converterMoeda(double valor, int opcao);
void mostrarMenuComTaxas();
%}

// Declaração de tokens
%token DIGITO
%token OPCOES
%token FIM
%token SIM
%token NAO

%%

// Regras gramaticais
input:
    /* vazio */ 
    | input comando
;

comando:
    DIGITO {
        double valor = atof(yytext);
        printf("Valor inserido: %.2f\n", valor);
        mostrarMenuComTaxas();
    }
    OPCOES {
        int opcao = atoi(yytext);
        if (opcao < 1 || opcao > 6) {
            printf("Opção inválida! Escolha entre 1 e 6.\n");
        } else {
            printf("Opção selecionada: %d\n", opcao);
        }
    }
    FIM {
        printf("Finalizando o programa.\n");
        exit(0);
    }
    SIM {
        printf("Reiniciando o programa...\n");
    }
    NAO {
        printf("Encerrando. Obrigado por usar o Conversor de Moedas!\n");
        exit(0);
    }
;

%%

// Função para tratar erros
void yyerror(const char *s) {
    fprintf(stderr, "Erro na linha %d: %s\n", yylineno, s);
}
