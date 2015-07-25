module Update.Input (handle) where

import Keyboard exposing (KeyCode)
import Set exposing (Set)

import Time exposing (Time, inSeconds)
import Update.Controller exposing (Controller, ControllerBinding)
import Model exposing (Model)

handle: (Time, Set KeyCode) -> Model -> Model
handle (time, keys) model =
  { model
  | controller <- updateController keys
  }

updateController : Set KeyCode -> Controller
updateController keys =
  let
    cb =
      { left  = 37
      , down  = 40
      , up    = 38
      , right = 39
      }
  in
    toController cb keys

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
