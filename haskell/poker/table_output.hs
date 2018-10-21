data Card = Card {
    naipe :: String,
    value :: String
} deriving (Show)

data Player = Player {
    hand :: [Card],
    chips :: Int,
    active :: Bool
} deriving (Show)


printNTimes :: String -> Int -> IO()
printNTimes string num | num == 1 = putStr(string)
                 | otherwise = do
                    putStr(string)
                    printNTimes string (num - 1)

numberOfDigits :: Float -> Float -> Float -> Float
numberOfDigits num digits base 
    | division >= 1 = numberOfDigits num (digits + 1) (base * 10)
    | otherwise = digits
    where division = (num / base)


numDigits :: Float -> Float
numDigits num = numberOfDigits num 1 10


topBorder :: IO()
topBorder = do
    putStr("┌")
    printNTimes "─" 90
    putStr("┐\n")

bottomBorder :: IO()
bottomBorder = do
    putStr("└")
    printNTimes "─" 12
    putStr("┴")
    printNTimes "─" 77
    putStr("┘\n")

lateralBorder :: IO()
lateralBorder = do
    putStr("│")
    printNTimes " " 90
    putStr("│\n")

nLateralBorders :: Int -> IO()
nLateralBorders n | n == 1 = lateralBorder
                  | otherwise = do 
                        lateralBorder
                        nLateralBorders (n - 1)

spaces :: Int -> IO()
spaces n  | n == 1 = putStr(" ")
          | otherwise = do 
                putStr(" ")
                spaces (n - 1)

centralSpaces :: IO()
centralSpaces = spaces 64

centralCardSpaces :: IO()
centralCardSpaces = spaces(40)

lateralSpaces :: IO()
lateralSpaces = spaces 3

cardTop :: IO()
cardTop = do
    putStr("┌")
    printNTimes "─" 3
    putStr("┐")

nCardTops :: Int -> IO()
nCardTops n | n == 1 = cardTop
            | otherwise = do
                cardTop
                nCardTops (n - 1)
 {-           
cardLateral :: IO()
cardLateral = do
    putStr("│")
    spaces 3
    putStr("│")-}

cardLateral :: String -> IO()
cardLateral info = do
    putStr("│")
    putStr(formatedInfo info)
    putStr("│")

nCardLaterals :: Int -> IO()
nCardLaterals n | n == 1 = cardLateral " "
                | otherwise = do
                    cardLateral " "
                    nCardLaterals (n - 1)

formatedInfo :: String -> String
formatedInfo string | string == "T" = "10 "
                    | otherwise = string ++ "  "

cardLateralInfo :: String -> IO()
cardLateralInfo info = do
    putStr("│")
    putStr(formatedInfo info)
    putStr("│")

cardBottom :: IO()
cardBottom = do
    putStr("└")
    printNTimes "─" 3
    putStr("┘")

nCardBottoms :: Int -> IO()
nCardBottoms n | n == 1 = cardBottom
               | otherwise = do   
                    cardBottom
                    nCardBottoms (n - 1)

centralCards :: IO()
centralCards = do
    putStr("│")

    centralCardSpaces
    nCardTops 2
    centralCardSpaces

    putStr("│\n")
    
    -- Inserir Logica para mostrar ou não a carta do jogador
    
    putStr("│")
    centralCardSpaces
    nCardLaterals 2
    centralCardSpaces
    putStr("│\n")

    putStr("│")
    centralCardSpaces
    nCardLaterals 2
    centralCardSpaces
    putStr("│\n")

    putStr("│")
    centralCardSpaces
    nCardBottoms 2
    centralCardSpaces
    putStr("│\n")

centralCardsWithProb :: Player -> Float -> IO()
centralCardsWithProb (Player {hand = h, chips = c, active = a}) prob = do
    putStr("│")

    centralCardSpaces
    nCardTops 2
    centralCardSpaces

    putStr("│\n")
      
    putStr("│")
    centralCardSpaces
    cardLateral (getValue (h!!0))
    cardLateral (getValue (h!!1))
    centralCardSpaces
    putStr("│\n")

    putStr("├")
    printNTimes "─" 12
    putStr("┐")
    
    spaces 27
    cardLateral (getNaipe (h!!0))
    cardLateral (getNaipe (h!!1))
    centralCardSpaces
    putStr("│\n")

    putStr("│")
    putStr(" WIN: " ++ show(100.0) ++ "%")
    putStr("│")
    spaces 27
    nCardBottoms 2
    centralCardSpaces
    putStr("│\n")

