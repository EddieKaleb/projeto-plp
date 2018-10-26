module Table (
    startGame
) where

import System.IO
import Data.Char
import Data.Time.Clock.POSIX
import Control.Monad
import qualified System.Process
import Model
import Deck
import Hands
import HandProb
import System.IO.Unsafe
import System.Random
import TableOutput


{-
    Configura o estado inicial do jogo.
-}
setInitialGameStatus :: IO GameStatus
setInitialGameStatus = do
    let card = Card " " " "

    newDeck1 <- shuffleDeck
    let newDeck2 = Deck newDeck1

    let cards = [card, card, card, card, card]
    let player = Player [card, card] 100 True 0 0 0 0
    let players = [player, player, player, player, player, player]
    let lastBet = 0
    let minimumBet = 2
    let activePlayers = 6
    let currentRound = 0
    let userPosition = 0
    let valPot = 0
    let firstBetPlayerPosition = -1
    let actualPlayer = 0

    let dealerPos = getRandomInteger (0,5)
    let exitValue = False

    putStrLn("DealerPos: " ++ show(dealerPos))

    return (GameStatus cards players dealerPos lastBet minimumBet activePlayers currentRound 
         userPosition valPot firstBetPlayerPosition actualPlayer newDeck2 exitValue)


buildGameStatus :: GameStatus -> IO GameStatus
buildGameStatus gs = do
    let card = Card " " " "

    newDeck1 <- shuffleDeck
    let newDeck2 = Deck newDeck1

    let cards = [card, card, card, card, card]
    let lastBet = 0
    let minimumBet = 2
    let activePlayers = 6
    let currentRound = 0
    let userPosition = 0
    let valPot = 0
    let firstBetPlayerPosition = -1
    let actualPlayer = 0

    let dealerPos = nextPlayerPosition(dealerPosition gs)
    let exitValue = False

    putStrLn("DealerPos: " ++ show(dealerPos))
    let activedPlayers = activePlayersTable (playersTable gs)
    return (GameStatus cards activedPlayers dealerPos lastBet minimumBet activePlayers currentRound 
         userPosition valPot firstBetPlayerPosition actualPlayer newDeck2 exitValue)  


activePlayersTable :: [Player] -> [Player]
activePlayersTable [] = []
activePlayersTable (x:xs) = do
    (setActive True x) : activePlayersTable xs

{-
    Gera um número aleatório.
-}
getRandomInteger :: (Int,Int) -> Int
getRandomInteger (a,b) = unsafePerformIO(randomRIO (a,b))  

{-
    Inicia o jogo.
-}
startGame :: IO()
startGame = do

    runGame
    clearScreen
    putStrLn("O jogo acabou.")
    sleep 5


runGame :: IO GameStatus
runGame = do
    gameStatus <- setInitialGameStatus
    runMatch gameStatus


{-
    Roda as partidas.
-}
runMatch :: GameStatus -> IO GameStatus
runMatch currentGameStatus = do
        let gameStatus = buildGameStatus currentGameStatus
        let cards = getHandsPlayers (deck currentGameStatus)
        let newGs = setHandsPlayers cards currentGameStatus

        newGs2 <- preFlopRound newGs

        runMatch newGs2


{-
    Executa o turno de pre flop.
    @param gameStatus Estado atual do jogo.
-}
preFlopRound :: GameStatus -> IO GameStatus
preFlopRound gameStatus = do
    putStrLn("preFlopRound")
    let smallPos = smallPosition gameStatus
    let bigPos = bigPosition gameStatus

    let newGs1 = snd (callAction (setActualPlayer smallPos gameStatus))
    let newGs2 = setMinimumBet ((minimumBet newGs1) * 2) newGs1
    let newGs3 = snd (callAction (setActualPlayer bigPos newGs2))
    gs <- preFlopActions (nextPlayerPosition bigPos) bigPos newGs3
    flopRound gs


