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
	setPlayersTable,
	setActualPlayer
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
    active :: Bool,
    preFlopProb :: Float,
    flopToTurnProb :: Float,
    turnToRiverProb :: Float,
    riverToShowDownProb :: Float
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
    pot :: Int,
    firstBetPlayerPosition :: Int,
    actualPlayer :: Int
} deriving (Show);


---------- MÉTODOS AUXILIARES DE MANIPULAÇÃO DA GAMESTATUS  ----------

setPot :: Int -> GameStatus -> GameStatus
setPot value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) value 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus)

    gm


setDealerPosition :: Int -> GameStatus -> GameStatus
setDealerPosition value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) value (lastBet gameStatus) (minimumBet gameStatus) 
    	 (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus)

    gm


setLastBet :: Int -> GameStatus -> GameStatus
setLastBet value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) value 
    	 (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus)

    gm


setCurrentRound :: Int -> GameStatus -> GameStatus
setCurrentRound value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) value (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus)

    gm


setMinimumBet :: Int -> GameStatus -> GameStatus
setMinimumBet value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         value (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus)

    gm


setCardsTable :: [Card] -> GameStatus -> GameStatus
setCardsTable value gameStatus = do
    let gm = GameStatus value (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus) 
    	 (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus)

    gm


setPlayersTable :: [Player] -> GameStatus -> GameStatus
setPlayersTable value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) value (dealerPosition gameStatus) (lastBet gameStatus) 
    	 (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus)

    gm


setFirstBetPlayerPosition :: Int -> GameStatus -> GameStatus
setFirstBetPlayerPosition value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         value (actualPlayer gameStatus)

    gm

setActualPlayer :: Int -> GameStatus -> GameStatus
setActualPlayer value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) value

    gm

---------- FIM DOS MÉTODOS AUXILIARES DE MANIPULAÇÃO DA GAMESTATUS ----------


---------- MÉTODOS AUXILIARES DE MANIPULAÇÃO DA PLAYER

setHand :: [Card] -> Player -> Player
setHand value player = do
	let p = Player value (chips player) (active player) (preFlopProb player) (flopToTurnProb player) (turnToRiverProb player) (riverToShowDownProb player)

	p

setChips :: Int -> Player -> Player
setChips value player = do
	let p = Player (hand player) value (active player) (preFlopProb player) (flopToTurnProb player) (turnToRiverProb player) (riverToShowDownProb player)

	p

setActive :: Bool -> Player -> Player
setActive value player = do
	let p = Player (hand player) (chips player) value (preFlopProb player) (flopToTurnProb player) (turnToRiverProb player) (riverToShowDownProb player)

	p


setPreFlopProb :: Float -> Player -> Player
setPreFlopProb value player = do
    let p = Player (hand player) (chips player) (active player) value (flopToTurnProb player) (turnToRiverProb player) (riverToShowDownProb player)

    p


setFlopToTurnProb :: Float -> Player -> Player
setFlopToTurnProb value player = do
    let p = Player (hand player) (chips player) (active player) (preFlopProb player) value (turnToRiverProb player) (riverToShowDownProb player)

    p


setTurnToRiverProb :: Float -> Player -> Player
setTurnToRiverProb value player = do
    let p = Player (hand player) (chips player) (active player) (preFlopProb player) (flopToTurnProb player) value (riverToShowDownProb player)

    p


setRiverToShowDownProb :: Float -> Player -> Player
setRiverToShowDownProb value player = do
    let p = Player (hand player) (chips player) (active player) (preFlopProb player) (flopToTurnProb player) (turnToRiverProb player) value

    p