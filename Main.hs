{-# LANGUAGE OverloadedStrings #-}

import System.Environment (lookupEnv, getArgs)
import Web.Scotty
import Text.Read (readMaybe)
import Data.Maybe
import Data.Text.Lazy

herokuPortEnvName :: String
herokuPortEnvName = "PORT"

main :: IO ()
main = do 
    herokuPort <- (>>= readMaybe) <$> lookupEnv herokuPortEnvName 
    args <- pack . mconcat <$> getArgs
    let 
        port = fromMaybe 8080 herokuPort

    scotty port $ 
      get "/:word" $ do
        beam <- param "word"
        html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>", args]
