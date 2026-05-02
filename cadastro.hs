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

cadastrar :: [Bolsistas] -> String -> String -> String -> String -> String -> Maybe[Bolsistas]
cadastrar bs matricula nome email linha_pesquisa horarios_livres
    | matricula == "" = Left "Este campo deve ser preenchido"
    | nome == "" = Left "Este campo deve ser preenchido"
    | email == "" = Left "Este campo deve ser preenchido"
    | linha_pesquisa == "" = Left "Este campo deve ser preenchido"
    | horarios_livres == "" = Left "Este campo deve ser preenchido"
    | jaCadastrado bs matricula = "" = Left "Esta matrícula já foi cadastrada no sistema"
    | otherwise = Right (bs ++ [Bolsistas matricula nome email linha_pesquisa horarios_livres])

