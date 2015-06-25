-- TODO: restrict imports
-- TODO: create engine module
import Graphics.Element exposing (..)
import Keyboard exposing (..)
import Signal exposing (..)
import Time exposing (..)

import Model exposing (Model)
import View

-- MAIN

-- the main function handles calls to view and update
-- graphical frame rate, physics simluation frame rate, and input handling are independent actions

main : Signal Element
main =
  let
    graphicsFps        = 60
    physicsFps         = 120
    windowDimensions   = (800, 600)
    model =
      { x              = \t -> 0
      , y              = \t -> 0
      , inputEvents    = 0
      , physicsUpdates = 0
      }
  in
    view
      windowDimensions
      <~ timestamp 
           (sampleOn
             (fps graphicsFps)
             (foldp
               update
               model
               (merge
                 (RawInputEvent  <~ (timestamp arrows))
                 (PhysicsTick    <~ (timestamp (fps physicsFps))))))

-- VIEW

-- takes the dimensions of the collage, the a timestamped copy of the model to generate the view

view : (Int, Int) -> (Time, Model) -> Element
view = View.view

-- EVENT

-- the types of top level events
-- presently there is only raw input events and physics ticks
-- PhysicsTicks are a tuple of (timestamp, time delta)

-- TODO: rename PhysicsFoo to EngineFoo or something else suitably generic

type Event
  = RawInputEvent (Time, RawInput)
  | PhysicsTick   (Time, Time)

-- UPDATE

-- switches over the main event types and routes them to the proper functions

update : Event -> Model -> Model
update event model =
  case event of
    RawInputEvent evt ->
      handleInput evt model
    PhysicsTick (time, _) ->
      physicsUpdate time model

type alias RawInput =
  { x : Int
  , y : Int
  }

-- HANDLE INPUT

-- updates the model in response to user input

xVelocity = 10
jumpVelocity = 10
gravity = 9.8

handleInput : (Time, RawInput) -> Model -> Model
handleInput (time, input) model =
  { model
    | x           <- \t -> (model.x time) + toFloat input.x * (inSeconds (t - time) * 10) * xVelocity
    , y           <- if input.y > 0 && model.y time <= 0 then \t -> (model.y time) + toFloat input.y * (inSeconds (t - time) * 10) * jumpVelocity - (inSeconds (t - time) * gravity)^2 else model.y
    , inputEvents <- model.inputEvents + 1
  }

-- PHYSICS UPDATE

-- updates the engine
-- the delta since the last update is currently not exposed (maybe this should change?)

physicsUpdate : Time -> Model -> Model
physicsUpdate time model =
  { model
    | y              <- if model.y time < 0 then \t -> 0 else model.y
    , physicsUpdates <- model.physicsUpdates + 1
  }
