module View (view) where

import Color exposing (rgb)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Text exposing (fromString)
import Time exposing (..)

import Model exposing (Model)

view : (Int, Int) -> (Time, Model) -> Element
view (width, height) (time, model) =
  let
    snapshot = collapseModel model time
  in
    collage width height
      [ rect (toFloat width) (toFloat height)
        |> filled (rgb 174 238 238)
      , time
        |> inSeconds
        |> floor
        |> toString
        |> fromString
        |> leftAligned
        |> toForm
        |> move (0, -32)
      , image 16 16 "assets/bird-stand.png"
        |> toForm
        |> move (snapshot.x, snapshot.y)
      ]

collapseModel model time =
  { model
  | x <- model.x time
  , y <- model.y time
  }
