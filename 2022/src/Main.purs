module Main where

import Prelude

import Data.Array as Array
import Data.Maybe (Maybe(..))
import Day1.Solution as Day1
import Day2.Part1 as Day2Part1
import Day2.Part2 as Day2Part2
import Effect (Effect)
import Effect.Class.Console (error)
import Effect.Console (log)
import Node.Process (argv)

main :: Effect Unit
main = do
  args <- argv 
  let userArgs = (Array.drop 2 args)
  case Array.head userArgs, Array.last userArgs of 
    Just "day-1", Just "part-1" -> log Day1.part1 
    Just "day-1", Just "part-2" -> log Day1.part2
    Just "day-2", Just "part-1" -> log Day2Part1.solution
    Just "day-2", Just "part-2" -> log Day2Part2.solution
    _, _ -> error "Unknown arguments"
