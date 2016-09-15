import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "//api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string

showNewTopicName : Model -> Html msg
showNewTopicName model =
  let
    (newTopic) =
      if model.submitted == False then ("")
      else ("Searching for: " ++ model.topic)
  in
    div [] [ text newTopic ]

main =
  App.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }

-- MODEL
type alias Model = {
  topic : String,
  gifUrl : String,
  submitted : Bool
}


init : (Model, Cmd Msg)
init = (Model "puppies" "waiting.gif" False, getRandomGif "puppies")


-- UPDATE
type Msg = MoarPlease | NewSearch String | FetchSucceed String | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MoarPlease ->
      ({model | submitted = True}, getRandomGif model.topic)

    NewSearch newSearch ->
      ({model | topic = newSearch, submitted = False}, getRandomGif model.topic)

    FetchSucceed newUrl ->
      (Model model.topic newUrl model.submitted, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)


-- VIEW
view : Model -> Html Msg
view model =
  div [] [
    input [ placeholder "search for something...", onInput NewSearch ] [],
    button [ onClick MoarPlease ] [ text "Search" ],
    div [ style [("margin-top", "40px")] ] [],
    h2 [] [ showNewTopicName model ],
    div [ style [("margin-top", "40px")] ] [],
    img [src model.gifUrl] []
  ]


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
