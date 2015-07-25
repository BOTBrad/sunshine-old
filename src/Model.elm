module Model (defaultModel, Model) where

import Time exposing (..)

import Update.Controller exposing (Controller, defaultController)

-- MODEL

-- all the data for the program

type alias Model =
  { position       : (Float, Float)
  , speed          : Float
  , controller     : Controller
  , inputEvents    : Int
  , physicsUpdates : Int
  }

defaultModel : Model
defaultModel =
  { position       = (0, 0)
  , speed          = 100
  , controller     = defaultController
  , inputEvents    = 0
  , physicsUpdates = 0
  }
