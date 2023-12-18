module Day3.Part1
  ( solution
  )
  where

import Prelude

import Data.Array as Array
import Data.Foldable (sum)
import Data.Maybe (Maybe(..))
import Data.Set (Set)
import Data.Set as Set
import Data.String (Pattern(..), toUpper)
import Data.String as String
import Data.String.CodeUnits (toCharArray, singleton)
import Data.String.Unsafe (char)
import Data.Tuple (Tuple, fst, snd)
import Data.Tuple.Nested ((/\))
import Effect.Unsafe (unsafePerformEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)
import Types (File(..))

type Items = Set Char

solution :: String 
solution = show do 
  let items = parseFile readFile
  let dupes = duplicateItems items
  sum $ priorities dupes

readFile :: File
readFile = File $ unsafePerformEffect $ readTextFile ASCII "src/Day3/Input.txt"

parseFile :: File -> Array (Tuple Items Items)
parseFile (File file) = String.split (Pattern "\n") file <#> \items -> do 
  let { before, after } = parseItems items
  Set.fromFoldable before /\ Set.fromFoldable  after
  
  where 
    parseItems items = do 
      let chars = toCharArray items 
      Array.splitAt (Array.length chars / 2) chars 

duplicateItems ::  Array (Tuple Items Items) -> Array Char 
duplicateItems allItems = Array.catMaybes $ allItems <#> \items -> 
  -- Per the problem, there should only be a single duplicate item in each compartment
  Set.findMin $ Set.intersection (fst items) (snd items)

priorities :: Array Char -> Array Int 
priorities items = priority <$> items

  where 
    priority item
      | Just i <- Array.findIndex (eq item) alphabet = 1 + i
      | Just i <- Array.findIndex (eq item) alphabetUppercase = 27 + i
      | otherwise = 0


alphabet :: Array Char 
alphabet = 
  [ 'a'
  , 'b'
  , 'c'
  , 'd'
  , 'e'
  , 'f'
  , 'g'
  , 'h'
  , 'i'
  , 'j'
  , 'k'
  , 'l'
  , 'm'
  , 'n'
  , 'o'
  , 'p'
  , 'q'
  , 'r'
  , 's'
  , 't'
  , 'u'
  , 'v'
  , 'w'
  , 'x'
  , 'y'
  , 'z'
  ]

alphabetUppercase :: Array Char 
alphabetUppercase = alphabet <#> char <<< toUpper <<< singleton
