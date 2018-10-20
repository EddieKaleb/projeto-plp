import System.IO
import Data.Char
import qualified System.Process


-- Representação de uma carta
data Card = Card {
    naipe :: String
    value :: String
} deriving (Show)

-- Representação de um jogador
data Player = Player {
    hand :: [Card],
    chips :: Int
} deriving (Show)

-- Representação de um deck
data Deck = Deck {
    cards :: [Card]
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
                    selectTurn turnId
                    runTurn (turnId + 1)
    | otherwise = return


{-
    Executa um método de turno específico com base no identificador do turno.
    @param Int Identificador do turno.
-}
selectTurn :: Int -> IO()
selectTurn 0 = preFlopRound
selectTurn 1 = flopRound
selectTurn 2 = turnRound
selectTurn 3 = riverRound


{-
    Retorna a posição do próximo jogador com base na posição do jogador atual.
    @param Int Posição do jogador atual.
    @param Int Quantidade de jogadores.
-}
nextPlayerPosition :: Int -> Int -> Int
nextPlayerPosition position qtdPlayers = (position + 1) 'mod' qtdPlayers

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

lastBet :: Int
lastBet = 2 -- Teste

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