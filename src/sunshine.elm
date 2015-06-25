-- TODO: restrict imports
-- TODO: create engine module
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Keyboard exposing (..)
import Signal exposing (..)
import Text
import Time exposing (..)

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
      { x              = 0
      , y              = 0
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
view (width, height) (time, model) =
  collage width height
    [ toForm (show (inSeconds time))
    , move (0, 20) (toForm (show model))
    ]

-- MODEL

-- all the data for the program

type alias Model =
  { x              : Int
  , y              : Int
  , inputEvents    : Int
  , physicsUpdates : Int
  }


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

handleInput : (Time, RawInput) -> Model -> Model
handleInput (time, input) model =
  { model
    | x           <- model.x + input.x
    , y           <- model.y + input.y
    , inputEvents <- model.inputEvents + 1
  }

-- PHYSICS UPDATE

-- updates the engine
-- the delta since the last update is currently not exposed (maybe this should change?)

physicsUpdate : Time -> Model -> Model
physicsUpdate time model =
  { model
    | physicsUpdates <- model.physicsUpdates + 1
  }

