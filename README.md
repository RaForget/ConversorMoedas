# Conversor de Moedas

Programa de console em C que converte um valor em reais para uma entre seis moedas. O projeto usa Flex para reconhecer a entrada numérica e contém também um arquivo de gramática Bison.

## O que foi implementado

- Leitura de um valor decimal digitado pelo usuário.
- Exibição de um menu com seis moedas e suas taxas de conversão.
- Validação da opção escolhida (de 1 a 6) e repetição do menu quando a opção ou a entrada não é válida.
- Cálculo usando a fórmula `valor em reais × taxa da moeda`.
- Exibição do resultado e opção de iniciar outra conversão ou encerrar.
- Cores no console do Windows para destacar títulos, erros e resultados.

As moedas e taxas definidas em `conversorMoeda.l` são:

| Opção | Moeda | Unidades por real |
|---:|---|---:|
| 1 | Dólar (USD) | 0,17 |
| 2 | Euro (EUR) | 0,18 |
| 3 | Libra (GBP) | 0,14 |
| 4 | Iene (JPY) | 26,68 |
| 5 | Dólar canadense (CAD) | 0,24 |
| 6 | Franco suíço (CHF) | 0,15 |

As taxas estão fixadas no código e identificadas nele como atualizadas em 22/11/2024; não são consultadas em tempo real.

## Arquivos

- `conversorMoeda.l`: contém as regras do Flex e a implementação em C usada pelo fluxo atual, incluindo menu, conversão e função `main`.
- `conversorMoeda.y`: contém uma gramática Bison com ações para alguns comandos. No estado atual, ela não está integrada a `conversorMoeda.l`: o lexer não retorna os tokens declarados na gramática e o arquivo `.y` não implementa por si só o menu e o cálculo de conversão.
- `ConversordeMoedas.exe`: executável presente na pasta do projeto.

## Compilação no Windows

É necessário ter Flex e um compilador GCC compatível com Windows (por exemplo, via MinGW). No terminal, a partir desta pasta, gere o código C e compile-o:

```powershell
flex -o conversorMoeda.c conversorMoeda.l
gcc conversorMoeda.c -o ConversordeMoedas.exe
```

O arquivo `.l` usa `windows.h` para colorir o console, portanto essa implementação é voltada ao Windows. O arquivo C gerado (`conversorMoeda.c`) pode ser removido depois da compilação se não for necessário mantê-lo.

## Como usar

Execute `ConversordeMoedas.exe`, informe um valor numérico (por exemplo, `100` ou `12.50`), escolha uma moeda de 1 a 6 e responda `sim` para realizar outra conversão ou `nao` para encerrar.

## Observações

- A entrada decimal usa ponto, como em `12.50`.
- A resposta para repetir a conversão reconhece `sim` e `Sim`; outras respostas encerram o programa.
- Para atualizar as taxas, altere os valores do vetor `taxas` em `conversorMoeda.l` e recompile.