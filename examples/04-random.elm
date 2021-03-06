import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFace1 : Int
  , dieFace2 : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFace (Int, Int)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))

    NewFace (newFace1, newFace2) ->
      (Model newFace1 newFace2, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ img [ src ("https://dummyimage.com/100x100/000/fff&text=" ++ toString model.dieFace1) ] []
    , img [ src ("https://dummyimage.com/100x100/000/fff&text=" ++ toString model.dieFace2) ] []
    , button [ onClick Roll ] [ text "Roll" ]
    ]
