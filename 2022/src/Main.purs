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
  case Array.head (Array.drop 2 args) of 
    Just "day-1" -> log Day1.part1 
    Just arg -> error $ "Unknown argument: " <> arg
    Nothing -> error "Please specify which day argument (i.e --node-args day-1)"
