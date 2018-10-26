module Hands (verifyHand) where
import Model
import Data.List (sortBy)
import Data.Ord (comparing)

verifyHand :: [Card] -> [Card] -> Int -> String
verifyHand hand table quant | verifyFour (hand ++ (take quant table)) = "IS_FOUR"
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
verifyFour (c:cs) | length (filter ((value c)==) [value x| x <- cs]) == 3 = True
                  | otherwise = verifyFour cs


verifyTwoPair :: [Card] -> Bool
verifyTwoPair [] = False
verifyTwoPair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = auxVerifyTwoPair cs
                     | otherwise = verifyTwoPair cs


auxVerifyTwoPair :: [Card] -> Bool
auxVerifyTwoPair [] = False
auxVerifyTwoPair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = True
                        | otherwise = auxVerifyTwoPair cs


-- verifyFullHouse :: [Card] -> [String]
-- verifyFullHouse [] = []
-- verifyFullHouse (c:cs) | length (filter ((value c)==) [value x| x <- cs]) == 1 = [value x| x <- cs]
--                        | otherwise = verifyFullHouse cs


-- auxVerifyFullHouse :: [String] -> String
-- auxVerifyFullHouse [] = False
-- auxVerifyFullHouse (c:cs) | length (filter  (c==)cs) == 2 = "IS_FULL_HOUSE"
--                         | otherwise = auxVerifyFullHouse cs

verifyFlush :: [Card] -> Bool
verifyFlush [] = False
verifyFlush (c:cs) | length (filter  ((naipe c)==)[naipe x| x <- (c:cs)]) >= 5 = True
                   | otherwise = verifyFlush cs

