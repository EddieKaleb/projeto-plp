module Model (
	Card(..),
	Player(..),
	Deck(..),
    GameStatus(..),
    Prob(..),
	setPot,
	setDealerPosition,
	setLastBet,
	setCurrentRound,
	setMinimumBet,
	setCardsTable,
    setPlayersTable,
    setFirstBetPlayerPosition,
	setActualPlayer,
    setChips,
    setActive,
    smallPosition,
    bigPosition,
    nextPlayerPosition,
    setHandsPlayers,
    setActivePlayers,
    setExit,
    setPreFlopProb,
    setFlopToTurnProb,
    setTurnToRiverProb,
    setRiverToShowDownProb
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
    actualPlayer :: Int,
    deck :: Deck,
    exit :: Bool
} deriving (Show);

data Prob = Prob {
    mHand :: String,
    probs :: [String]
} deriving (Show);

---------- MÉTODOS AUXILIARES DE MANIPULAÇÃO DA GAMESTATUS  ----------

setPot :: Int -> GameStatus -> GameStatus
setPot value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) value 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setDealerPosition :: Int -> GameStatus -> GameStatus
setDealerPosition value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) value (lastBet gameStatus) (minimumBet gameStatus) 
    	 (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setLastBet :: Int -> GameStatus -> GameStatus
setLastBet value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) value 
    	 (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setCurrentRound :: Int -> GameStatus -> GameStatus
setCurrentRound value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) value (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setMinimumBet :: Int -> GameStatus -> GameStatus
setMinimumBet value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         value (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setCardsTable :: [Card] -> GameStatus -> GameStatus
setCardsTable value gameStatus = do
    let gm = GameStatus value (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus) 
    	 (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setPlayersTable :: [Player] -> GameStatus -> GameStatus
setPlayersTable value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) value (dealerPosition gameStatus) (lastBet gameStatus) 
    	 (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
    	 (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setFirstBetPlayerPosition :: Int -> GameStatus -> GameStatus
setFirstBetPlayerPosition value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         value (actualPlayer gameStatus) (deck gameStatus) False

    gm

setActualPlayer :: Int -> GameStatus -> GameStatus
setActualPlayer value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) value (deck gameStatus) False

    gm


setActivePlayers :: Int -> GameStatus -> GameStatus
setActivePlayers value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) value (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) False

    gm


setExit :: Bool -> GameStatus -> GameStatus
setExit value gameStatus = do
    let gm = GameStatus (cardsTable gameStatus) (playersTable gameStatus) (dealerPosition gameStatus) (lastBet gameStatus)
         (minimumBet gameStatus) (activePlayers gameStatus) (currentRound gameStatus) (userPosition gameStatus) (pot gameStatus) 
         (firstBetPlayerPosition gameStatus) (actualPlayer gameStatus) (deck gameStatus) value

    gm


{-
    Retorna a posição do small.
    @param gameStatus Estado atual do jogo.
-}
smallPosition :: GameStatus -> Int
smallPosition gameStatus = nextPlayerPosition(dealerPosition gameStatus)


{-
    Retorna a posição do big.
    @param gameStatus Estado atual do jogo.
-}
bigPosition :: GameStatus -> Int
bigPosition gameStatus = nextPlayerPosition(smallPosition gameStatus)


{-
    Retorna a posição do próximo jogador com base na posição do jogador atual.
    @param pos Posição do jogador.
-}
nextPlayerPosition :: Int -> Int
nextPlayerPosition pos = (mod (pos + 1) 6)

---------- FIM DOS MÉTODOS AUXILIARES DE MANIPULAÇÃO DA GAMESTATUS ----------


---------- MÉTODOS AUXILIARES DE MANIPULAÇÃO DA PLAYER

setHandsPlayers :: [Card] -> GameStatus -> GameStatus
setHandsPlayers cards gameStatus = do
    let newGameStatus = setPlayersTable (setInitialHandPlayer cards (playersTable gameStatus) 0) gameStatus
    newGameStatus

setInitialHandPlayer :: [Card] -> [Player] -> Int -> [Player]
setInitialHandPlayer cards (p:ps) cardPosition = do
    let cardA = cards !! cardPosition
    let cardB = cards !! (cardPosition + 1)

    if(cardPosition == 10)
        then [(Player [cardA, cardB] (chips p) (active p) (preFlopProb p) (flopToTurnProb p) (turnToRiverProb p) 
         (riverToShowDownProb p))]
    else (Player [cardA, cardB] (chips p) (active p) (preFlopProb p) (flopToTurnProb p) (turnToRiverProb p) 
             (riverToShowDownProb p)) : setInitialHandPlayer cards ps (cardPosition + 2)

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