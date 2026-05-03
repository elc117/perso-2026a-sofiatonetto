module Main where

import Cadastro
import Test.HUnit

testMatriculaCadastrada :: Test
testMatriculaCadastrada = TestCase $ do
  let lista = [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"]
  assertEqual "Matricula ja cadastrada retorna True"  True  (matriculaCadastrada lista "202500101")
  assertEqual "Matricula nao cadastrada retorna False" False (matriculaCadastrada lista "202200302")

testCadastrar :: Test
testCadastrar = TestCase $ do
  let lista = [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"]
  assertEqual "Bolsista adicionado" 2 (length (cadastrar lista "202300202" "Bruno" "bruno@gmail.com" "Redes" "terca 14:00 16:00"))

testEditarBolsista :: Test
testEditarBolsista = TestCase $ do
  let lista   = [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"]
  let editada = editarBolsista lista "202500101" "Ana Silva" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"
  assertEqual "Nome atualizado" "Ana Silva" (nome (head editada))

testBuscarPorMatricula :: Test
testBuscarPorMatricula = TestCase $ do
  let lista = [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"]
  assertEqual "Matricula cadastrada 1" 1 (length (buscarPorMatricula lista "202500101"))
  assertEqual "Matricula nao cadastrada 0" 0 (length (buscarPorMatricula lista "202200302"))

testBuscarPorPesquisa :: Test
testBuscarPorPesquisa = TestCase $ do
  let lista = [ Bolsista "202500101" "Ana"   "ana@gmail.com"   "Machine Learning" "segunda 10:00 12:00"
              , Bolsista "202300202" "Bruno" "bruno@gmail.com" "Redes"            "terca 14:00 16:00"  ]
  assertEqual "Ja existe 1" 1 (length (buscarPorPesquisa lista "Redes"))
  assertEqual "Nao existe 0" 0 (length (buscarPorPesquisa lista "IA"))

testListarBolsistas :: Test
testListarBolsistas = TestCase $ do
  let lista = [ Bolsista "202500101" "Ana"   "ana@gmail.com"   "Machine Learning" "segunda 10:00 12:00"
              , Bolsista "202300202" "Bruno" "bruno@gmail.com" "Redes"            "terca 14:00 16:00"  ]
  assertEqual "Bosistas um por ium" 2 (length (listarBolsistas lista))

testCases :: Test
testCases = TestList
  [ testMatriculaCadastrada,
    testCadastrar,
    testEditarBolsista,
    testBuscarPorMatricula,
    testBuscarPorPesquisa,
    testListarBolsistas
  ]

main :: IO ()
main = do
  putStrLn "Running tests..."
  runTestTT testCases
  return ()