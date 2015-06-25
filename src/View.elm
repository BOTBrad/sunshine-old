module View (view) where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Text
import Time exposing (..)

import Model exposing (Model)

view : (Int, Int) -> (Time, Model) -> Element
view (width, height) (time, model) =
  collage width height
    [ toForm (show (inSeconds time))
    , { model
        | x <- model.x time
        , y <- model.y time
        }
      |> show
      |> toForm
      |> move (0, 20)
    ]
