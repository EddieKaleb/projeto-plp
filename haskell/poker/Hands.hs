module Hands (verifyHand) where
import Model
import Data.List
import Data.Ord (comparing)
import Data.Maybe

verifyHand :: [Card] -> [Card] -> Int -> String
verifyHand hand table quant | verifyFour (hand ++ (take quant table)) = "IS_FOUR"
                            | verifyFullHouse (hand ++ (take quant table)) = "IS_FULL_HOUSE"
                            | verifyFlush (hand ++ (take quant table)) = "IS_FLUSH"
                            | verifyThree (hand ++ (take quant table)) = "IS_THREE"
                            | verifyTwoPair (hand ++ (take quant table)) = "IS_TWO_PAIR"
                            | verifyOnePair (hand ++ (take quant table)) = "IS_ONE_PAIR"


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
verifyFullHouse cards = verifyThree cards && verifyOnePair cards


verifyFlush :: [Card] -> Bool
verifyFlush [] = False
verifyFlush (c:cs) | length (filter  ((naipe c)==)[naipe x| x <- (c:cs)]) >= 5 = True
                   | otherwise = verifyFlush cs


sortByValue :: [Card] -> [Card]
sortByValue cards = sortBy sortLT cards

sortLT :: Card -> Card -> Ordering
sortLT c1 c2 | (mapCards (value c1)) < (mapCards (value c2)) = LT 
             | (mapCards (value c1)) >= (mapCards  (value c2)) = GT 

mapCards :: String -> Int
mapCards value = 14 - (fromJust $ (elemIndex value ["A","K","Q","J","T","9","8","7","6","5","4","3","2"]))
