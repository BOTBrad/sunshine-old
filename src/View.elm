module View (view) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Text
import Time exposing (..)

import Model exposing (Model)

view : (Int, Int) -> (Time, Model) -> Element
view (width, height) (time, model) =
  let
    snapshot = collapseModel model time
  in
    collage width height
      [ toForm (show (inSeconds time))
      , snapshot
        |> show
        |> toForm
        |> move (snapshot.x, snapshot.y)
      ]

collapseModel model time =
  { model
  | x <- model.x time
  , y <- model.y time
  }
