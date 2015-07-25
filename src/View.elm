module View (view) where

import Color exposing (rgb)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Text exposing (fromString)
import Time exposing (..)

import Model exposing (Model)

view : (Int, Int) -> Model -> Element
view (width, height) model =
  collage width height
    [ rect (toFloat width) (toFloat height)
      |> filled (rgb 174 238 238)
    , image 16 16 "assets/bird-stand.png"
      |> toForm
      |> move model.position
    , model.controller
      |> show
      |> toForm
      |> move (0, -64)
    ]
