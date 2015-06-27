module Model (defaultModel, Model) where

import Time exposing (..)

import Update.Controller exposing (Controller, defaultController)

-- MODEL

-- all the data for the program

type alias Model =
  { x              : Time -> Float
  , y              : Time -> Float
  , controller     : Controller
  , inputEvents    : Int
  , physicsUpdates : Int
  }

defaultModel : Model
defaultModel =
  { x              = \t -> 0
  , y              = \t -> 0
  , controller     = defaultController
  , inputEvents    = 0
  , physicsUpdates = 0
  }
