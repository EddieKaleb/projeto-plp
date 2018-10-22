import System.IO
import Data.Char
import qualified System.Process
import GameStatusUtil.Card

{-
    Representação de uma carta.
-}
data Card = Card {
    naipe :: String,
    value :: String
} deriving (Show)


{-
    Representação de um jogador.
-}
data Player = Player {
    hand :: [Card],
    chips :: Int,
    active :: Bool
} deriving (Show)


{-
    Representação de um deck.
-}
data Deck = Deck {
    cards :: [Card]
} deriving (Show)


{-
    Representação de um estado do jogo.
-}
data GameStatus = GameStatus {
    cardsTable :: [Card],
    playersTable :: [Player],
    dealerPosition :: Int,
    lastBet :: Int,
    minimumBet :: Int,
    activePlayers :: Int,
    currentRound :: Int,
    userPosition :: Int
} deriving (Show)-}


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
    let lastBet = 2
    let minimumBet = 2
    let activePlayers = 6
    let currentRound = 0
    let userPosition = 0

    GameStatus cards players dealerPos lastBet minimumBet activePlayers currentRound userPosition


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
    preFlopActions (nextPlayerPosition bigPos) bigPos gameStatus



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


{-
    Retorna a posição do próximo jogador com base na posição do jogador atual.
    @param position Posição do jogador atual.
-}
nextPlayerPosition :: Int -> Int
nextPlayerPosition position = mod (position + 1) qtdPlayers


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