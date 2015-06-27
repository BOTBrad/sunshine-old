module Update.Input (handle) where

import Keyboard exposing (KeyCode)
import Set exposing (Set)

import Time exposing (Time, inSeconds)
import Update.Controller exposing (Controller, ControllerBinding)
import Model exposing (Model)

handle: (Time, Set KeyCode) -> Model -> Model
handle (time, keys) model =
  model
  |> updateController keys
  |> updateModel time

updateController : Set KeyCode -> Model -> Model
updateController keys model =
  let
    cb =
      { left  = 37
      , down  = 40
      , up    = 38
      , right = 39
      }
  in
    { model | controller <- toController cb keys }

toController : ControllerBinding -> Set KeyCode -> Controller
toController binding keys =
  let
    isDown key =
      if Set.member key keys
        then 1
        else 0
    x = (isDown binding.right) - (isDown binding.left)
    y = (isDown binding.up) - (isDown binding.down)
  in
    { direction = (x, y) }

updateModel : Time -> Model -> Model
updateModel time model =
  let
    (x, y)       = model.controller.direction
    xVelocity    = 10
    jumpVelocity = 10
    gravity      = 9.8
  in
    { model
    | x <- \t -> (model.x time) + toFloat x * (inSeconds (t - time) * 10) * xVelocity
    , y <- if y > 0 && model.y time <= 0
             then \t -> (model.y time) + toFloat y * (inSeconds (t - time) * 10) * jumpVelocity - (inSeconds (t - time) * gravity)^2
             else model.y
    , inputEvents <- model.inputEvents + 1
    }
