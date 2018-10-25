module Bots where 

import Data.Time.Clock.POSIX

getCurrentTimestamp :: IO Int
getCurrentTimestamp = do
    currentTime <- getPOSIXTime
    let currTimestamp = floor $ currentTime * 100000
    return currTimestamp

getImproveProb :: Float -> Float
getImproveProb outs = (outs * 4) - (outs - 8)

getImproveHandProb :: String -> Float
getImproveHandProb hand | (hand == "IS_ONE_PAIR") = (getImproveProb 5) / 100
                        | (hand == "IS_TWO_PAIR") = (getImproveProb 4) / 100
                        | (hand == "IS_THREE") = (getImproveProb 8) / 100
                        | (hand == "IS_STRAIGHT") = (getImproveProb 1) / 100
                        | (hand == "IS_FLUSH") = (getImproveProb 2) / 100
                        | (hand == "IS_FULL_HOUSE") = (getImproveProb 1) / 100
                        | (hand == "IS_HIGH_CARD") = (getImproveProb 15) / 100
                        | otherwise = (getImproveProb 0) / 100
