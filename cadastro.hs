module cadastro where 

data Bolsistas = Bolsistas 
{
    matricula :: String,
    nome :: String,
    email :: String
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

matriculaCadastrada :: [Bolsistas] -> String -> Bool
matriculaCadastrada Bolsistas matricula =
    lenght (filter(\b -> matricula b == matricula) Bolsistas) > 0

cadastrar :: [Bolsistas] -> String -> String -> String -> String -> String -> [Bolsistas]
cadastrar bs matricula nome email linha_pesquisa horarios_livres
    Bolsistas ++ [Bolsistas matricula nome email linha_pesquisa horarios_livres]
    where
        jaCadastrado = matriculaCadastrada Bolsistas matricula

editarBolsista :: [Bolsistas] -> String -> String -> [Bolsistas]
editarBolsista Bolsistas matricula horarios_livres_editado =
    map $ atualizaBolsista Bolsistas
    where
        atualizaBolsista b = b { horarios_livres = horarios_livres_editado}