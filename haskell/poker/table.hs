import System.IO
import Data.Char
import qualified System.Process

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