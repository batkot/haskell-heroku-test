{-# LANGUAGE OverloadedStrings #-}

import System.Environment (lookupEnv)
import Web.Scotty
import Text.Read (readMaybe)
import Data.Maybe
import Data.Text.Lazy (pack)

herokuPortEnvName :: String
herokuPortEnvName = "PORT"

herokuDatabaseConnEnvName :: String
herokuDatabaseConnEnvName = "DATABASE_URL"

main :: IO ()
main = do 
    herokuPort <- (>>= readMaybe) <$> lookupEnv herokuPortEnvName 
    dbConn <- lookupEnv herokuDatabaseConnEnvName 
    let 
        port = fromMaybe 8080 herokuPort
        dbConAvailable = take 3 $ fromMaybe "NOPE" dbConn

    scotty port $ 
      get "/:word" $ do
        beam <- param "word"
        html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>", "Got DB con:", pack dbConAvailable ]
