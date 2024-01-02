{-# LANGUAGE LambdaCase #-}

import GHC.IO (unsafePerformIO)
import Data.Maybe (mapMaybe)
import Text.Read (readMaybe)
import qualified Data.Map as Map
import Data.Map (Map)
import Data.Function ((&))

newtype Position = Position Int 


main :: IO ()
main = do 
  print readFile'

readFile' :: String
readFile' = unsafePerformIO . readFile $ "TestInput.txt" :: String

parseFile :: String -> Map Position String
parseFile file = Map.empty

  where 
    codes :: [String]
    codes = lines file


    recordPositions :: String -> Map Position Char
    recordPositions = Map.fromList . withIndex (\idx c -> (Position idx, c))