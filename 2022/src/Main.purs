module Main where

import Prelude

import Data.Array as Array
import Data.Maybe (Maybe(..))
import Day1.Solution as Day1
import Day2.Part1 as Day2Part1
import Day2.Part2 as Day2Part2
import Day3.Part1 as Day3Part1
import Day4.Part1 as Day4Part1
import Day4.Part2 as Day4Part2
import Day5.Part1 as Day5Part1
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
    Just "day-3", Just "part-1" -> log Day3Part1.solution
    Just "day-4", Just "part-1" -> log Day4Part1.solution
    Just "day-4", Just "part-2" -> log Day4Part2.solution
    Just "day-5", Just "part-1" -> log Day5Part1.solution
    _, _ -> error "Unknown arguments"