{-
    Executa as ações de turno para cada jogador.
    @param currenPosition Posição atual do jogador.
    @param endPosition Posição final de parada das ações do pre flop.
    @param gameStatus Estado atual do jogo.
-}
preFlopActions :: Int -> Int -> GameStatus -> IO GameStatus
preFlopActions currentPosition endPosition gameStatus 
    | exit gameStatus == True = return newGameStatus
    | (activePlayers gameStatus) < 2 = return newGameStatus
    | currentPosition == endPosition = return newGameStatus
    | not(active((playersTable gameStatus) !! currentPosition)) = do
        showTable newGameStatus
        preFlopActions (nextPlayerPosition currentPosition) endPosition newGameStatus
    | currentPosition == (userPosition newGameStatus) = do
        showTable newGameStatus
        sleep 4
        gs <- showUserActions newGameStatus
        showTable gs
        preFlopActions (nextPlayerPosition currentPosition) endPosition gs
    | otherwise = do
        showTable newGameStatus
        sleep 4
        gs <- botActions newGameStatus currentPosition
        showTable gs
        preFlopActions (nextPlayerPosition currentPosition) endPosition gs
    where newGameStatus = setActualPlayer currentPosition gameStatus


{-
    Executa o turno de flop.
    @param gameStatus Estado atual do jogo. 
-}
flopRound :: GameStatus -> IO GameStatus
flopRound gameStatus = do
    let newTableCards = getTableCards (deck gameStatus) (cardsTable gameStatus)
    let newGameStatus = setCardsTable (newTableCards) gameStatus

    let smallPos = smallPosition newGameStatus

    let newGs1 = setCurrentRound 1 (setActualPlayer smallPos newGameStatus)
    let newGs2 = setFirstBetPlayerPosition 10 newGs1
    let newGs3 = setLastBet 0 newGs2

    gs <- runRound smallPos newGs3
    turnRound gs


{-
    Executa o turno de round.
    @param gameStatus Estado atual do jogo. 
-}
turnRound :: GameStatus -> IO GameStatus
turnRound gameStatus = do
    let newTableCards = getTableCards (deck gameStatus) (cardsTable gameStatus)
    let newGameStatus = setCardsTable (newTableCards) gameStatus

    let smallPos = smallPosition newGameStatus

    let newGs1 = setCurrentRound 2 (setActualPlayer smallPos newGameStatus)
    let newGs2 = setFirstBetPlayerPosition 10 newGs1
    let newGs3 = setLastBet 0 newGs2
    let newGs4 = setMinimumBet ((minimumBet newGs3) * 2) newGs3

    gs <- runRound smallPos newGs4
    riverRound gs


{-
    Executa o turno de river.
    @param gameStatus Estado atual do jogo. 
-}
riverRound :: GameStatus -> IO GameStatus
riverRound gameStatus = do
    let newTableCards = getTableCards (deck gameStatus) (cardsTable gameStatus)
    let newGameStatus = setCardsTable (newTableCards) gameStatus
    
    let smallPos = smallPosition newGameStatus

    let newGs1 = setCurrentRound 3 (setActualPlayer smallPos newGameStatus)
    let newGs2 = setFirstBetPlayerPosition 10 newGs1
    let newGs3 = setLastBet 0 newGs2

    gs <- runRound smallPos newGs3
    return gs


{-
    Executa um round.
    @param currentPosition Posição do jogador atual.
    @param gameStatus Estado atual do jogo.
-}
runRound :: Int -> GameStatus -> IO GameStatus
runRound currentPosition gameStatus
    | exit gameStatus == True = return gameStatus
    | (activePlayers gameStatus) < 2 = return gameStatus
    | currentPosition == (firstBetPlayerPosition gameStatus) = return newGameStatus
    | not(active((playersTable gameStatus) !! currentPosition)) = do
        showTable newGameStatus
        runRound (nextPlayerPosition currentPosition) newGameStatus
    | currentPosition == (userPosition newGameStatus) = do
        showTable newGameStatus
        gs <- showUserActions newGameStatus
        showTable gs
        runRound (nextPlayerPosition currentPosition) gs
    | otherwise = do
        showTable newGameStatus
        sleep 4
        gs <- botActions newGameStatus currentPosition
        showTable gs
        runRound (nextPlayerPosition currentPosition) gs
    where newGameStatus = setActualPlayer currentPosition gameStatus


