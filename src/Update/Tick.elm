module Update.Tick (handle) where

import List exposing (foldl)
import Time exposing (Time, inSeconds)

import Model exposing (Model)
import Model.Controller exposing (Controller, toUnitVector)
import Update.Tick.Physics as Physics

-- params are: (current time, time since last update) -> Model
handle : (Time, Time) -> Model -> Model
handle (time, deltaMs) model =
  let
    delta = inSeconds deltaMs
  in
    model
    |> Physics.update delta
    |> updateMetaData delta

updatePosition : Float -> (Int, Int) -> Float -> (Float, Float) -> (Float, Float)
updatePosition delta dir speed (x_in, y_in) =
  let (xv, yv) = toUnitVector dir
  in (x_in + xv * speed * delta , y_in + yv * speed * delta)

updateMetaData : Float -> Model -> Model
updateMetaData _ model =
  { model
  | physicsUpdates <- model.physicsUpdates + 1
  }
