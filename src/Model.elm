module Model (Model) where

import Time exposing (..)

-- MODEL

-- all the data for the program

type alias Model =
  { x              : Time -> Float
  , y              : Time -> Float
  , inputEvents    : Int
  , physicsUpdates : Int
  }
