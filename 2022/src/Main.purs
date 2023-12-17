module Main where

import Prelude

import Data.Array as Array
import Data.Maybe (Maybe(..))
import Day1.Solution as Day1
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
    _, _ -> error "Unknown arguments"
