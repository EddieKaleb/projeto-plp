module Model (
	Card(..),
	Player(..),
	Deck(..),
	GameStatus(..),
	setPot,
	setDealerPosition,
	setLastBet,
	setCurrentRound,
	setMinimumBet,
	setCardsTable,
	setPlayersTable
) where


{-
    Representação de uma carta.
-}
data Card = Card {
    naipe :: String,
    value :: String
} deriving (Show);


{-
    Representação de um jogador.
-}
data Player = Player {
    hand :: [Card],
    chips :: Int,
    active :: Bool
} deriving (Show);


{-
    Representação de um deck.
-}
data Deck = Deck {
    cards :: [Card]
} deriving (Show);


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
    userPosition :: Int,
    pot :: Int
} deriving (Show);


---------- MÉTODOS AUXILIARES DE MANIPULAÇÃO DA GAMESTATUS  ----------
setPot :: Int -> GameStatus -> GameStatus
setPot value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) value

    gm


setDealerPosition :: Int -> GameStatus -> GameStatus
setDealerPosition value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) value (lastBet gameStatus)
    	 (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus)

    gm


setLastBet :: Int -> GameStatus -> GameStatus
setLastBet value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) value
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus)

    gm


setCurrentRound :: Int -> GameStatus -> GameStatus
setCurrentRound value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) value (userPosition gameStatus) (pot gameStatus)

    gm


setMinimumBet :: Int -> GameStatus -> GameStatus
setMinimumBet value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         value (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus)

    gm


setCardsTable :: [Card] -> GameStatus -> GameStatus
setCardsTable value gameStatus = do
    let gm = GameStatus value (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus)

    gm


setPlayersTable :: [Player] -> GameStatus -> GameStatus
setPlayersTable value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) value (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus)

    gm
---------- FIM DOS MÉTODOS AUXILIARES DE MANIPULAÇÃO DA GAMESTATUS