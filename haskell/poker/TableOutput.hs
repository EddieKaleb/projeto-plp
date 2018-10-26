module TableOutput(
    printTable
)where
    
import Model
import Text.Printf

printNTimes :: String -> Int -> IO()
printNTimes string num | num == 1 = putStr(string)
                 | num == 0 = putStr("")
                 | num < 0 = putStr("")
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
          | n == 0 = putStr("")
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
    cardLateral (value (h!!0))
    cardLateral (value (h!!1))
    centralCardSpaces
    putStr("│\n")

    putStr("├")
    printNTimes "─" 12
    putStr("┐")
    
    spaces 27
    cardLateral (naipe (h!!0))
    cardLateral (naipe (h!!1))
    centralCardSpaces
    putStr("│\n")

    putStr("│")
    putStr(" WIN: ")
    printf "%.1f" (prob :: Float) -- ++ show(100.0) ++ "%")
    putStr("%")
    spaces (3 - truncate(numDigits prob))
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
    
flopTurnRiver :: [Card] -> IO()
flopTurnRiver cards = do
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
        cardLateral (value (cards !! 0))
        cardLateral (value (cards !! 1))
        cardLateral (value (cards !! 2))
        spaces 2
        cardLateral (value (cards !! 3))
        spaces 2
        cardLateral (value (cards !! 4))
        spaces 31
        putStr("│\n")
    
        putStr("│")
        spaces 30
        cardLateral (naipe (cards !! 0))
        cardLateral (naipe (cards !! 1))
        cardLateral (naipe (cards !! 2))
        spaces 2
        cardLateral (naipe (cards !! 3))
        spaces 2
        cardLateral (naipe (cards !! 4))
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

activePlayer :: Bool -> Int -> Int -> IO()
activePlayer active playerNum actualPlayer
    | (not active) = putStr("X")
    | playerNum == actualPlayer = putStr("*")
    | otherwise = putStr(" ")

role :: Int -> [Int] -> IO()
role playerNum blinds
    | playerNum == (blinds !! 0) + 1 = putStr("(D)")
    | playerNum == (blinds !! 1) + 1 = putStr("(S)")
    | playerNum == (blinds !! 2) + 1 = putStr("(B)")
    | otherwise = putStr("   ")

centralPlayer :: Int -> Player -> Int -> [Int] -> IO()
centralPlayer player (Player {hand = h, chips = c, active = a}) playing blinds = do
    putStr("│")
    spaces 39
    activePlayer a player playing
    putStr("Player " ++ show(player))
    role player blinds
    spaces 39
    putStr("│\n")

    putStr("│")
    spaces 40
    putStr("Chips: " ++ show(c))
    spaces (43 - truncate (numDigits (fromIntegral c)))
    putStr("│\n")

lateralPlayers :: Int -> Player -> Int -> Player -> Int -> [Int] -> IO()
lateralPlayers player1 (Player {hand = h1, chips = c1, active = a1})  player2 (Player {hand = h2, chips = c2, active = a2})  playing blinds = do
    putStr("│")
    spaces 2
    activePlayer a1 player1 playing
    putStr("Player " ++ show(player1))
    role player1 blinds
    spaces 62
    role player2 blinds
    putStr("Player " ++ show(player2))
    activePlayer a2 player2 playing
    spaces 2
    putStr("│\n")

    putStr("│")
    lateralSpaces
    putStr("Chips: " ++ show(c1))
    spaces (70 - truncate(numDigits (fromIntegral c1)) - truncate(numDigits (fromIntegral c2)))
    putStr("Chips: " ++ show(c2))
    lateralSpaces
    putStr("│\n")

printPot :: Int -> IO()
printPot chips = do
    putStr("│")
    spaces 40
    putStr("Pot: " ++ show(chips))
    spaces (45 - truncate(numDigits (fromIntegral chips)))
    putStr("│\n")
    
getProb :: Player -> Int -> Float
getProb player currentRound
    | currentRound == 0 = preFlopProb player
    | currentRound == 1 = flopToTurnProb player
    | currentRound == 2 = turnToRiverProb player
    | currentRound == 3 = riverToShowDownProb player
    | otherwise = 0

