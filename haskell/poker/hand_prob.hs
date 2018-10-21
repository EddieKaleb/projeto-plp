module HandProb (extract_prob) where

import AllHands
import System.IO 

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

extract_prob :: String -> Int -> String
extract_prob hand numPlayers = extract hand numPlayers getHands

read_file :: IO() 
read_file = do
    hands_file <- openFile "../data/hands.csv" ReadMode
    probs <- hGetContents hands_file
    -- extrair prob -- 
    hClose hands_file