module Day2.Part2
  ( solution
  )
  where

import Prelude

import Data.Array as Array
import Data.Foldable (sum)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..))
import Data.String as String
import Effect.Unsafe (unsafePerformEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

newtype File = File String

data Shape = Rock | Paper | Scissors
derive instance Eq Shape

data Outcome = Loss | Draw | Win

type Round = { yourMove :: Shape, opponentMove :: Shape }


solution :: String
solution = show $ sum $ scoreRound <$> parseFile readFile

readFile :: File
readFile = File $ unsafePerformEffect $ readTextFile ASCII "src/Day2/Input.txt"

parseFile :: File -> Array Round  
parseFile (File file) = do
  let rawTurns = String.split (Pattern "\n") file <#> (String.split (Pattern " "))
  Array.catMaybes $ rawTurns <#> \turn -> do 
    opponentMove <- Array.head turn >>= parseOpponentMove
    outcome <- Array.last turn >>= parseOutcome
    pure { yourMove: determineYourMove opponentMove outcome, opponentMove } 

parseOpponentMove :: String -> Maybe Shape
parseOpponentMove = case _ of 
  "A" -> Just Rock 
  "B" -> Just Paper 
  "C" -> Just Scissors 
  _ -> Nothing

parseOutcome :: String -> Maybe Outcome
parseOutcome = case _ of 
  "X" -> Just Loss 
  "Y" -> Just Draw 
  "Z" -> Just Win 
  _ -> Nothing

scoreShape :: Shape -> Int 
scoreShape = case _ of 
  Rock -> 1
  Paper -> 2
  Scissors -> 3

determineYourMove :: Shape -> Outcome -> Shape 
determineYourMove opponentMove outcome = case opponentMove, outcome of 
  Rock, Loss -> Scissors
  Rock, Draw -> Rock
  Rock, Win -> Paper 
  Paper, Loss -> Rock 
  Paper, Draw -> Paper 
  Paper, Win -> Scissors
  Scissors, Loss -> Paper 
  Scissors, Draw -> Scissors
  Scissors, Win -> Rock

defeats :: Shape -> Shape 
defeats = case _ of 
  Rock -> Scissors 
  Scissors -> Paper 
  Paper -> Rock

scoreRound :: Round -> Int 
scoreRound { yourMove, opponentMove } = scoreShape yourMove + scoreOutcome
  
  where 
    scoreOutcome 
      | defeats yourMove == opponentMove = 6 
      | defeats opponentMove == yourMove = 0
      | otherwise = 3
  
