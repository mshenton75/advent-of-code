{-# LANGUAGE LambdaCase #-}

import GHC.IO (unsafePerformIO)
import Data.Maybe (mapMaybe)
import Text.Read (readMaybe)

data Direction = Forward Int | Up Int | Down Int

main :: IO ()
main = do 
  let directions = parseFile readFile'
  print $ followDirections directions

readFile' :: String
readFile' = unsafePerformIO . readFile $ "Input.txt" :: String

parseFile :: String -> [Direction]
parseFile = mapMaybe parseLine . lines 

  where 
    parseLine :: String -> Maybe Direction
    parseLine line = do
      let words' = words line
      Text.Read.readMaybe (last words') >>= case head words' of 
        "forward" -> Just . Forward
        "down" -> Just . Down 
        "up" -> Just . Up
        _ -> const Nothing

followDirections :: [Direction] -> Int 
followDirections dirs = sum (horizontal dirs) * sum (depth dirs)

  where 
    horizontal = mapMaybe $ \case
      Forward units -> Just units
      Down _ -> Nothing
      Up _ -> Nothing

    depth = mapMaybe $ \case
      Forward _ -> Nothing
      Up units -> Just (-units)
      Down units -> Just units
