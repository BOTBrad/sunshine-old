import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Keyboard
import Text

main : Signal Element
main =
  Signal.map
    (\arrows -> collage 800 400
      [ toForm (show arrows) ])
    Keyboard.arrows

