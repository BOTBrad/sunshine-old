module Update.Tick (handle) where

import Time exposing (Time, inSeconds)

import Model exposing (Model)
import Update.Controller exposing (Controller, toUnitVector)

-- params are: (current time, time since last update) -> Model
handle : (Time, Time) -> Model -> Model
handle (time, deltaT) model =
  let
    delta = inSeconds deltaT
  in
    { model
    | physicsUpdates <- model.physicsUpdates + 1
    , position <- updatePosition delta model.controller.direction model.speed model.position
    }

-- params: time delta -> control stick -> speed -> old position
updatePosition : Float -> (Int, Int) -> Float -> (Float, Float) -> (Float, Float)
updatePosition delta dir speed (x_in, y_in) =
  let (xv, yv) = toUnitVector dir
  in (x_in + xv * speed * delta , y_in + yv * speed * delta)