printTable :: GameStatus -> IO()
printTable gameStatus = do

    let cards = cardsTable gameStatus
    let players = playersTable gameStatus
    let round = currentRound gameStatus
    let potChips = pot gameStatus
    let playing = (actualPlayer gameStatus) + 1
    let dealer = dealerPosition gameStatus
    let blinds = [dealer, smallPosition gameStatus, bigPosition gameStatus]

    topBorder
    centralCards
    centralPlayer 4 (players !! 3) playing blinds
    lateralCards
    lateralPlayers 3 (players !! 2) 5 (players !! 4) playing blinds
    flopTurnRiver cards
    printPot potChips
    lateralCards
    lateralPlayers 2 (players !! 1) 6 (players !! 5) playing blinds
    centralPlayer 1 (players !! 0) playing blinds
    centralCardsWithProb (players!!0) (getProb (players!!0) round)
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


printUserProfile :: GameStatus -> IO()
printUserProfile gs = do 
   putStr "\n\n        .------..------..------..------..------..------.\n"
   putStr "        |P.--. ||E.--. ||R.--. ||F.--. ||I.--. ||L.--. |\n"
   putStr "        | \58/\92\58 || \58/\92\58 || \58()\58 || \58()\58 || \58/\92\58 || \58/\92\58 |\n"
   putStr "        | (__) || (__) || ()() || ()() || (__) || (__) |\n"
   putStr "        | '--'P|| '--'E|| '--'R|| '--'F|| '--'I|| '--'L|\n"
   putStr "        `------'`------'`------'`------'`------'`------'\n\n\n"
   putStr "PERFIS POSSÍVEIS \n\n[-] MUITO AGRESSIVO [-] AGRESSIVO [+] MUITO MODERADO [+] MODERADO\n\n\n"

   let average_prob = ((preFlopProb ((playersTable gs)!!0)) + (flopToTurnProb ((playersTable gs)!!0)) + (turnToRiverProb ((playersTable gs)!!0)) + (riverToShowDownProb ((playersTable gs)!!0))) / 4 
   let average_pot = (pot gs) `div` 4
   putStr ""
   
   {-}   float average_prob = 
        (playersTable[0].preFlopProb + playersTable[0].flopToTurnProb + 
        playersTable[0].turnToRiverProb + playersTable[0].riverToShowDownProb) / 4;
    float average_pot = POT / 4;
    // MÃO NÃO MELHOROU AO LONGO DOS TURNOS
    if (average_prob < playersTable[0].flopToTurnProb) {

        // USUARIO COM POUCAS FICHAS 
        if (playersTable[0].chips < average_pot) {
            profile += "Seu perfil é MUITO AGRESSIVO, no geral sua probabilidade\n";
            profile += "de vitória não melhorou em relação a sua probabilidade no \nFLOP ";
            profile += "e suas fichas estão abaixo da média do pote.";
        } else {
            profile += "Seu perfil é AGRESSIVO, no geral sua probabilidade\n";
            profile += "de vitória não melhorou em relação a sua probabilidade \n no FLOP,\n";
            profile += "mas suas fichas estão acima da média do pote.";
        }
    // MÃO MELHOROU AO LONGO DOS TURNOS    
    } else {
        // USUARIO COM POUCAS FICHAS 
        if (playersTable[0].chips < average_pot) {
            profile += "Seu perfil é MUITO MODERADO, no geral sua probabilidade\n"; 
            profile += "de vitória melhorou em relação a sua probabilidade no FLOP,\n";
            profile += "mas suas fichas estão abaixo da média do pote"; 
        } else {
            profile += "Seu perfil é MODERADO, no geral sua probabilidade\n"; 
            profile += "de vitória melhorou em relação a sua probabilidade no FLOP\n";  
            profile += "e suas fichas estão acima da média do pote";
        }
    }-}

main :: IO()
main = do
    let card1 = Card "O" "T"
    let card2 = Card "P" "K"
    let card3 = Card " " " "
    let player1 = Player [card1, card2] 500 True 100 90 80 70 
    let player2 = Player [card1, card2] 1800 False 100 100 100 100
    let player3 = Player [card1, card2] 0 True 100 100 100 100
    let player4 = Player [card1, card2] 23 True 100 100 100 100
    let player5 = Player [card1, card2] 65 False 100 100 100 100
    let player6 = Player [card1, card2] 1000 True 100 100 100 100
    let deck = Deck [card1, card2, card3]
    
    let gameStatus = GameStatus [card1, card2, card1, card3, card3] [player1, player2, player3, player4, player5, player6] 5 2 2 6 1 0 500 0 3 deck False
    printTable gameStatus

    
    

    