lateralCards :: IO()
lateralCards = do
    putStr("│")
    lateralSpaces
    nCardTops 2
    centralSpaces
    nCardTops 2
    lateralSpaces
    putStr("│\n")

    -- Inserir Logica para mostrar ou não a carta do jogador
    putStr("│")
    lateralSpaces
    nCardLaterals 2
    centralSpaces

    nCardLaterals 2
    lateralSpaces
    putStr("│\n")

    putStr("│")
    lateralSpaces
    nCardLaterals 2
    centralSpaces

    nCardLaterals 2
    lateralSpaces
    putStr("│\n")

    putStr("│")
    lateralSpaces
    nCardBottoms 2
    centralSpaces
    nCardBottoms 2
    lateralSpaces
    putStr("│\n")
    
flopTurnRiver :: IO()
flopTurnRiver = do
        putStr("│")
        spaces 30
        nCardTops 3
        spaces 2
        cardTop
        spaces 2
        cardTop
        spaces 31
        putStr("│\n")
    
        putStr("│")
        spaces 30
        nCardLaterals 3
        spaces 2
        cardLateral " "
        spaces 2
        cardLateral " " 
        spaces 31
        putStr("│\n")
    
        putStr("│")
        spaces 30
        nCardLaterals 3
        spaces 2
        cardLateral " "
        spaces 2
        cardLateral " "
        spaces 31
        putStr("│\n")
    
        putStr("│")
        spaces 30
        nCardBottoms 3
        spaces 2
        cardBottom
        spaces 2
        cardBottom
        spaces 31
        putStr("│\n")

centralPlayer :: Int -> Player -> Int -> IO()
centralPlayer player (Player {hand = h, chips = c, active = a}) playing = do
    putStr("│")
    spaces 39
    spaces 1
    putStr("Player " ++ show(player))
    spaces 42
    putStr("│\n")

    putStr("│")
    spaces 40
    putStr("Chips: " ++ show(c))
    spaces (43 - truncate (numDigits (fromIntegral c)))
    putStr("│\n")

lateralPlayers :: Int -> Player -> Int -> Player -> Int -> IO()
lateralPlayers player1 (Player {hand = h1, chips = c1, active = a1})  player2 (Player {hand = h2, chips = c2, active = a2})  playing = do
    putStr("│")
    lateralSpaces
    putStr("Player " ++ show(player1))
    spaces 65
    spaces 3
    putStr("Player " ++ show(player2))
    lateralSpaces
    putStr("│\n")

    putStr("│")
    lateralSpaces
    putStr("Chips: " ++ show(c1))
    spaces (70 - truncate(numDigits (fromIntegral c1)) - truncate(numDigits (fromIntegral c2)))
    putStr("Chips: " ++ show(c2))
    lateralSpaces
    putStr("│\n")

pot :: Int -> IO()
pot chips = do
    putStr("│")
    spaces 40
    putStr("Pot: " ++ show(chips))
    spaces (45 - truncate(numDigits (fromIntegral chips)))
    putStr("│\n")

printTable :: [Player] -> Int -> Int -> IO()
printTable players actualPlayer potChips = do
    
    topBorder
    centralCards
    centralPlayer 4 (players !! 3) actualPlayer
    lateralCards
    lateralPlayers 3 (players !! 2) 5 (players !! 4) actualPlayer
    flopTurnRiver
    pot 5000
    lateralCards
    lateralPlayers 2 (players !! 1) 6 (players !! 5) actualPlayer
    centralPlayer 1 (players !! 0) actualPlayer
    centralCardsWithProb (players!!0) 10
    bottomBorder
   

getValue :: Card -> String
getValue (Card {naipe = n, value = v}) = v

getNaipe :: Card -> String
getNaipe (Card {naipe = n, value = v}) = n

printPlayer :: Player -> IO()
printPlayer (Player {hand = h, chips = c, active = a}) = do
    printCard (h!!0)
    printCard (h!!1)
    putStrLn(show c)
    putStrLn(show a)
    

printCard :: Card -> IO()
printCard (Card {naipe = n, value = v}) = do
    putStrLn(n)
    putStrLn(v)


main :: IO()
main = do
    let card1 = Card "O" "T"
    let card2 = Card "P" "K"
    let player1 = Player [card1, card2] 500 True
    let player2 = Player [card1, card2] 500 True
    let player3 = Player [card1, card2] 500 True
    let player4 = Player [card1, card2] 500 True
    let player5 = Player [card1, card2] 500 True
    let player6 = Player [card1, card2] 500 True
    printTable [player1, player2, player3, player4, player5, player6] 1 500
    

    