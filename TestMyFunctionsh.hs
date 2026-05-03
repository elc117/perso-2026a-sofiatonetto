module Main where

import Cadastro
import Horario
import Test.HUnit

ana :: Bolsista
ana = Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 08:30 10:30"

bruno :: Bolsista
bruno = Bolsista "202300202" "Bruno" "bruno@gmail.com" "Redes" "segunda 08:30 10:30"

h1 :: Horario
h1 = Horario 1 "segunda" 8.5 2.0 "202500101"

h2 :: Horario
h2 = Horario 2 "segunda" 8.5 2.0 "202300202"

h3 :: Horario
h3 = Horario 3 "segunda" 10.5 2.0 "202500101"

h4 :: Horario
h4 = Horario 4 "terca" 13.5 2.0 "202500101"

h5 :: Horario
h5 = Horario 5 "terca" 15.5 2.0 "202500101"

h6 :: Horario
h6 = Horario 6 "quarta" 8.5 2.0 "202500101"

horarios :: [Horario]
horarios = [h1, h2, h3, h4, h5, h6]

testIntervaloFim :: Test
testIntervaloFim = TestCase $ do
  assertEqual "08:30 + 2h = 10:30" 10.5 (intervaloFim h1)
  assertEqual "10:30 + 2h = 12:30" 12.5 (intervaloFim h3)
  assertEqual "13:30 + 2h = 15:30" 15.5 (intervaloFim h4)

testHorasTotais :: Test
testHorasTotais = TestCase $ do
  assertEqual "Ana tem 8h no total"  8.0 (horasTotais horarios "202500101")
  assertEqual "Bruno tem 2h no total" 2.0 (horasTotais horarios "202300202")

testEscalaBolsistas :: Test
testEscalaBolsistas = TestCase $ do
  assertEqual "Segunda 8:30 tem 2 bolsistas" 2 (length (escalaBolsistas horarios "segunda" 8.5))
  assertEqual "Segunda 10:30 tem 1 bolsista"  1 (length (escalaBolsistas horarios "segunda" 10.5))
  assertEqual "Terca 13:30 tem 1 bolsista"    1 (length (escalaBolsistas horarios "terca" 13.5))

testVerificaCargaHoraria :: Test
testVerificaCargaHoraria = TestCase $ do
  assertEqual "Ana nao cumpre 12h"  False (verificaCargaHoraria horarios "202500101")
  assertEqual "Bruno nao cumpre 12h" False (verificaCargaHoraria horarios "202300202")

testBolsistasPorPesquisa :: Test
testBolsistasPorPesquisa = TestCase $ do
  assertEqual "Machine Learning na segunda tem 1 bolsista" 1 (length (bolsistasPorPesquisa [ana, bruno] horarios "segunda" "Machine Learning"))
  assertEqual "Redes na segunda tem 1 bolsista"            1 (length (bolsistasPorPesquisa [ana, bruno] horarios "segunda" "Redes"))

testCases :: Test
testCases = TestList
  [ testIntervaloFim,
    testHorasTotais,
    testEscalaBolsistas,
    testVerificaCargaHoraria,
    testBolsistasPorPesquisa
  ]

main :: IO ()
main = do
  putStrLn "Running tests..."
  runTestTT testCases
  return ()