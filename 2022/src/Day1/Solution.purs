module Day1.Solution
  ( part1
  , part2
  )
  where

import Prelude

import Data.Array as Array
import Data.Foldable (maximum, sum)
import Data.Int as Int
import Data.Maybe (maybe)
import Data.String (Pattern(..))
import Data.String as String
import Effect.Unsafe (unsafePerformEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

part1 :: String
part1 = solve readFile # maybe "No result" show 

  where 
    solve = maximum <<< sumCalories <<< groupCalories [] <<< parse

part2 :: String 
part2 = solve readFile # show 

  where 
    solve = sum <<< Array.take 3 <<< Array.reverse <<< Array.sort <<< sumCalories <<< groupCalories [] <<< parse 
      

readFile :: String
readFile = unsafePerformEffect $ readTextFile ASCII "src/Day1/Input.txt"

parse :: String -> Array String 
parse = String.split (Pattern "\n") 

groupCalories :: Array (Array Int) -> Array String -> Array (Array Int)
groupCalories grouped [] = grouped
groupCalories grouped remaining = do
  let { init, rest } = Array.span (not <<< String.null) remaining
  groupCalories (Array.snoc grouped (Array.mapMaybe Int.fromString init)) (Array.drop 1 rest)

sumCalories :: Array (Array Int) -> Array Int 
sumCalories cals = sum <$> cals