module Update.Tick (handle) where

import Time exposing (Time)

import Model exposing (Model)

handle : Time -> Model -> Model
handle time model =
  { model
  | y              <- if model.y time < 0 then \t -> 0 else model.y
  , physicsUpdates <- model.physicsUpdates + 1
  }
