sleep3s :: IO()
sleep3s = do
    _ <- System.Process.system "sleep 3s"
    return ()

clearScreen :: IO()
clearScreen = do
    _ <- System.Process.system "clear"
    return ()

showTitle :: IO()
showTitle = do
    putStrLn "               $$$$$$$\134   $$$$$$\134  $$\134   $$\134 $$$$$$$$\134 $$$$$$$\134"
    putStrLn "               $$  __$$\134 $$  __$$\134 $$ | $$  |$$  _____|$$  __$$\134"
    putStrLn "               $$ |  $$ |$$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |"
    putStrLn "               $$$$$$$  |$$ |  $$ |$$$$$  /  $$$$$\134    $$$$$$$  |"
    putStrLn "               $$  ____/ $$ |  $$ |$$  $$<   $$  __|   $$  __$$< "
    putStrLn "               $$ |      $$ |  $$ |$$ |\134$$\134  $$ |      $$ |  $$ |"
    putStrLn "               $$ |       $$$$$$  |$$ | \134$$\134 $$$$$$$$\134 $$ |  $$ |"
    putStrLn "               \134__|       \134______/ \134__|  \134__|\134________|\134__|  \134__|"
    putStrLn " ";
    putStrLn "                                  Carregando..."

    sleep3s

showMenu :: IO()
showMenu = do
    clearScreen

    putStrLn " "
    putStrLn "---------------------------------     MENU     ---------------------------------"
    putStrLn "           1  -  Modos de jogo"
    putStrLn "           2  -  Regras"
    putStrLn "           3  -  Sair"