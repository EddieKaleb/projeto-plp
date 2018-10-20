import System.IO
import qualified System.Process

clearScreen :: IO()
clearScreen = do
    _ <- System.Process.system "clear"
    return ()

-- sleep :: Int -> IO()
-- sleep seg = do
--     _ <- System.Process.system ("sleep " ++ seg ++ "s")
--     return ()

lastBet :: Int
lastBet = 2

-- Int QTD_PLAYERS = 6

-- setNextDealerPosition :: Int -> Int
-- setNextDealerPosition DEALER_POSITION = do
--     return nextPlayerPosition DEALER_POSITION
	
invalidAction :: IO()
invalidAction = putStrLn("Ação inválida")

-- Ligações entre menu de seleção e métodos de ação
checkPlayerAction :: Int -> Bool
checkPlayerAction round = if not(checkAction round)
							then return False -- Falta wait
							else return True

-- callPlayerAction :: Int -> IO()
-- callPlayerAction position = do
-- 	if not(callAction position)
-- 		then invalidAction
-- 		else putStrLn("")

-- Realiza a ação de 'Mesa' (Passar a vez).
checkAction :: Int -> Bool
checkAction round = if (round /= 0)-- && lastBet == 0)
						then return True
						else return False

-- Realiza a ação de 'Pagar'.
-- callAction :: Int -> Bool
-- callAction position = do
-- 	if ((playersTable !!position))
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