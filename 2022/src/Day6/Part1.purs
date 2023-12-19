module Day6.Part1
  ( solution
  )
  where

import Prelude

import Data.Array as Array
import Data.Set as Set
import Data.String.CodeUnits (toCharArray)
import Effect.Unsafe (unsafePerformEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)
import Types (File(..))


solution :: String 
solution = show do 
  let datastream = parseFile readFile
  numCharsBeforeKey datastream

readFile :: File
readFile = File $ unsafePerformEffect $ readTextFile ASCII "src/Day6/Input.txt"

parseFile :: File -> Array Char 
parseFile (File file) = toCharArray file

numCharsBeforeKey :: Array Char -> Int 
numCharsBeforeKey chars = processKeys 0

  where 
    processKeys idx
      | 4 <- Set.size $ Set.fromFoldable $ Array.slice (idx - 4) idx chars = idx 
      | otherwise = processKeys (idx + 1)

