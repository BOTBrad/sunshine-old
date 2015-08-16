module Update.Tick.Physics (update) where

import Model exposing (Model)
import Model.Controller exposing (toUnitVector)

update : Float -> Model -> Model
update delta model =
  model
  |> updatePosition delta


updatePosition : Float -> Model -> Model
updatePosition delta model =
  let
    (oldX, oldY) = model.position
    (cx, cy) = toUnitVector model.controller.direction
    newPosition = (oldX + cx * model.speed * delta, oldY + cy * model.speed * delta)
  in
    { model
    | position <- newPosition
    }
