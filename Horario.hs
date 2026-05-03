module Horario where

import Cadastro
import Data.Scientific (Scientific)
import Data.List (nub)

data Horario = Horario
  { horarioId         :: Int
  , dia               :: String
  , horaInicio        :: Scientific
  , intervalo         :: Scientific
  , matriculaBolsista :: String
  }

intervaloFim :: Horario -> Scientific
intervaloFim h = horaInicio h + intervalo h

horasTotais :: [Horario] -> String -> Scientific
horasTotais horarios mat = sum(map intervalo(filter (\h -> matriculaBolsista h == mat) horarios))

escalaBolsistas :: [Horario] -> String -> Scientific -> [String]
escalaBolsistas horarios diaEscala inicio = map matriculaBolsista (filter horarioIgual horarios) 
    where 
    horarioIgual h = dia h == diaEscala && horaInicio h == inicio

verificaCargaHoraria :: [Horario] -> String -> Bool
verificaCargaHoraria horarios matri = horasTotais horarios matri == 12.0

bolsistasPorPesquisa :: [Bolsista] -> [Horario] -> String -> String -> [String]
bolsistasPorPesquisa bolsistas horarios diaEscala lp = map matriculaBolsista(filter horarioCompativeis horarios)
    where 
    bolsistasPesquisa = map matricula (filter (\b -> linhaPesquisa b == lp) bolsistas)
    horarioCompativeis h = dia h == diaEscala && length(filter(\m -> m == matriculaBolsista h) bolsistasPesquisa) > 0

geraEscala :: [Horario] -> [(String, Scientific, Scientific, [String])]
geraEscala horarios =
  map geraTabela todosSlots
  where
    dias      = ["segunda", "terca", "quarta", "quinta", "sexta"]
    turnos    = [8.5, 10.5, 13.5, 15.5]
    todosSlots = [(d, hi) | d <- dias, hi <- turnos]
    geraTabela (d, hi) = (d, hi, hi + 2.0, escalaBolsistas horarios d hi)