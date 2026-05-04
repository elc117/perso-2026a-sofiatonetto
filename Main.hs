{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Control.Monad.IO.Class (liftIO)
import Data.Text.Lazy (pack)
import Data.Aeson (object, (.=))
import Database
import Cadastro
import Horario

main :: IO ()
main = do
  conn <- conectar
  scotty 3000 $ do
    middleware logStdoutDev

    get "/" $ do
      conteudo <- liftIO (readFile "index.html")
      html (pack conteudo)

    get "/style.css" $ do
      setHeader "Content-Type" "text/css"
      file "style.css"

    get "/script.js" $ do
      setHeader "Content-Type" "application/javascript"
      file "script.js"

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
      mat <- formParam "matricula"
      nom <- formParam "nome"
      ema <- formParam "email"
      lp  <- formParam "linhaPesquisa"
      hl  <- formParam "horariosLivres"
      liftIO $ inserirBolsista conn (Bolsista mat nom ema lp hl)
      liftIO $ inserirHorariosDoBolsista conn mat hl
      json (object ["mensagem" .= ("Bolsista cadastrado" :: String)])

    post "/bolsistas/:matricula" $ do
      matri <- formParam "matricula"
      n <- formParam "nome"
      e <- formParam "email"
      lp  <- formParam "linhaPesquisa"
      hl  <- formParam "horariosLivres"
      liftIO $ atualizarBolsista conn (Bolsista mat nom ema lp hl)
      liftIO $ inserirHorariosDoBolsista conn mat hl
      json (object ["mensagem" .= ("Bolsista atualizado" :: String)])
      

    get "/escala" $ do
      horarios  <- liftIO $ buscarTodosHorarios conn
      bolsistas <- liftIO $ buscarTodosBolsistas conn
      let escala = geraEscala horarios
      json (map (\(d, hi, hf, mats) -> object
        [ "dia"        .= d
        , "horaInicio" .= hi
        , "horaFim"    .= hf
        , "bolsistas"  .= map (buscarNome bolsistas) mats
        ]) escala)
      where
        buscarNome bs mat =
          case filter (\b -> matricula b == mat) bs of
            (b:_) -> nome b
            []    -> mat