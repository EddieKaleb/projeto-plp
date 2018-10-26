import System.IO
import Data.Char
import Data.List
import Data.Ord
import Data.Time.Clock.POSIX
import qualified System.Process
import Control.Monad
import Table

sleep3s :: IO()
sleep3s = do
    _ <- System.Process.system "sleep 3s"
    return ()

clearScreen :: IO()
clearScreen = do
    _ <- System.Process.system "clear"
    return ()

pause :: IO ()
pause = do
    x <- getChar
    putStrLn ""


showTitle :: IO()
showTitle = do
    clearScreen
    putStrLn "\n\n"
    putStrLn "               $$$$$$$\134   $$$$$$\134  $$\134   $$\134 $$$$$$$$\134 $$$$$$$\134"
    putStrLn "               $$  __$$\134 $$  __$$\134 $$ | $$  |$$  _____|$$  __$$\134"
    putStrLn "               $$ |  $$ |$$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |"
    putStrLn "               $$$$$$$  |$$ |  $$ |$$$$$  /  $$$$$\134    $$$$$$$  |"
    putStrLn "               $$  ____/ $$ |  $$ |$$  $$<   $$  __|   $$  __$$< "
    putStrLn "               $$ |      $$ |  $$ |$$ |\134$$\134  $$ |      $$ |  $$ |"
    putStrLn "               $$ |       $$$$$$  |$$ | \134$$\134 $$$$$$$$\134 $$ |  $$ |"
    putStrLn "               \134__|       \134______/ \134__|  \134__|\134________|\134__|  \134__|\n"
    putStrLn "                                  Carregando..."

    sleep3s

showMenu :: IO()
showMenu = do
    clearScreen

    putStrLn " "
    putStrLn "---------------------------------     MENU     ---------------------------------\n\n"
    putStrLn "           1  -  Modos de jogo"
    putStrLn "           2  -  Regras"
    putStrLn "           3  -  Sair"

    option <- getOption
    selectMenuOption option
    clearScreen
    when (not $ option == 3) $ do clearScreen; showMenu

showGameModesMenu :: IO()
showGameModesMenu = do
    clearScreen

    putStrLn "\n-----------------------------     MODOS DE JOGO     -----------------------------\n\n";

    putStrLn "          1  -  Partida Casual"
    putStrLn "          2  -  Modo Aprendizado"
    putStrLn "          3  -  Voltar"

    option <- getOption
    selectGameModeOption option

showRules :: IO()
showRules = do
    clearScreen

    putStrLn "\n----------------------------------     REGRAS     --------------------------------\n\n"
    putStrLn "------------------------------  LIMIT TEXAS HOLD'EM  -----------------------------\n"
    putStrLn "As apostas no Limit são valores estruturados e pré-determinados.\n"
    putStrLn "No pré-flop e no flop, todas as apostas e raises são do mesmo valor do big blind.\n"
    putStrLn "No turn e no river, o tamanho de todas as apostas e raises é dobrado.\n\n"
    putStrLn "-----------------------------------    MECANICA    -------------------------------\n"
    putStrLn "O botão de Dealer gira ao longo da partida de forma a alternar as posições na mesa.\n"
    putStrLn "O botão de Small Blind determina quem inicia com a menor aposta obrigatoria.\n"
    putStrLn "O botão de Big Blind determina quem inicia com a maior aposta obrigatoria.\n"
    putStrLn "O valor do Small Blind é 2 e do Big Blind é 4.\n"
    putStrLn "O jogador sempre sera o player1.\n\n"
    putStrLn "------------------------------------    AÇÕES     --------------------------------\n"
    putStrLn "                               CALL: cobrir uma aposta.\n"
    putStrLn "                               CHECK: passar a vez.\n"
    putStrLn "                               FOLD: desistir.\n\n"
    putStrLn "-----------------------------------     TURNOS     --------------------------------\n"
    putStrLn "PRE-FLOP: O Dealer é escolhido através de sorteio e cada jogador recebe 2 cartas.\n"
    putStrLn "FLOP: O Crupier coloca 3 cartas na mesa.\n"
    putStrLn "TURN: O Crupier coloca 1 carta na mesa\n"
    putStrLn "RIVER: O Crupier coloca 1 carta na mesa\n\n\n"
    putStrLn "                         [ Pressione ENTER para voltar ]\n"

    _ <- getLine
    return ()


getOption :: IO Int
getOption = do
    putStrLn "\n\n                    Digite o número da opção desejada: "
    option <- getLine
    return $ read option

selectMenuOption :: Int -> IO()
selectMenuOption 1 = showGameModesMenu
selectMenuOption 2 = showRules
selectMenuOption 3 = quit
selectMenuOption n = showInvalidOptionMessage

selectGameModeOption :: Int -> IO()
selectGameModeOption 1 = casualMatch
selectGameModeOption 2 = manualMatch
selectGameModeOption 3 = showMenu
selectGameModeOption n = showInvalidOptionMessage

casualMatch :: IO()
casualMatch = do
    clearScreen
    putStrLn("\n\n                    O JOGO VAI COMEÇAR !!!!")
    putStrLn("\n\n                 você jogará como o player 1")

    sleep3s

    startGame



manualMatch :: IO()
manualMatch = do
    putStrLn "manualMatch"

showInvalidOptionMessage :: IO()
showInvalidOptionMessage = do
    putStrLn "           Opção inválida... Pressione ENTER para tentar novamente!\n"
    
    _ <- getLine
    return ()


quit :: IO()
quit = do
    clearScreen

    putStrLn "\n\n"

    putStrLn "                                    Até mais!"
    putStrLn "\n\n\n"

    putStrLn "             Paradigmas de Linguagem de Programação - 2018.2 - UFCG"
    putStrLn "\n\n\n"

    putStrLn "                                DESENVOLVIDO POR:"
    putStrLn "\n\n"

    putStrLn "                              Arthur de Lima Ferrão"
    putStrLn "                           Eddie Kaleb Lopes Fernandes"
    putStrLn "                             Gabriel de Sousa Barros"
    putStrLn "                        Marcus Vinícius de Farias Barbosa"
    putStrLn "                              Rayla Medeiros Araújo"
    sleep3s


main :: IO()
main = do
    showTitle
    showMenu