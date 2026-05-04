{-# LANGUAGE OverloadedStrings #-}
module Database where 

import Database.PostgreSQL.Simple
import System.Environment (getEnv)
import Data.ByteString.Char8 (pack)
import Database.PostgreSQL.Simple.FromRow
import Data.List.Split (splitOn)
import Cadastro
import Horario

conectar :: IO Connection
conectar = do
  url <- getEnv "DATABASE_URL"
  connectPostgreSQL (pack url)

instance FromRow Bolsista where
  fromRow = Bolsista <$> field <*> field <*> field <*> field <*> field

instance FromRow Horario where
  fromRow = Horario <$> field <*> field <*> field <*> field <*> field

buscarTodosBolsistas :: Connection -> IO [Bolsista]
buscarTodosBolsistas conn =
  query_ conn "SELECT matricula, nome, email, linha_pesquisa, horarios_livres FROM producao.bolsistas"

inserirBolsista :: Connection -> Bolsista -> IO ()
inserirBolsista conn b =
  execute conn
    "INSERT INTO producao.bolsistas (matricula, nome, email, linha_pesquisa, horarios_livres) VALUES (?, ?, ?, ?, ?)"
    (matricula b, nome b, email b, linhaPesquisa b, horariosLivres b)
  >> return ()

atualizarBolsista :: Connection -> Bolsista -> IO ()
atualizarBolsista conn b =
  execute conn
    "UPDATE producao.bolsistas SET nome=?, email=?, linha_pesquisa=?, horarios_livres=? WHERE matricula=?"
    (nome b, email b, linhaPesquisa b, horariosLivres b, matricula b)
  >> return ()

buscarTodosHorarios :: Connection -> IO [Horario]
buscarTodosHorarios conn =
  query_ conn "SELECT id, dia, hora_inicio, intervalo, matricula_bolsista FROM producao.horarios"

inserirHorario :: Connection -> Horario -> IO ()
inserirHorario conn h =
  execute conn
    "INSERT INTO producao.horarios (dia, hora_inicio, intervalo, matricula_bolsista) VALUES (?, ?, ?, ?)"
    (dia h, horaInicio h, intervalo h, matriculaBolsista h)
  >> return ()

inserirHorariosDoBolsista :: Connection -> String -> String -> IO ()
inserirHorariosDoBolsista conn mat horariosStr = do
  execute conn "DELETE FROM producao.horarios WHERE matricula_bolsista = ?" (Only mat)
  mapM_ (inserirUmHorario conn mat) (parseHorarios horariosStr)
  return ()

parseHorarios :: String -> [(String, Double)]
parseHorarios str = map parseUm (splitOn ", " str)
  where
    parseUm h = (words h !! 0, horaParaDouble (words h !! 1))
    horaParaDouble "08:30" = 8.5
    horaParaDouble "10:30" = 10.5
    horaParaDouble "13:30" = 13.5
    horaParaDouble "15:30" = 15.5
    horaParaDouble _       = 0.0

inserirUmHorario :: Connection -> String -> (String, Double) -> IO ()
inserirUmHorario conn mat (d, hi) =
  execute conn
    "INSERT INTO producao.horarios (dia, hora_inicio, intervalo, matricula_bolsista) VALUES (?, ?, ?, ?)"
    (d, hi, 2.0 :: Double, mat)
  >> return ()