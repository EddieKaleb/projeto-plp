import System.IO
import Data.Char
import qualified System.Process
import Model



{-
    Configura o estado inicial do jogo.
-}
setInitialGameStatus :: GameStatus
setInitialGameStatus = do
    let card = Card " " " "
    let cards = [card, card, card, card, card]

    let player = Player [card, card] 200 True
    let players = [player, player, player, player, player, player]

    let dealerPos = 0
    let lastBet = 2 -- Acho que deve ser 0
    let minimumBet = 2
    let activePlayers = 6
    let currentRound = 0
    let userPosition = 0
    let valPot = 0

    GameStatus cards players dealerPos lastBet minimumBet activePlayers currentRound userPosition valPot


{-
    Inicia o jogo.
-}
startGame :: IO()
startGame = do
    -- playersTable = setPlayers (Configura os jogadores da partida, com um valor default de chips)
    -- dealer_position = setInitialDealerPosition (Configura a posição inicial do dealer de forma aleatória)

    runMatch
    putStrLn("O jogo acabou.")


{-
    Roda uma partida.
-}
runMatch :: IO GameStatus
runMatch = do
    let currentGameStatus = setInitialGameStatus
    preFlopRound currentGameStatus


{-
    Executa o turno de pre flop.
    @param GameStatus Estado atual do jogo.
-}
preFlopRound :: GameStatus -> IO GameStatus
preFlopRound gameStatus = do
    --putStrLn (show gameStatus)
    let smallPos = smallPosition gameStatus
    let bigPos = bigPosition gameStatus

    let isValidA = callAction smallPos
    let isValidB = callAction bigPos
    newGameStatus <- preFlopActions (nextPlayerPosition bigPos) bigPos gameStatus
    flopRound newGameStatus

flopRound :: GameStatus -> IO GameStatus
flopRound gameStatus = do

    -- Configura as 3 cartas da mesa (Implementar)

    runRound gameStatus -- (Implementar)

{-
    Executa as ações de turno para cada jogador.
-}
preFlopActions :: Int -> Int -> GameStatus -> IO GameStatus
preFlopActions currentPosition endPosition gameStatus 
    | currentPosition == endPosition = return gameStatus
    | not(active((playersTable gameStatus) !! currentPosition)) = do
        preFlopActions (nextPlayerPosition currentPosition) endPosition gameStatus
    | currentPosition == (userPosition gameStatus) = do
        gm <- showUserActions gameStatus
        preFlopActions (nextPlayerPosition currentPosition) endPosition gm
    | otherwise = do
        gm <- botActions gameStatus
        preFlopActions (nextPlayerPosition currentPosition) endPosition gm


{-
    Exibe o menu de ações do jogador.
-}
showUserActions :: GameStatus -> IO GameStatus
showUserActions gameStatus = do
    clearScreen

    -- showTable (Implementar)

    putStrLn "\n\n-----------------------------     AÇÕES     -----------------------------\n\n"
    putStrLn "          1  -  Mesa"
    putStrLn "          2  -  Apostar"
    putStrLn "          3  -  Desistir"
    putStrLn "          4  -  Sair da mesa"

    option <- getOption
    selectAction option gameStatus


{-
    Recebe do usuário uma opção como entrada.
-}
getOption :: IO Int
getOption = do
    putStrLn "\n\n                    Digite o número da opção desejada: "
    option <- getLine
    return $ read option


{-
    Interpreta a ação escolhida pelo jogador.
-}
{- Adicionar:
    selectAction 3 gameStatus = foldAction gameStatus
    selectAction 1 gameStatus = checkPlayerAction gameStatus
    selectAction 2 gameStatus = callPlayerAction gameStatus
    selectAction 4 gameStatus = exitAction gameStatus
-}
selectAction :: Int -> GameStatus -> IO GameStatus
selectAction option gameStatus = do
    return setInitialGameStatus

{-
    Executa as ações de um jogador bot.
-}
botActions :: GameStatus -> IO GameStatus
botActions gameStatus = do
    putStrLn "Bot Actions"

    return setInitialGameStatus


{-
    Retorna a posição do small.
-}
smallPosition :: GameStatus -> Int
smallPosition gameStatus = nextPlayerPosition(dealerPosition gameStatus)

{-
    Retorna a posição do big.
-}
bigPosition :: GameStatus -> Int
bigPosition gameStatus = nextPlayerPosition(smallPosition gameStatus)


{-
    Define a quantidade de jogadores.
-}
qtdPlayers :: Int
qtdPlayers = 6 


-- Retorna a posição do próximo jogador com base na posição do jogador atual.

nextPlayerPosition :: Int -> Int
nextPlayerPosition pos = (mod (pos + 1) qtdPlayers)


{-
    Limpa a tela de comandos.
-}
clearScreen :: IO()
clearScreen = do
    _ <- System.Process.system "clear"
    return ()


{-
    Faz com que a execução do programa pare por um tempo determinado.
    @param seg Tempo de parada em segundos.
-}
sleep :: Int -> IO()
sleep seg = do
    _ <- System.Process.system ("sleep " ++ ((intToDigit seg) : "s"))
    return ()


setNextDealerPosition :: GameStatus -> GameStatus
setNextDealerPosition gs = do
    let newDealer = nextPlayerPosition (dealerPosition gs)
    setDealerPosition newDealer gs
	
invalidAction :: IO()
invalidAction = putStrLn("Ação inválida")

-- Ligações entre menu de seleção e métodos de ação
checkPlayerAction :: GameStatus -> IO GameStatus
checkPlayerAction gs
    | not(checkAction gs) = do
        invalidAction
        showUserActions gs
        return gs
    | otherwise = return gs

callPlayerAction :: GameStatus -> IO()
callPlayerAction gs 
    | not(callAction (userPosition gs)) = invalidAction
    | otherwise = putStrLn("")

-- Realiza a ação de 'Mesa' (Passar a vez).
checkAction :: GameStatus -> Bool
checkAction gs = ((currentRound gs) /= 0 && (lastBet gs) == 0)

-- Realiza a ação de 'Pagar'.
callAction :: Int -> Bool
callAction gs = False
--     | (chips ((playersTable gs) !! (userPosition gs))) >= (minimumBet gs)) = do
--         | ((lastBet gs) == 0) = do
--             let firstBetPlayerPosition = (userPosition gs)
--             let newGs = GameStatus (cardsTable gs) (playersTable gs) (dealerPosition gs) (minimumBet gs) (minimumBet gs) (activePlayers gs) (currentRound gs) (userPosition gs) (pot gs)
--         | otherwise = (newGs = GameStatus (cardsTable gs) (playersTable gs) (dealerPosition gs) (minimumBet gs) (minimumBet gs) (activePlayers gs) (currentRound gs) (userPosition gs) (pot gs))

--     | otherwise = gs

--         playersTable[position].chips -= MINIMUM_BET;
--         POT += MINIMUM_BET;

--         return true;
--     }

--     return false;
-- }

disablePlayer :: Player -> Player
disablePlayer player = do
    let newStatus = False
    Player (hand player) (chips player) (newStatus)

-- Realiza a ação de 'Desistir' (Encerrar o jogo).
-- foldAction :: GameStatus -> Player
-- foldAction gs = (disablePlayer ((playersTable gs) !! (userPosition gs)))

-- Realiza a ação de 'Sair' da mesa.showTable
exitAction :: IO()
exitAction = do
	clearScreen
	putStrLn("Até a próxima!")
	-- Faltou exit




main :: IO ()
main = do
    startGame