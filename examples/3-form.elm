import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String exposing (..)
import Regex exposing (..)

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.submitted == False then ("", "")
      else if model.password /= model.passwordAgain then ("red", "Passwords don't match!")
      else if String.length model.password < 8 then ("red", "Password is too short!")
      else if Result.withDefault -1 (String.toInt model.age) == -1 then ("red", "Age must be a number!")
      else if Result.withDefault -1 (String.toInt model.age) == 0 then ("red", "Age must be greater than 0!")
      else if passwordLowercaseCheck model.password == False then ("red", "Password must contain a lowercase letter!")
      else if passwordUppercaseCheck model.password == False then ("red", "Password must contain an uppercase letter!")
      else if passwordNumberCheck model.password == False then ("red", "Password must contain a number!")
      else ("green", "All is well!")
  in
    div [ style [("color", color)] ] [ text message ]


passwordLowercaseCheck : String -> Bool
passwordLowercaseCheck password = Regex.contains (regex "[a-z]") password

passwordUppercaseCheck : String -> Bool
passwordUppercaseCheck password = Regex.contains (regex "[A-Z]") password

passwordNumberCheck : String -> Bool
passwordNumberCheck password = Regex.contains (regex "\\d") password

main =
  App.beginnerProgram {
    model = model,
    update = update,
    view = view
  }

-- MODEL
type alias Model = {
  userName: String,
  password: String,
  passwordAgain: String,
  age: String,
  submitted: Bool
}
model : Model
model = { userName = "", password = "", passwordAgain = "", age = "", submitted = False }

-- UPDATE
type Msg = UserName String | Password String | PasswordAgain String | Age String | Submit

update : Msg -> Model -> Model
update msg model =
  case msg of
    UserName userName ->
      { model | userName = userName }
    Password password ->
      { model | password = password }
    PasswordAgain password ->
      { model | passwordAgain = password }
    Age age ->
      { model | age = age }
    Submit ->
      { model | submitted = True }


-- VIEW
view : Model -> Html Msg
view model =
  div [] [
    h1 [] [ text "Enter user name" ],
    input [ placeholder "user name", onInput UserName ] [],
    div [] [],
    h1 [] [ text "Enter password" ],
    input [ placeholder "password", onInput Password ] [],
    div [] [],
    h1 [] [ text "Re-enter password" ],
    input [ placeholder "re-enter password", onInput PasswordAgain ] [],
    div [] [],
    h1 [] [ text "Enter age" ],
    input [ placeholder "age", onInput Age ] [],
    div [] [],
    button [ style [("margin-top", "40px")], onClick Submit ] [ text "Submit" ],
    div [] [],
    h1 [] [ viewValidation model ]
  ]
