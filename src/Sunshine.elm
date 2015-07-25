-- TODO: restrict imports
-- TODO: create engine module
import Graphics.Element exposing (..)
import Keyboard exposing (..)
import Set exposing (Set)
import Signal exposing (..)
import Time exposing (..)

import Model exposing (Model, defaultModel)
import Update.Input as Input
import Update.Tick as Tick
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
    model              = defaultModel
  in
    view windowDimensions
    <~ (sampleOn
         (fps graphicsFps)
         (foldp
           update
           model
           (merge
             (RawInputEvent  <~ (timestamp keysDown))
             (PhysicsTick    <~ (timestamp (fps physicsFps))))))

-- VIEW

-- takes the dimensions of the collage, the a timestamped copy of the model to generate the view

view : (Int, Int) -> Model -> Element
view = View.view

-- EVENT

-- the types of top level events
-- presently there is only raw input events and physics ticks
-- PhysicsTicks are a tuple of (timestamp, time delta)

-- TODO: rename PhysicsFoo to EngineFoo or something else suitably generic

type Event
  = RawInputEvent (Time, Set KeyCode)
  | PhysicsTick   (Time, Time)

-- UPDATE

-- switches over the main event types and routes them to the proper functions

update : Event -> Model -> Model
update event model =
  case event of
    RawInputEvent evt ->
      Input.handle evt model
    PhysicsTick evt ->
      Tick.handle evt model
