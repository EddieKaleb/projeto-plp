clearScreen :: IO()
clearScreen = do
    _ <- System.Process.system "clear"
    return ()

sleep :: Int -> IO()
sleep seg = do
    _ <- System.Process.system ("sleep " ++ seg ++ "s")
    return ()

Int QTD_PLAYERS = 6

setNextDealerPosition :: Int -> Int
setNextDealerPosition DEALER_POSITION = do
    return nextPlayerPosition DEALER_POSITION
