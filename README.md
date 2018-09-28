# Poker 

## Objetivo
Implementar um jogo de poker com analisador sob diferentes paradigmas de linguagem de programação, 
sendo estes: imperativo, funcional e lógico, nas linguagens C++, Haskell e Prolog, respectivamente.

## Descrição
Um jogo de poker [limit texas hold’em](https://www.pokerstars.com/br/poker/games/texas-holdem/#/limit) 
com analisador que auxiliará jogadores na tomada de decisões, melhorando assim sua performance e desempenho. Para tal, 
serão utilizados conceitos de probabilidade condicional para extrair os diferentes resultados. 

* Modo de jogo: 6 jogadores (1 usuário + 5 bots)

### Requisitos Funcionais

#### Modo de jogo manual 
O usuário deve ser capaz de visualizar suas cartas da mão (pré flop) e da mesa (flop, turn e river), bem como executar 
normalmente as ações do jogo (bet, fold e check).

#### Modo de jogo automático
O usuário deve ser capaz de executar as ações do jogo sem nenhuma pré-visualização.

#### Probabilidade do melhor jogo possível
O jogo deve mostrar em toda rodada, a probabilidade do jogador obter o maior 
[jogo](https://pt.pokerstrategy.com/strategy/various-poker/texas-holdem-probabilidades/) 
possível combinando as cartas da sua [mão](http://www.natesholdem.com/pre-flop-odds.php), 
as da mesa e as que ainda não saíram.

#### Relatório final
Ao final da partida o sistema deve mostrar as probabilidades de vitória do usuário em cada turno.

#### Perfil do jogador
O sistema deve classificar o jogador como: moderado, muito moderado, agressivo ou muito 
agressivo, levando em consideração as ações do jogador nos diferentes cenários da partida.

## Poker

### Mãos do Poker

![Jogos](https://blog.betmotion.com/media/03.jpg)

### Posições na Mesa

![Pos](https://horusrafa.files.wordpress.com/2014/09/regrras-gerais-da-modalidade-mesa_do_guia.png)
<br>
O botão de Dealer gira ao longo da partida de forma a alternar as posições na mesa.

### Ações
* Call (cobrir uma aposta)
* Check (passar a vez)
* Raise (apostar)
* Fold (desistir)

### Turnos
* Pré flop 
* Flop
* Turn 
* River

#### Pré Flop
* O Dealer é escolhido através de sorteio
* Cada jogador recebe 2 cartas

#### Flop
* O Crupier coloca 3 cartas na mesa

#### Turn
* O Crupier coloca 1 carta na mesa

#### River 
* O Crupier coloca 1 carta na mesa

### Vencedor 
Será aquele que tiver acumulado todas as fichas da mesa após várias partidas.

##### Participantes
- [Arthur Ferrão](https://github.com/ArthurFerrao)
- [Eddie Kaleb](https://github.com/EddieKaleb)
- [Gabriel de Sousa](https://github.com/GabrielSBarros)
- [Vinícius de Farias](https://github.com/ViniFarias)
- [Rayla Medeiros](https://github.com/RaylaMedeiros)
 

