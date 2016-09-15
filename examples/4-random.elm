import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import String exposing (..)
import Random

main =
  App.program {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }

-- MODEL
type alias Model = {
  dieFace: Int,
  dieFace2: Int
}

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- UPDATE
type Msg = Roll | NewFace (Int, Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))
    NewFace (newFace, newFace2) ->
      ({ model | dieFace = newFace, dieFace2 = newFace2 }, Cmd.none)


-- VIEW
view : Model -> Html Msg
view model =
  div [] [
    h1 [] [ text (toString model.dieFace) ],
    h1 [] [ text (toString model.dieFace2) ],
    button [ onClick Roll ] [ text "Roll!" ]
  ]


-- INIT
init : (Model, Cmd Msg)
init = (Model 3 2, Cmd.none)
