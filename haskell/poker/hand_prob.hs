import System.IO 

read_file :: IO() 
read_file = do
    hands_file <- openFile "../data/hands.csv" ReadMode
    probs <- hGetContents hands_file
    -- extract prob -- 
    hClose hands_file