{-
    Exibe o menu de ações do jogador.
    @param gameStatus Estado atual do jogo.
-}
showUserActions :: GameStatus -> IO GameStatus
showUserActions gameStatus = do
    clearScreen

    showTable gameStatus

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
    @param option Opção escolhida pelo jogador.
    @param gameStatus Estado atual do jogo.
-}
selectAction :: Int -> GameStatus -> IO GameStatus
selectAction 1 gameStatus = checkPlayerAction gameStatus
selectAction 2 gameStatus = callPlayerAction gameStatus
selectAction 3 gameStatus = do
    return (foldAction gameStatus)
selectAction 4 gameStatus = exitAction gameStatus


{-
    Executa as ações de um jogador bot.
    @param gameStatus Estado atual do jogo.
-}
botActions :: GameStatus -> Int -> IO GameStatus
botActions gs pos 
    | ((currentRound gs) == 0 && (bigPosition gs /= pos) && getRandomInteger (0,3) > floor(preFlopProb ((playersTable gs) !! pos) /10 * 1.15)) = return (foldAction gs)
    | (((currentRound gs) == 0) && (fst (callAction gs)) == False) = return (foldAction gs)
    | (currentRound gs) <= 3 && getRandomInteger (0,3) > floor(flopToTurnProb ((playersTable gs) !! pos) /10 * 1.15) = return (foldAction gs)
    | (currentRound gs) <= 3 && (lastBet gs) /= 0 && not(fst (callAction gs)) = return (foldAction gs)
    | (currentRound gs) <= 3 && getRandomInteger (0,3) > floor(flopToTurnProb ((playersTable gs) !! pos) /10 * 1.15) && not(fst (callAction gs)) = return (foldAction gs)
    | (checkAction gs == True) = return gs
    | otherwise = return gs

{-
    Define a quantidade de jogadores.
-}
qtdPlayers :: Int
qtdPlayers = 6 


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

{-
    Configura a próxima posição do dealer.
    @param gs Estado atual do jogo.
-}
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

callPlayerAction :: GameStatus -> IO GameStatus
callPlayerAction gs 
    | not(fst (callAction gs)) = do
        invalidAction
        return gs
    | otherwise = do
        putStrLn("")
        return (snd (callAction gs))


-- Realiza a ação de 'Mesa' (Passar a vez).
checkAction :: GameStatus -> Bool
checkAction gs = ((currentRound gs) /= 0 && (lastBet gs) == 0)


-- Realiza a ação de 'Pagar'.
callAction :: GameStatus -> (Bool, GameStatus)
callAction gs
    | ((chips ((playersTable gs) !! (actualPlayer gs))) >= (minimumBet gs)) = do
        let newGs = callAux gs
        (True, newGs)
    | otherwise = (False, gs)


callAux :: GameStatus -> GameStatus
callAux gs 
    | ((lastBet gs) == 0) = do
        let firstBet = (actualPlayer gs)
        let newLastBet = (minimumBet gs)
        let newChips = (chips ((playersTable gs) !! (actualPlayer gs))) - (minimumBet gs)
        let newPlayer = setChips newChips ((playersTable gs) !! (actualPlayer gs))
        let newPot = (pot gs) + (minimumBet gs)
        let newPlayers1 = players [] gs 0 newPlayer
        let newPlayers2 = auxPlayers newPlayers1 gs ((actualPlayer gs) + 1)
        let newGS = GameStatus (cardsTable gs) newPlayers2 (dealerPosition gs) newLastBet (minimumBet gs) (activePlayers gs) (currentRound gs) (userPosition gs) newPot firstBet (actualPlayer gs) (deck gs) (exit gs)
 
        newGS
     | otherwise = do
        let newLastBet = (minimumBet gs)
        let newChips = (chips ((playersTable gs) !! (actualPlayer gs))) - (minimumBet gs)
        let newPlayer = setChips newChips ((playersTable gs) !! (actualPlayer gs))
        let newPot = (pot gs) + (minimumBet gs)
        let newPlayers1 = players [] gs 0 newPlayer
        let newPlayers2 = auxPlayers newPlayers1 gs ((actualPlayer gs) + 1)
        let newGS = GameStatus (cardsTable gs) newPlayers2 (dealerPosition gs) newLastBet (minimumBet gs) (activePlayers gs) (currentRound gs) (userPosition gs) newPot (firstBetPlayerPosition gs) (actualPlayer gs) (deck gs) (exit gs)
 
        newGS
 
