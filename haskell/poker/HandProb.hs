module HandProb where

import System.IO

data Prob = Prob {
    hand  :: String,
    probs :: [String]
} deriving (Show);

split :: String -> [String]
split [] = [""]
split (c:cs) | c == ','  = "" : rest
             | otherwise = (c : head rest) : tail rest
                where rest = split cs

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

extract_prob :: [String] -> Int -> String
extract_prob handsProb numPlayers = handsProb!!(numPlayers-2)

find_prob :: String -> [Prob] -> [String]
find_prob _ [] = [""]
find_prob playerHand (head:tail) | (playerHand == (hand head)) = (probs head)
                                 | otherwise = find_prob playerHand tail
                              
get_prob :: String -> Int -> IO Float
get_prob hand numPlayers = do
    probs <- setProbabilities
    let handProb = find_prob hand probs
    let actualProb = extract_prob handProb numPlayers
    return (read actualProb)