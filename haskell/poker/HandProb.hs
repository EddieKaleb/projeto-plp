module HandProb where

import System.IO

data Prob = Prob {
    hand  :: String,
    probs :: [String]
} deriving (Show);

{-
extract :: String -> Int -> [String] -> String
extract _ _ [] = ""
extract hand numPlayers (x:xs) 
        | (split(x)!!0 == hand) = split(x)!!(numPlayers-1)                               
        | otherwise = extract hand numPlayers xs
-}

split :: String -> [String]
split [] = [""]
split (c:cs) | c == ','  = "" : rest
             | otherwise = (c : head rest) : tail rest
                where rest = split cs
               
extract_prob :: [String] -> Int -> String
extract_prob handsProb numPlayers = handsProb!!(numPlayers-2)

setProbabilities :: IO [Prob]
setProbabilities = do
    probs <- readProbs
    return $ createList probs
    where readProbs = do
              probs <- openFile "../data/hands.csv" ReadMode
              contents <- hGetContents probs
              return $ lines contents
          createList [] = []
          createList (head:tail) = [createProb $ split head] ++ createList tail
            where createProb (hand:probs) = Prob hand probs

find_prob :: String -> [Prob] -> [String]
find_prob _ [] = [""]
find_prob playerHand (head:tail) | (playerHand == (hand head)) = (probs head)
                              | otherwise = find_prob playerHand tail
main :: String -> Int -> IO()
main hand numPlayers = do
    probs <- setProbabilities
    let res = find_prob hand probs
    let prob = extract_prob res numPlayers
    putStrLn (show prob)