players :: [Player] -> GameStatus -> Int -> Player -> [Player]
players newPlayers gs i newPlayer
    | (i == (actualPlayer gs)) = newPlayers++[newPlayer]
    | otherwise = players (newPlayers++[((playersTable gs) !! i)]) gs (i + 1) newPlayer
 
auxPlayers :: [Player] -> GameStatus -> Int -> [Player]
auxPlayers newPlayers gs i
    | i >= qtdPlayers = newPlayers
    | (i == (qtdPlayers - 1)) = newPlayers++[((playersTable gs) !! i)]
    | otherwise = auxPlayers (newPlayers++[((playersTable gs) !! i)]) gs (i + 1)
 
-- Realiza a ação de 'Desistir' (Encerrar o jogo).
foldAction :: GameStatus -> GameStatus
foldAction gs = do
    let newPlayer = setActive False ((playersTable gs) !! (userPosition gs))
    let newPlayers1 = players [] gs 0 newPlayer
    let newPlayers2 = auxPlayers newPlayers1 gs ((actualPlayer gs) + 1)
    let newGs1 = setPlayersTable newPlayers2 gs
    let newGs2 = setActivePlayers ((activePlayers gs) - 1) newGs1
     
    newGs2

-- Realiza a ação de 'Sair' da mesa.showTable
exitAction :: GameStatus -> IO GameStatus
exitAction gs = do
    clearScreen
    putStrLn("                  Até a próxima !!!")
    sleep 3
    return (setExit True gs)


showTable :: GameStatus -> IO()
showTable gs = do
    clearScreen
    printRoundName (currentRound gs)
    printTable gs
    putStrLn("Jogando: Jogador " ++ show((actualPlayer gs) + 1))
    putStrLn("Jogandores ativos: " ++ show((activePlayers gs)))
    putStrLn("Última aposta: " ++ show(lastBet gs))
    putStrLn("Aposta mínima: " ++ show(minimumBet gs))


{-
    Printa o nome do round de acordo com o seu identificador.
-}
printRoundName :: Int -> IO()
printRoundName 0 = putStrLn("                                      PreFlop Round")
printRoundName 1 = putStrLn("                                      Flop Round")
printRoundName 2 = putStrLn("                                      Turn Round")
printRoundName 3 = putStrLn("                                      River Round")


main :: IO ()
main = do
    startGame

getImproveProb :: Float -> Float
getImproveProb outs = (outs * 4) - (outs - 8)

getImproveHandProb :: String -> Float
getImproveHandProb hand | (hand == "IS_ONE_PAIR") = (getImproveProb 5) / 100
                        | (hand == "IS_TWO_PAIR") = (getImproveProb 4) / 100
                        | (hand == "IS_THREE") = (getImproveProb 8) / 100
                        | (hand == "IS_STRAIGHT") = (getImproveProb 1) / 100
                        | (hand == "IS_FLUSH") = (getImproveProb 2) / 100
                        | (hand == "IS_FULL_HOUSE") = (getImproveProb 1) / 100
                        | (hand == "IS_HIGH_CARD") = (getImproveProb 15) / 100
                        | otherwise = (getImproveProb 0) / 100

mapHands :: String -> Int
mapHands flag | (flag == "IS_HIGH_CARD") = 1
              | (flag == "IS_ONE_PAIR") = 2
              | (flag == "IS_TWO_PAIR") = 3
              | (flag == "IS_THREE") = 4
              | (flag == "IS_STRAIGHT") = 5
              | (flag == "IS_FLUSH") = 6
              | (flag == "IS_FULL_HOUSE") = 7
              | (flag == "IS_FOUR") = 8
              | (flag == "IS_STRAIGHT_FLUSH") = 9
              | otherwise = 10


