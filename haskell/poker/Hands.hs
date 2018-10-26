module Hands (verifyHand) where
import Model
import Data.List
import Data.Ord (comparing)
import Data.Maybe

verifyHand :: [Card] -> [Card] -> Int -> String
verifyHand hand table quant | verifyFour (hand ++ (take quant table)) = "IS_FOUR"
                            | verifyFullHouse (hand ++ (take quant table)) = "IS_FULL_HOUSE"
                            | verifyFlush (hand ++ (take quant table)) = "IS_FLUSH"
                            | verifyStraight (sortByValue (hand ++ (take quant table))) = "IS_STRAIGHT"
                            | verifyThree (hand ++ (take quant table)) = "IS_THREE"
                            | verifyTwoPair (hand ++ (take quant table)) = "IS_TWO_PAIR"
                            | verifyOnePair (hand ++ (take quant table)) = "IS_ONE_PAIR"
                            | otherwise = "null"


verifyOnePair :: [Card] -> Bool
verifyOnePair [] = False
verifyOnePair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = True
                     | otherwise = verifyOnePair cs


verifyThree :: [Card] -> Bool
verifyThree [] = False
verifyThree (c:cs) | length (filter ((value c)==) [value x| x <- cs]) == 2 = True
                   | otherwise = verifyThree cs


verifyFour :: [Card] -> Bool
verifyFour [] = False
verifyFour (c:cs) | length (filter ((value c)==) [value x| x <- cs]) >= 3 = True
                  | otherwise = verifyFour cs


verifyTwoPair :: [Card] -> Bool
verifyTwoPair [] = False
verifyTwoPair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = auxVerifyTwoPair cs
                     | otherwise = verifyTwoPair cs


auxVerifyTwoPair :: [Card] -> Bool
auxVerifyTwoPair [] = False
auxVerifyTwoPair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = True
                        | otherwise = auxVerifyTwoPair cs


verifyFullHouse :: [Card] -> Bool
verifyFullHouse cards| (verifyThree cards) = verifyOnePairHouse (verifyThreeHouse cards (findThree cards))
                     | otherwise = False

verifyThreeHouse :: [Card] -> String -> [String]
verifyThreeHouse cs s = (filter (s/=)[value x| x <- cs])

findThree :: [Card] -> String
findThree [] = ""
findThree (c:cs) | length (filter ((value c)==) [value x| x <- cs]) == 2 = value c
                 | otherwise = findThree cs

verifyOnePairHouse :: [String] -> Bool
verifyOnePairHouse [] = False
verifyOnePairHouse (c:cs) | length (filter  (c==) cs) == 1 = True
                          | otherwise = verifyOnePairHouse cs

verifyFlush :: [Card] -> Bool
verifyFlush cards = auxVerifyFlush cards ["E","C","P","O"]

auxVerifyFlush :: [Card] -> [String] -> Bool
auxVerifyFlush c [] = False
auxVerifyFlush c (n:ns) | length (filter  ((n)==) [naipe x| x <- c]) >= 5 = True
                        | otherwise = auxVerifyFlush c ns

                   
verifyStraight :: [Card] -> Bool
verifyStraight cards = auxVerifyStraight cards  0 


auxVerifyStraight :: [Card] -> Int -> Bool
auxVerifyStraight cards 5 = True
auxVerifyStraight (a) cont = False
auxVerifyStraight [] cont =  False
auxVerifyStraight (a:b:cs) cont | (mapCards (value b)) - (mapCards (value a)) == 1 =  auxVerifyStraight (b:cs) (cont + 1) 
                                | otherwise = auxVerifyStraight (b:cs) 0
                                                     


sortByValue :: [Card] -> [Card]
sortByValue cards = sortBy sortLT cards

sortLT :: Card -> Card -> Ordering
sortLT c1 c2 | (mapCards (value c1)) < (mapCards (value c2)) = LT 
             | (mapCards (value c1)) >= (mapCards  (value c2)) = GT 

mapCards :: String -> Int
mapCards value = 14 - (fromJust $ (elemIndex value ["A","K","Q","J","T","9","8","7","6","5","4","3","2"]))

-- [Card "O" "5", Card "P" "7", Card "P" "4", Card "O" "K", Card "P" "5"]