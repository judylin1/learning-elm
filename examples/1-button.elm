import Html exposing (Html, div, button, text)
import Html.App as App
import Html.Events exposing (onClick)

main =
  App.beginnerProgram {
    model = model,
    view = view,
    update = update
  }

-- MODEL
type alias Model = Int
model : Model
model = 0

-- UPDATE
type Msg = Reset | Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Reset ->
      0
    Increment ->
      model + 1
    Decrement ->
      model - 1


-- VIEW
view : Model -> Html Msg
view model =
  div [] [
    button [ onClick Decrement ] [ text "-" ],
    div [] [ text (toString model) ],
    button [ onClick Increment ] [ text "+" ],
    div [] [],
    button [ onClick Reset ] [ text "RESET" ]
  ]
