module HandProb (get_prob) where

import System.IO
import Model

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
            where createProb (mHand:probs) = Prob mHand probs

extract_prob :: [String] -> Int -> String
extract_prob handsProb numPlayers = handsProb!!(numPlayers-2)

find_prob :: String -> [Prob] -> [String]
find_prob _ [] = [""]
find_prob playerHand (head:tail) | (playerHand == (mHand head)) = (probs head)
                                 | otherwise = find_prob playerHand tail
                              
get_prob :: Card -> Card -> Int -> IO Float
get_prob c1 c2 numPlayers = do
    let plyrHand = modifyHand c1 c2
    probs <- setProbabilities
    let handProb = find_prob plyrHand probs
    let actualProb = extract_prob handProb numPlayers
    return (read actualProb)

modifyHand :: Card -> Card -> String
modifyHand c1 c2 | value c1 /= value c2 && naipe c1 == naipe c2 = value c1 ++ value c2 ++ "s"
                 | value c1 /= value c2 = value c1 ++ value c2 ++ "s"
                 | otherwise = value c1 ++ value c2
