import Data.Time.Clock.POSIX
import Control.Monad

getCurrentTimestamp :: IO Int
getCurrentTimestamp = do
    currentTime <- getPOSIXTime
    let currTimestamp = mod (floor currentTime) 6
    return currTimestamp

main :: IO()
main = do
	time <- getCurrentTimestamp
	putStrLn(show(time))