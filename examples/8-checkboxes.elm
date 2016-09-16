import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
  App.beginnerProgram {
    model = model,
    update = update,
    view = view
  }

-- MODEL
type alias Model = {
  notifications : Bool,
  autoplay : Bool,
  location : Bool
}

model : Model
model = Model True True True

-- UPDATE
type Msg = ToggleNotifications | ToggleAutoplay | ToggleLocation

update : Msg -> Model -> Model
update msg model =
  case msg of
    ToggleNotifications ->
      { model | notifications = not model.notifications }

    ToggleAutoplay ->
      { model | autoplay = not model.autoplay }

    ToggleLocation ->
      { model | location = not model.location }


-- VIEW
view : Model -> Html Msg
view model =
  fieldset [] [
    checkbox ToggleNotifications "Email Notifications",
    checkbox ToggleAutoplay "Video Autoplay",
    checkbox ToggleLocation "Use Location"
  ]

checkbox : msg -> String -> Html msg
checkbox msg name =
  label [ style [("padding", "20px")] ] [
    input [ type' "checkbox", onClick msg ] [],
    text name
  ]