setWinners :: GameStatus -> IO()
setWinners gs = do 
   putStrLn "\n***********************"
   putStrLn "*      FINALISTAS     *"
   putStrLn "***********************\n"
   let finalists = getFinalists gs (playersTable gs) []
   let sFin = showFinalists finalists 0 (length finalists)
   putStrLn "\n***********************"
   putStrLn "*      VENCEDORES     *" 
   putStrLn "***********************\n"
   let winners = getWinners gs (playersTable gs) [] 0
   let sWin = showFinalists winners 0 (length finalists)
   let val = (pot gs) `div` length winners
   let result = shareChips winners [] val
   putStrLn ""


shareChips :: [Player] -> [Player] -> Int -> [Player]
shareChips [] players _ = players 
shareChips (x:xs) players bonus = shareChips xs (players++[setChips bonus x]) bonus

getFinalists :: GameStatus -> [Player] -> [Player] -> [Player]
getFinalists _ [] finalists = finalists 
getFinalists gs (x:xs) finalists | (active x) == True = getFinalists gs xs (finalists++[x]) 
                                 | otherwise = getFinalists gs xs finalists

getWinners :: GameStatus -> [Player] -> [Player] -> Int -> [Player]
getWinners _ [] winners _  = winners
getWinners gs (x:xs) winners bigger | (mapHands (verifyHand (hand x) (cardsTable gs) 7) > bigger) && ((active x) == True) = getWinners gs xs [x] (mapHands (verifyHand (hand x) (cardsTable gs) 7))
                                      | (mapHands (verifyHand (hand x) (cardsTable gs) 7) == bigger) && ((active x) == True)= getWinners gs xs (winners++[x]) bigger
                                      | otherwise = getWinners gs xs winners bigger

showFinalists :: [Player] -> Int -> Int -> IO()
showFinalists (x:xs) pos total | (pos == (total - 1)) =  putStrLn  ("- JOGADOR " ++ show(pos) ++ " -> HAND: " ++ (value ((hand x) !! 0)) ++ (naipe ((hand x) !! 0)) ++ " " ++ (value ((hand x) !! 1)) ++ (naipe ((hand x) !! 1)))
    | otherwise = do 
        putStrLn  ("- JOGADOR " ++ show(pos) ++ " -> HAND: " ++ (value ((hand x) !! 0)) ++ (naipe ((hand x) !! 0)) ++ " " ++ (value ((hand x) !! 1)) ++ (naipe ((hand x) !! 1)))
        showFinalists xs (pos+1) total

setPlayersPreFlopProb :: [Player] -> [Player]
setPlayersPreFlopProb [] = []
setPlayersPreFlopProb (x:xs) = do
    let prob = unsafePerformIO((get_prob ((hand x) !! 0) ((hand x) !! 1) 6))
    setPreFlopProb prob x : setPlayersPreFlopProb xs

setPlayersFlopToTurnProb :: GameStatus -> [Player] -> [Player]
setPlayersFlopToTurnProb _ [] = []
setPlayersFlopToTurnProb gs (x:xs) = do
    let playerHand = verifyHand (hand x) (cardsTable gs) 5
    let prob = (preFlopProb x) * (1 - (getImproveHandProb playerHand))
    setFlopToTurnProb prob x : setPlayersPreFlopProb xs

setPlayersTurnToRiverProb :: GameStatus -> [Player] -> [Player]
setPlayersTurnToRiverProb _ [] = []
setPlayersTurnToRiverProb gs (x:xs) = do
    let playerHand = verifyHand (hand x) (cardsTable gs) 5
    let prob = (flopToTurnProb x) * (1 - (getImproveHandProb playerHand))
    setTurnToRiverProb prob x : setPlayersPreFlopProb xs

setPlayersRiverToShowDown :: GameStatus -> [Player] -> [Player]
setPlayersRiverToShowDown _ [] = []
setPlayersRiverToShowDown gs (x:xs) = do
    let playerHand = verifyHand (hand x) (cardsTable gs) 5
    let prob = (turnToRiverProb x) * (1 - (getImproveHandProb playerHand))
    setRiverToShowDownProb prob x : setPlayersPreFlopProb xs