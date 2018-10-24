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
               
extract_prob :: Prob -> Int -> String
extract_prob handProbs numPlayers = extract (hand handProbs) numPlayers (probs handProbs) 

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
find_prob _ [] = []
find_prob playerHand (x:xs) | (playerHand == (hand x)) = (probs x)
                              | otherwise = find_prob playerHand xs

main :: IO()
main = do
    let hand = "22"
    all_probs <- setProbabilities
    putStrLn all_probs
    --let prob = find_prob hand all_probs 
    --show (extract_prob prob 2)
    --putStrLn ""