
import Model

verifyHand :: [Card] -> [Card] -> Int -> String
verifyHand hand table quant = verifyFlush (hand ++ (take quant table)) 


verifyPair :: [Card] -> String
verifyPair [] = "null"
verifyPair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = "IS_ONE_PAIR"
                  | otherwise = verifyPair cs


verifyThree :: [Card] -> String
verifyThree [] = "null"
verifyThree (c:cs) | length (filter ((value c)==) [value x| x <- cs]) == 2 = "IS_THREE"
               | otherwise = verifyThree cs


verifyFour :: [Card] -> String
verifyFour [] = "null"
verifyFour (c:cs) | length (filter ((value c)==) [value x| x <- cs]) == 3 = "IS_FOUR"
                  | otherwise = verifyFour cs


verifyTwoPair :: [Card] -> String
verifyTwoPair [] = "null"
verifyTwoPair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = auxVerifyTwoPair cs
                     | otherwise = verifyTwoPair cs


auxVerifyTwoPair :: [Card] -> String
auxVerifyTwoPair [] = "null"
auxVerifyTwoPair (c:cs) | length (filter  ((value c)==)[value x| x <- cs]) == 1 = "IS_TWO_PAIR"
                        | otherwise = auxVerifyTwoPair cs


-- verifyFullHouse :: [Card] -> [String]
-- verifyFullHouse [] = []
-- verifyFullHouse (c:cs) | length (filter ((value c)==) [value x| x <- cs]) == 1 = [value x| x <- cs]
--                        | otherwise = verifyFullHouse cs


-- auxVerifyFullHouse :: [String] -> String
-- auxVerifyFullHouse [] = "null"
-- auxVerifyFullHouse (c:cs) | length (filter  (c==)cs) == 2 = "IS_FULL_HOUSE"
--                         | otherwise = auxVerifyFullHouse cs

verifyFlush :: [Card] -> String
verifyFlush [] = "null"
verifyFlush (c:cs) | length (filter  ((naipe c)==)[naipe x| x <- (c:cs)]) >= 5 = "IS_FLUSH"
                   | otherwise = verifyFlush cs