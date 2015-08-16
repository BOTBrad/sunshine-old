module Model.Controller (Controller, ControllerBinding, defaultController, toUnitVector) where

import Keyboard exposing (KeyCode)

type alias ControllerBinding =
  { left  : KeyCode
  , down  : KeyCode
  , up    : KeyCode
  , right : KeyCode
  }

type alias Controller =
  { direction : (Int, Int) }

defaultController : Controller
defaultController =
  { direction = (0, 0) }

toUnitVector : (Int, Int) -> (Float, Float)
toUnitVector (x_in, y_in) =
  let
    x    = toFloat x_in
    y    = toFloat y_in
    dist = sqrt (x*x + y*y)
  in
    if dist > 0 then (x/dist, y/dist) else (x, y)
