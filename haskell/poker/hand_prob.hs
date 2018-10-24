module HandProb where

import System.IO

data Prob = Prob {
    hand  :: String,
    probs :: [String]
} deriving (Show);

extract :: String -> Int -> [String] -> String
extract _ _ [] = ""
extract hand numPlayers (x:xs) 
        | (split(x)!!0 == hand) = split(x)!!(numPlayers-1)                               
        | otherwise = extract hand numPlayers xs
        
split :: String -> [String]
split [] = [""]
split (c:cs) | c == ','  = "" : rest
             | otherwise = (c : head rest) : tail rest
                where rest = split cs
               
--extract_prob :: String -> Int -> String
--extract_prob hand numPlayers = extract hand numPlayers getHands

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