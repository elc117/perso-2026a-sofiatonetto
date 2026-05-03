{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Control.Monad.IO.Class (liftIO)
import Data.Aeson (object, (.=))
import Database
import Cadastro
import Horario

main :: IO ()
main = do
  conn <- conectar
  scotty 3000 $ do
    middleware logStdoutDev

    get "/bolsistas" $ do
      bolsistas <- liftIO $ buscarTodosBolsistas conn
      json (map (\b -> object
        [ "matricula"      .= matricula b
        , "nome"           .= nome b
        , "email"          .= email b
        , "linhaPesquisa"  .= linhaPesquisa b
        , "horariosLivres" .= horariosLivres b
        ]) bolsistas)

    post "/bolsistas" $ do
      mat <- param "matricula"
      nom <- param "nome"
      ema <- param "email"
      lp  <- param "linhaPesquisa"
      hl  <- param "horariosLivres"
      liftIO $ inserirBolsista conn (Bolsista mat nom ema lp hl)
      json (object ["mensagem" .= ("Bolsista cadastrado" :: String)])

    get "/escala" $ do
      horarios <- liftIO $ buscarTodosHorarios conn
      let escala = geraEscala horarios
      json (map (\(d, hi, hf, bs) -> object
        [ "dia"        .= d
        , "horaInicio" .= hi
        , "horaFim"    .= hf
        , "bolsistas"  .= bs
        ]) escala)