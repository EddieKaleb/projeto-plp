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
            
cardLateral :: IO()
cardLateral = do
    putStr("│")
    spaces 3
    putStr("│")

nCardLaterals :: Int -> IO()
nCardLaterals n | n == 1 = cardLateral
                | otherwise = do
                    cardLateral
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

centralCardsWithProb :: Float -> IO()
centralCardsWithProb prob = do
    putStr("│")

    centralCardSpaces
    nCardTops 2
    centralCardSpaces

    putStr("│\n")
    
    -- Inserir Logica para mostrar carta do jogador 1
    
    putStr("│")
    centralCardSpaces
    nCardLaterals 2
    centralCardSpaces
    putStr("│\n")

    putStr("├")
    printNTimes "─" 12
    putStr("┐")
    
    spaces 27
    nCardLaterals 2
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
        cardLateral
        spaces 2
        cardLateral 
        spaces 31
        putStr("│\n")
    
        putStr("│")
        spaces 30
        nCardLaterals 3
        spaces 2
        cardLateral
        spaces 2
        cardLateral 
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

centralPlayer :: Int -> Int -> Int -> IO()
centralPlayer player chips playing = do
    putStr("│")
    spaces 39
    spaces 1
    putStr("Player " ++ show(player))
    spaces 42
    putStr("│\n")

    putStr("│")
    spaces 40
    putStr("Chips: " ++ show(chips))
    spaces (43 - truncate (numDigits (fromIntegral chips)))
    putStr("│\n")

lateralPlayers :: Int -> Int -> Int -> Int -> Int -> IO()
lateralPlayers player1 chips1 player2 chips2 playing = do
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
    putStr("Chips: " ++ show(chips1))
    spaces (70 - truncate(numDigits (fromIntegral chips1)) - truncate(numDigits (fromIntegral chips2)))
    putStr("Chips: " ++ show(chips2))
    lateralSpaces
    putStr("│\n")

printTable :: IO()
printTable = do
    topBorder
    centralCards
    centralPlayer 4 500 4
    lateralCards
    lateralPlayers 3 0 5 30 3
    flopTurnRiver
    lateralCards
    lateralPlayers 2 800 6 0 2
    centralPlayer 1 6000 1
    centralCardsWithProb 10
    bottomBorder
   
    

main :: IO()
main = do
    printTable