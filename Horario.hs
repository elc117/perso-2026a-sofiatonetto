module Horario where

import Cadastro

data Horario = Horario
  { horarioId         :: Int
  , dia               :: String
  , horaInicio        :: Double
  , intervalo         :: Double
  , matriculaBolsista :: String
  }

intervaloFim :: Horario -> Double
intervaloFim h = horaInicio h + intervalo h

horasTotais :: [Horario] -> String -> Double
horasTotais horarios mat = sum(map intervalo(filter (\h -> matriculaBolsista h == mat) horarios))

escalaBolsistas :: [Horario] -> String -> Double -> [String]
escalaBolsistas horarios diaEscala inicio = map matriculaBolsista (filter horarioIgual horarios) 
    where 
    horarioIgual h = dia h == diaEscala && horaInicio = h == inicio

verificaCargaHoraria :: [Horario] -> String -> Bool
verificaCargaHoraria horarios matri = horasTotais horarios matri == 12.0

bolsistasPorPesquisa :: [Bolsista] -> [Horario] -> String -> String -> [String]
bolsistasPorPesquisa bolsistas horarios diaEscala lp = map matriculaBolsista(filter horarioCompativeis horarios)
    where 
    bolsistasPesquisa = map matricula (filter (\b -> linhaPesquisa b == lp))
    horarioCompativeis h = dia h == diaEscala && length(filter(\m -> m == matriculaBolsista h) bolsistasPesquisa) > 0 