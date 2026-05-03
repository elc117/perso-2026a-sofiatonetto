module Horario where

data Horario = Horario
  { horarioId         :: Int
  , dia               :: String
  , horaInicio        :: Int
  , intervalo         :: Int
  , matriculaBolsista :: String
  }