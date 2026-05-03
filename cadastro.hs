module cadastro where 

data Bolsista = Bolsista
{
    matricula :: String,
    nome :: String,
    email :: String,
    linha_pesquisa :: String,
    horarios_livres :: String

}

data Horario = Horario
{   
    horarioId :: Int,
    dia :: String,
    intervalo :: Int,
    matricula_bolsista :: String
}

matriculaCadastrada :: [Bolsista] -> String -> Bool
matriculaCadastrada bolsistas matri =
  length (filter (\b -> matricula b == matri) bolsistas) > 0

cadastrar :: [Bolsista] -> String -> String -> String -> String -> String -> [Bolsista]
cadastrar bolsistas matri n e lp hl = bolsistas ++ [Bolsista matri n e lp hl]
  where
    jaCadastrado = matriculaCadastrada bolsistas matri

editarBolsista :: [Bolsista] -> String -> String -> String -> String -> String -> [Bolsista]
editarBolsista bolsistas mat nomeEditado emailEditado linhaPesquisaEditada horariosLivresEditado = map atualizaBolsista bolsistas
  where
    atualizaBolsista b = b { nome = nomeEditado, email = emailEditado, linhaPesquisa = linhaPesquisaEditada, horariosLivres = horariosLivresEditado }

listarBolsistas :: [Bolsista] -> [String]
listarBolsistas bolsistas = map (\b -> matricula b ++ " . " ++ nome b ++ " . " ++ email b ++ " . " ++ horariosLivres b ++ " . " ++ linhaPesquisa b) bolsistas

buscarPorPesquisa :: [Bolsista] -> String -> [Bolsista]
buscarPorPesquisa bolsistas lp = filter (\b -> linhaPesquisa b == lp) bolsistas

buscarPorMatricula :: [Bolsista] -> String -> [Bolsista]
buscarPorMatricula bolsistas mat = filter (\b -> matricula b == mat) bolsistas
