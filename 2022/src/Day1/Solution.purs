module Day1.Solution
  ( part1
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
part1 =  maximum sumCalories # maybe "No result" show 

  where
    readFile = unsafePerformEffect $ readTextFile ASCII "src/Day1/Input.txt"

    lines = String.split (Pattern "\n") readFile 

    groupCalories grouped [] = grouped
    groupCalories grouped remaining = do
      let { init, rest } = Array.span (not <<< String.null) remaining
      groupCalories (Array.snoc grouped (Array.mapMaybe Int.fromString init)) (Array.drop 1 rest)

    sumCalories = sum <$> groupCalories [] lines