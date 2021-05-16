module Main exposing (..)

import Array
import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random


type alias Flags =
    {}
    
    
type alias Model =
   { selected : String
     , items: List String 
   }
   
   
initialModel : Model
initialModel =
    { selected = "Click the button"
    , items = [
        "Matcha"
        ,"Latte"
        ,"Cappuccino"
        ,"Espresso "
        ,"Mocha"
        ,"Salted Caramel"
        ,"Brownies"
        ,"Chocolate"
        ,"Chai"
        ,"Frappuccino"
        ,"Strawberry"
        ,"Double"
        ,"Vanilla"
        ,"Creme"
        ,"Green Tea"
        ,"Caramel"
        ,"Chocolatey"
        ,"Dark"
        ,"Peanut Butter"
        ,"Chocolate Chip"
        ,"Cheesecake"
        ,"Coconut"
        ,"Ice Cream"
        ,"Macarons"
        ,"Panna Cotta"
      ] 
    }
  
  
type Msg
    = FindRandom
    | RandomNumber1 Int
    | RandomNumber2 Int
    | RandomNumber3 Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FindRandom ->
            ( model, Random.generate RandomNumber1 (Random.int 0 (List.length model.items - 1)) )

        RandomNumber1 rn ->
            let
                selected =
                    Maybe.withDefault "" (Array.fromList model.items
                        |> Array.get rn)
            in
            ( { model | selected = selected }, Random.generate RandomNumber2 (Random.int 0 (List.length model.items - 1)) )
            
        RandomNumber2 rn ->
            let
                selected =
                    Maybe.withDefault "" (Array.fromList model.items
                        |> Array.get rn)
            in
            ( { model | selected = model.selected ++ " " ++ selected}, Random.generate RandomNumber3 (Random.int 0 (List.length model.items - 1)) )     
                   
        RandomNumber3 rn ->
            let
                selected =
                    Maybe.withDefault "" (Array.fromList model.items
                        |> Array.get rn)
            in
            ( { model | selected = model.selected ++ " " ++ selected}, Cmd.none )
            

view : Model -> Html Msg
view model =
  div [ style "display" "flex", 
        style "flex-direction" "column", 
        style "align-items" "center", 
        style "justify-content" "center", 
        style "margin-top" "10%"
      ]
    [ div [ style "margin-bottom" "10px" ] [ text model.selected ]
    , button [ onClick FindRandom ] [ text "Get new super fancy name 🍫☕️🍰" ]
    ]


init : Flags -> (Model, Cmd Msg)
init _ =
    (initialModel, Cmd.none)
    
    
main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
