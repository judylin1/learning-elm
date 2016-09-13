import Html exposing (Html, Attribute, div, input, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String

main =
  App.beginnerProgram {
    model = model,
    update = update,
    view = view
  }

-- MODEL
type alias Model = {
  reverseText: String,
  name: String
}
model : Model
model = { reverseText = "", name = "" }

-- UPDATE
type Msg = Change String | Name String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change reversedText ->
      { model | reverseText = reversedText }
    Name userName ->
      { model | name = userName }


-- VIEW
view : Model -> Html Msg
view model =
  div [] [
    input [ placeholder "Text to reverse", onInput Change ] [],
    div [] [ text ("Reversed Text: " ++ String.reverse model.reverseText) ],
    div [ style [ ("margin-top", "40px") ] ] [],
    input [ placeholder "What is your name", onInput Name ] [],
    div [] [ text ("My name is: " ++ model.name) ]
  ]
