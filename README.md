# MyRISKv1 - Processador Monociclo em MIPS

## Descrição

Este projeto implementa um processador monociclo na arquitetura MIPS usando VHDL. O processador é capaz de executar algumas instruções básicas do conjunto de instruções MIPS, como BNE, JR e JAL, e foi desenvolvido em sala durante as aulas de Organização e Arquitetura de Computadores II, juntamente com o Professor Max Santana Rolemberg Farias da UNIVASF - Universidade Federal do Vale do São Francisco.

## Pré-requisitos

Para compilar e simular o projeto, você precisará de um ambiente VHDL adequado (por exemplo, Xilinx Vivado, ModelSim). Recomenda-se usar o EDAPlaygroun (simulador online que suporta várias linguagens de descrição de hardware).

## Como Usar

Para usar o processador, siga os seguintes passos:
1. Clone este repositório.
2. Abra o projeto em seu ambiente de desenvolvimento VHDL.
3. Compile o código.
4. Simule o design usando testbenches fornecidos.

## Simulação

Os resultados da simulação são gravados no diretório `simulations/waveforms/`. Analise esses resultados para verificar a correta execução das instruções.

## WaveForm de um código que testa a instrução JAL e JR (./jal_and_jar_test.out)
![WaveForm de um código que testa a instrução JAL e JR (./jal_and_jar_test.out)](./teste_code.png)
