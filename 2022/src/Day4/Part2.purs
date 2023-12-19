module Day4.Part2
  ( solution
  )
  where

import Prelude

import Data.Array as Array
import Data.Int as Int
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..))
import Data.String as String
import Data.Tuple (Tuple)
import Data.Tuple.Nested ((/\))
import Effect.Unsafe (unsafePerformEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)
import Types (File(..))

type Range = { low :: Int, high :: Int }

solution :: String 
solution = show do 
  let ranges = parseFile readFile
  countRedundantRanges ranges
readFile :: File
readFile = File $ unsafePerformEffect $ readTextFile ASCII "src/Day4/Input.txt"

parseFile :: File -> Array (Tuple Range Range)
parseFile (File file) = (String.split (Pattern "\n") file) # Array.mapMaybe parseSections

  where 
    parseSections raw = do 
      let ranges = String.split (Pattern ",") raw
      first <- parseRange =<< Array.head ranges
      last <- parseRange =<< Array.last ranges 
      pure $ first /\ last
    
    parseRange raw = do 
      let assignments = String.split (Pattern "-") raw
      low <- Array.head assignments >>= Int.fromString
      high <- Array.last assignments >>= Int.fromString
      pure $ { low, high }

countRedundantRanges :: Array (Tuple Range Range) ->  Int
countRedundantRanges = Array.length <<< Array.mapMaybe maybeReduntantRange 

  where 
    maybeReduntantRange range@(first /\ last) 
      | [] <- Array.intersect (Array.range first.low first.high) (Array.range last.low last.high) = Nothing 
      | otherwise = Just range
  