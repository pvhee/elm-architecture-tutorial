import Html exposing (Html, br, div, button)
import Html.Events exposing (onClick)
import Html.App as Html
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { time: Time
  , state : Bool
  }


init : (Model, Cmd Msg)
init =
  (Model 0 True, Cmd.none)



-- UPDATE


type Msg
  = Tick Time
  | Toggle


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | time = newTime }, Cmd.none)
    Toggle ->
      (toggleState model, Cmd.none)

-- UTILITIES
toggleState : Model -> Model
toggleState model =
  {model | state = not(model.state)}


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  case model.state of
    True ->
      Time.every second Tick
    False ->
      Sub.none

-- VIEW


view : Model -> Html Msg
view model =
  let
    angle =
      turns (Time.inMinutes model.time)

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)
  in
    div []
      [ svg [ viewBox "0 0 100 100", width "300px" ]
        [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
        , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
        ]
      , br [] []
      , button [ onClick Toggle ] [ text "Toggle clock status" ]
      ]
