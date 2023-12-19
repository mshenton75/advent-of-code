module Types
  ( File(..)
  )
  where

import Prelude


newtype File = File String
instance Show File where show (File file) = file