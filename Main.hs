{-# LANGUAGE OverloadedStrings #-}

import System.Environment (lookupEnv)
import Web.Scotty
import Text.Read (readMaybe)
import Data.Maybe

herokuPortEnvName :: String
herokuPortEnvName = "PORT"

main :: IO ()
main = do 
    herokuPort <- (>>= readMaybe) <$> lookupEnv herokuPortEnvName 
    let 
        port = fromMaybe 8080 herokuPort
    scotty port $ 
      get "/:word" $ do
        beam <- param "word"
        html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
