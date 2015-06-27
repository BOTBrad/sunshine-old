module Update.Controller (Controller, ControllerBinding, defaultController) where

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
