{-# LANGUAGE OverloadedStrings #-}
module Database where 

import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Cadastro
import Horario

conectar :: IO Connection
conectar = connect defaultConnectInfo
  { connectHost     = "localhost"
  , connectPort     = 5433
  , connectDatabase = "lifa_hs"
  , connectUser     = "postgres"
  , connectPassword = "postgres"
  }

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
    "INSERT INTO producao.horarios (id, dia, hora_inicio, intervalo, matricula_bolsista) VALUES (?, ?, ?, ?, ?)"
    (horarioId h, dia h, horaInicio h, intervalo h, matriculaBolsista h)
  >> return ()