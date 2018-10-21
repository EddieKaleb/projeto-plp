import System.IO
import Data.Char
import qualified System.Process


-- Representação de uma carta
data Card = Card {
    naipe :: String,
    value :: String
} deriving (Show)

-- Representação de um jogador
data Player = Player {
    hand :: [Card],
    chips :: Int,
    active :: Bool
} deriving (Show)

-- Representação de um deck
data Deck = Deck {
    cards :: [Card]
} deriving (Show)

data GameStatus = GameStatus {
    cardsTable :: [Card],
    playersTable :: [Player],
    dealerPosition :: Int,
    lastBet :: Int,
    minimumBet :: Int,
    activePlayers :: Int,
    currentRound :: Int,
    userPosition :: Int
} deriving (Show)

{-
    Inicia o jogo
-}
startGame :: IO()
startGame = do
    -- playersTable = setPlayers (Configura os jogadores da partida, com um valor default de chips)
    -- dealer_position = setInitialDealerPosition (Configura a posição inicial do dealer de forma aleatória)

    runMatch


{-
    Roda uma partida.
-}
runMatch :: IO()
runMatch = do
    -- deck = buildDeck
    -- cardsTable = setCardsTable

    runTurn 0


{-
    Roda os quatro turnos de uma partida.
    @param Int Identificador do turno.
-}
runTurn :: Int -> IO()
runTurn turnId
    | turnId < 4 = do
                    --selectTurn turnId
                    putStrLn ("Turno: " ++ show turnId)
                    runTurn (turnId + 1)


{-
    Executa um método de turno específico com base no identificador do turno.
    @param Int Identificador do turno.
-}
{-selectTurn :: Int -> IO()
selectTurn 0 = preFlopRound
selectTurn 1 = flopRound
selectTurn 2 = turnRound
selectTurn 3 = riverRound
-}


{-
    Executa o turno de pre flop.
    @param GameStatus Estado atual do jogo.
-}
preFlopRound :: GameStatus -> IO GameStatus
preFlopRound gameStatus = do
    let smallPosition = (nextPlayerPosition (dealerPosition gameStatus))
    let bigPosition = nextPlayerPosition smallPosition

    -- Last bet
    let lb = minimumBet gameStatus

    -- botsPreFlop (criar método)

    -- callAction smallPosition

    -- Minimum bet
    let mb = (minimumBet gameStatus) * 2

    -- Last bet
    let nlb = mb

    -- callAction bigPosition

    let gs = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) nlb 2 (activePlayers gameStatus) 0 (userPosition gameStatus)

    return (runPreFlopRound gs (nextPlayerPosition bigPosition) smallPosition)


runPreFlopRound :: GameStatus -> Int -> Int -> GameStatus
runPreFlopRound gameStatus beginPosition endPosition = do
    let currentPosition = beginPosition

    if ((activePlayers gameStatus) >= 2)
        then return (runPreFlopRound' gameStatus currentPosition endPosition)
    else return gameStatus

runPreFlopRound' :: GameStatus -> Int -> Int -> GameStatus
runPreFlopRound' gameStatus currentPosition endPosition = do
    -- showTable currentPosition

    if (active ((playersTable gameStatus) !! currentPosition) == true)
        then do
            putStrLn ("Jogando: Player " ++ (currentPosition + 1))
            putStrLn ("Jogadores ativos: " ++ show (activePlayers gameStatus))
            putStrLn ("Última aposta: " ++ (lastBet gameStatus))
            putStrLn ("Aposta mínima: " ++ (minimumBet gameStatus))
            sleep 2

            if (currentPosition == userPosition gameStatus)
                then (showUserActions round currentPosition)
            else (botActions round currentPosition)
    else _

    -- showTable currentPosition

    sleep 2

    let nextPosition = nextPlayerPosition currentPosition

    -- Atualizar o gameStatus (Implementar)

    if not (nextPosition == nextPlayerPosition endPosition)
        then return (runPreFlopRound' gameStatus nextPosition endPosition)
    else _

    return gameStatus

{-
flopRound :: IO()
flopRound = do
    -}

{-
    Retorna a posição do próximo jogador com base na posição do jogador atual.
    @param Int Posição do jogador atual.
    @param Int Quantidade de jogadores.

setGameStatus :: [Card] -> [Player] -> Int -> Int -> Int -> Int -> Int -> IO GameStatus
setGameStatus cards playersTable dealerPosition lastBet minimumBet activePlayers currentRound userPosition = do
    return (GameStatus cards playersTable dealerPosition lastBet minimumBet activePlayers currentRound userPosition)
-}
{-
    Retorna a posição do próximo jogador com base na posição do jogador atual.
    @param Int Posição do jogador atual.
    @param Int Quantidade de jogadores.
-}
nextPlayerPosition :: Int -> Int
nextPlayerPosition position = mod (position + 1) qtd_players

clearScreen :: IO()
clearScreen = do
    _ <- System.Process.system "clear"
    return ()

sleep :: Int -> IO()
sleep seg = do
    _ <- System.Process.system ("sleep " ++ ((intToDigit seg) : "s"))
    return ()

qtd_players :: Int
qtd_players = 6	

{-
lastBet :: Int
lastBet = 2 -- Teste
-}

-- setNextDealerPosition :: Int -> Int
-- setNextDealerPosition DEALER_POSITION = do
--     return nextPlayerPosition DEALER_POSITION
	
invalidAction :: IO()
invalidAction = putStrLn("Ação inválida")

-- Ligações entre menu de seleção e métodos de ação
checkPlayerAction :: Int -> Bool
checkPlayerAction round = (checkAction round)

callPlayerAction :: Int -> IO()
callPlayerAction position 
 	| not(callAction position) = invalidAction
 	| otherwise = putStrLn("")

-- Realiza a ação de 'Mesa' (Passar a vez).
checkAction :: Int -> Bool
checkAction round = (round /= 0)

-- Realiza a ação de 'Pagar'.
callAction :: Int -> Bool
callAction position = False
--     if(playersTable[position].chips >= MINIMUM_BET){
--         lastBet = MINIMUM_BET;
--         if(lastBet == 0){
--             firstBetPlayerPosition = position;
--         }

--         playersTable[position].chips -= MINIMUM_BET;
--         POT += MINIMUM_BET;

--         return true;
--     }

--     return false;
-- }

-- Realiza a ação de 'Desistir' (Encerrar o jogo).
-- foldAction :: Int -> IO()
-- foldAction position = disablePlayer position

-- Realiza a ação de 'Sair' da mesa.showTable
exitAction :: IO()
exitAction = do
	clearScreen
	putStrLn("Até a próxima!")
	-- Faltou exit

main :: IO ()
main = do
    startGame