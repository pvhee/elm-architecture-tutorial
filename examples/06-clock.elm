import Html exposing (Html, div, button)
import Html.App as Html
import Svg exposing (..)
import Svg.Attributes exposing (..)
--import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time exposing (Time, millisecond, second, minute)



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
  , paused : Bool
  }


init : (Model, Cmd Msg)
init =
  (Model 0 False
  , Cmd.none
  )



-- UPDATE


type Msg
  = Tick Time
  | Pause


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | time = newTime }, Cmd.none)
    Pause ->
      (model, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
  --Time.every second Tick

-- VIEW


view : Model -> Html Msg
view model =
  let
    angle =
      turns (Time.inMinutes model)

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
      , button [ onClick Pause ] [ text "Pause clock" ]
      ]
