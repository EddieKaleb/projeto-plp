module Deck (
	shuffleDeck
) where

import Model
import System.Random

-- retorna uma lista de cartas ordenadas
deck :: [Card]
deck = do
    let cards = ["A","K","Q","J","T","9","8","7","6","5","4","3","2"]
    let naipes = ["E","C","P","O"]
    buildDeck naipes cards

buildDeck :: [String] -> [String] -> [Card]
buildDeck [] ys = []
buildDeck (x:xs) ys = create x ys ++ buildDeck xs ys

create :: String -> [String] -> [Card]
create n [] = []
create n (x:xs) = Card n x : create n xs

shuffle :: [Card] -> IO [Card]
shuffle [] = return []
shuffle xs = do randomPosition <- getStdRandom (randomR (0, length xs - 1))
                let (left, (a:right)) = splitAt randomPosition xs
                fmap (a:) (shuffle (left ++ right))

-- retorna uma lista de cartas embaralhadas
shuffleDeck :: IO [Card]
shuffleDeck = do
    shuffle deck


getHandsPlayers :: Deck -> [Card]
getHandsPlayers d = take 12 (cards d)

getTableCards :: Deck -> [Card] -> [Card]
getTableCards deck cardsTable 
                   | (value ((!!)cardsTable 0)) == " " = (take 3 (drop 12 (cards deck))) ++ [Card " " " ",  Card " " " "]
                   | (value ((!!)cardsTable 3)) == " " = (take 4 (drop 12 (cards deck))) ++ [Card " " " "]
                   | (value ((!!)cardsTable 4)) == " " = (take 5 (drop 12 (cards deck)))

