module Update.Input (handle) where

import Keyboard exposing (KeyCode)
import Set exposing (Set)

import Time exposing (Time, inSeconds)
import Model exposing (Model)
import Model.Controller exposing (Controller, ControllerBinding)

handle: (Time, Set KeyCode) -> Model -> Model
handle (time, keys) model =
  let
    cb =
      { left  = 37
      , down  = 40
      , up    = 38
      , right = 39
      }
  in
    { model
    | controller <- updateController cb keys
    }

updateController : ControllerBinding -> Set KeyCode -> Controller
updateController binding keys =
  let
    isDown key =
      if Set.member key keys
        then 1
        else 0
    x = (isDown binding.right) - (isDown binding.left)
    y = (isDown binding.up) - (isDown binding.down)
  in
    { direction = (x, y) }
