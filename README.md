# Backend Web com Haskell+Scotty

## 1. Identificação

- Nome: Sofia Valentina Tonetto Duarte 
- Curso: Sistemas de Informação

---

## 2. Tema/objetivo

Sistema para cadastro e alocação de bolsistas. 
O laboratório que trabalho possui diversos bolsistas e quando é necessário ajustar os horários de trabalho de cada um deles fica complicado por ser um processo muito manual. Por isso a ideia desenvolvida é um serviço web para centralizar e automatizar a gestão de horários. Sendo permito o cadastro de bolsistas com sua grade de horário correspondente ao semestre atual para identificar os horários livres que esse bolsista possui e, assim, verificar e combinar com os horários dos outros estudantes. 

As funcionalidades pensadas são: 
* POST/bolsistas: Cadastra um novo bolsista no sistema, onde são marcados os horários que ele tem disponível;
* GET/bolsistas: Lista todos os bolsistas e suas grades de horários; 
* GET/conflitos: Processa as grades e retorna a disponibilidade dos bolsistas; 
* POST/bolsistas/:id/grade: Edita a grade de horários de um bolsista para o semestre atual; 
<br>
Essas informações são armazenadas em um banco de dados relacional. 
Toda a lógica de relação dos horários e da disponibilidade dos bolsistas será implementada com funções puras, recebendo os horários e retornando a escala de trabalho sem alterar os dados de entrada, pois cria listas temporárias para processar as info. Utilizando funções de alta ordem para filtrar e alocar corretamente os bolsistas e seus horários. 

---

## 3. Processo de desenvolvimento

Eu já tinha comecado a desenvolver o front-end do sistema para o laboratório, pois vou implementar esse sistema realmente, então pensei em propor uma parte das funcionalidades do sistema para o trabalho, as escolhidas foram o cadastro dos bolsistas e a geracao da escala de trabalho a partir da proximidade das linhas de pesquisa e dos horários livres dos bolsistas de cada projeto. A ideia inicial era utilizar uma API do gemini para fazer a alocação dos horários, pois já tinha pensando nisso  mas, conversando com a professora, percebeu-se que seria mais fácil apenas implementar um algoritmo de proximidade/similaridade para comparar e gerar a escala.

A primeira decisao foi no armazenamento das grades, pois a ideia seria que a professora fizesse o upload das fotos dos horários de todos os alunos, mas não sei como fazer isso em Haskell então a maneira que pensei para solucionar isso foi a modificacao do formulário de cadastro para que ao invés de fazer o upload da foto da grade, a professora terá que marcar os horários livres dos alunos.

Implementei toda a parte de cadastro, listagem e possibilidade de editar o bolsista, quando fui desenvolver a parte dos horários percebi que estava armazenando os horários errado, com o intervalo e o dia em que estão livres, então segunda livre 2h, por exeplo, mas dessa forma não saberia em qual hora do dia os bolsistas estariam livres para conseguir implementar o algoritmo de proximidade, então alterei a tabela Horarios no banco (ALTER TABLE producao.horarios ADD COLUMN hora_inicio integer not null;) para guardar o horário em que esse intervalo de trabalho começa. 

Na hora dos testes das funcionalidades de cadastro, encontrei erros na parte de declarar os tipos, fui pesquisar no navegador como ajustar e resolvi. Outra decisão foi a de seperar uma página para cada coisa, pois eu estava fazendo tudo junto, já tinha declarado os tipos do Horario no arquivo de Cadastro, mas decidi separar as funcionalidades. Outra decisao foi a forma de armazenar as horas, pois não é 1h inteira, então alterei para guardar o tempo quebrado (ALTER TABLE producao.horarios ALTER COLUMN hora_inicio TYPE numeric;
ALTER TABLE producao.horarios ALTER COLUMN intervalo TYPE numeric;). 

Na parte dos horários tive dificuldade em "Bolsistas por Pesquisa" que é a principal funcionalidade do sistema, pois precisava verificar muitas coisas e acabei me confundidno e tive que fazer várias vezes até conseguir verificar exatamente o que precisava. 

Também decidi armazenar o horário como uma String e não como um Int pelo fato de ser mais fácil depois nas hora de verificar segundo meus conhecimentos. Os erros que encontrei foi na hora de declarar os tipos do cadastro mesmo, pois não tinhamos visto, mas na hora de declarar os do Horarios já estava ciente então tive erros. 

Dificuldades -> HUnit, com certeza, pois no TestMyFunctions da professora já estava tudo funcionando e nesse tive que fazer do zero e para pensar para depois estruturar tudo, pois foram muitas verificações, mas fazer os testes de funcoes foi de longe a parte mais chata, não de dificuldade, mas de ser chato de fazer mesmo, nunca gostei. Mas esse trabalho me ajudou a ver como poderia usar Haskell para resolver problemas do meu dia a dia, o que não estava conseguindo perceber com as atividades de aula. Para resolver os problemas que fui encontrando eu procurava no google e aí ia buscando materiais que falavam e ia testantando mudanças para ver qual funcionava para meus cenários. 

Usei bastante as funções map e filter e o where, então agora posso dizer que consigo trabalhar bem com elas. E também entendi o main IO, pois desde a primeira vez que li isso, não conseguia entender e sempre que tentava usar dava erro, nesse trabalho e com os materiais das aulas consegui utilizar. Outra dificuldade foi trabalhar com vários filter ao mesmo tempo dentro de uma função, pois me confundi bastante, no final quase não sabia o que eu estava aplicando em cada parte e tive que refazer algumas vezes. Basicamente, resumindo, trabalhei com funções puras, de alta ordem, lambda, com composição de funções e where para as verificações. 

A maior dificuldade foi trabalhar com o banco de dados e a conexão, pois já tinha feito isso com PHP e Java, mas Haskell foi diferente, então pesquisei no navegador e não achei nenhum site, mas a IA normal do google <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/298fac4a-dd17-44fb-9a29-3c9d384def64" /> me deu uma parte de um código e então solicitei ao claude que me ajudasse e me mostrasse o que estava faltando.  

Quando fui conectar o banco percebi que tinha criado dentro do banco que uso para meus trabalhos em uma disciplina, então tive que fazer outro arquivo docker para um novo banco, pois desse jeito não estava dando certo. Fiz o código inspirada no material que o professor passou no primeiro dia de aula de banco de dados. Isso me deu muitos erros, pois não estava conseguindo conectar e abrir o pgAdmin mais, então coloquei os códigos para fazer as tabelas no novo banco pelo terminal mesmo. Depois desses vários erros por estar em conflito com meu outro banco, apaguei aquele outro e fiquei só com o desse trabalho e então fui testar no terminal: 
    
    ghci -package postgresql-simple Cadastro.hs Horario.hs Database.hs 
    GHCi, version 9.4.7: https://www.haskell.org/ghc/  :? for help
    [1 of 3] Compiling Cadastro         ( Cadastro.hs, interpreted )
    [2 of 3] Compiling Horario          ( Horario.hs, interpreted )
    [3 of 3] Compiling Database         ( Database.hs, interpreted )
    Ok, three modules loaded.
    ghci> :module Database Cadastro Horario
    ghci> conn <- conectar
    ghci> bolsistas <- buscarTodosBolsistas conn
    ghci> length bolsistas
    0
    ghci> inserirBolsista conn (Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 08:30 10:30")
    ghci> bolsistas <- buscarTodosBolsistas conn
    ghci> length bolsistas
    1

Depois disso, fui para o Scotty, instalei com "sudo apt-get install libghc-scotty-dev". Depois criei o Main e fui colocando o código de acordo com o material e dicas da professora. Consegui terminar essa parte e coloquei os comandos e ele foi me respondendo:

    :load Main.hs
    [1 of 5] Compiling Cadastro         ( Cadastro.hs, interpreted )
    [2 of 5] Compiling Horario          ( Horario.hs, interpreted )
    [3 of 5] Compiling Database         ( Database.hs, interpreted )
    [4 of 5] Compiling Main             ( Main.hs, interpreted )
    Ok, four modules loaded.
    ghci> main 
    Setting phasers to stun... (port 3000) (ctrl-c to quit)
    GET /
    Accept: text/html, application/xhtml+xml, application/xml; q=0.9, */*; q=0.8
    Status: 404 Not Found 0.000281135s
    GET /favicon.ico
    Accept: */*
    Status: 404 Not Found 0.000046216s
    GET /bolsistas
    Accept: text/html, application/xhtml+xml, application/xml; q=0.9, */*; q=0.8
    Status: 200 OK 0.001041309s
 e na web pesquisei: https://ideal-funicular-q5jq5749769hr7j-3000.app.github.dev/bolsistas. Nessa parte ele me mostrou a bolsistas que eu tinha cadastrado antes: "[{"email":"ana@gmail.com","horariosLivres":"segunda 08:30 10:30","linhaPesquisa":"Machine Learning","matricula":"202500101","nome":"Ana"}]"

---

## 4. Testes
Primeiro, instalei o ghc com o comando "sudo apt-get install ghc" e depois "ghci Cadastro.hs TesteMyFunctions.hs".<br> Só que deu esse erro: 

    Cadastro.hs:4:1: error: parse error on input ‘{’
      |
    4 | {
      | ^
    Failed
e não entendi, então voltei no material e não achei nada a respeito, pesquisei no goole e fui nesse site (https://pt.wikibooks.org/wiki/Haskell/Declaração_de_tipos), consegui perceber que minha ',' estavam em lugares diferentes que no código mostrado, depois de alterar isso, instalei o HUnit com -> "sudo apt-get install libghc-hunit-dev", pois deu esse erro:
     <br> [1 of 3] Compiling Cadastro         ( Cadastro.hs, interpreted )
     <br> [2 of 3] Compiling Main             ( TestMyFunctions.hs, interpreted )
      
      TestMyFunctions.hs:4:1: error:
          Could not find module ‘Test.HUnit’
          Use -v (or `:set -v` in ghci) to see a list of the files searched for.
        |
      4 | import Test.HUnit
        | ^^^^^^^^^^^^^^^^^
      Failed, one module loaded.
  <br> Depois disso, "ghci ghci -package HUnit Cadastro.hs TestMyFunctions.hs" com HUnit
     
      GHCi, version 9.4.7: https://www.haskell.org/ghc/  :? for help
      [1 of 3] Compiling Cadastro         ( Cadastro.hs, interpreted )
      [2 of 3] Compiling Main             ( TestMyFunctions.hs, interpreted )
      Ok, two modules loaded.
<br> Sem nenhum erro, comecei a testar algumas funções:

    ghci> matriculaCadastrada [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"] "202500101"
      True
      ghci> matriculaCadastrada [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"] "999"
      False
      ghci> listarBolsistas [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"]
      ["202500101 . Ana . ana@gmail.com . segunda 10:00 12:00 . Machine Learning"]
      ghci> nome (head (editarBolsista [Bolsista "202500101" "Ana" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"] "202500101" "Ana Silva" "ana@gmail.com" "Machine Learning" "segunda 10:00 12:00"))
      "Ana Silva"
      ghci> :q
      Leaving GHCi."
      <br>

     
Essa foram a funções testadas no Cadastro: matriculaCadastrada em que retorna True se a matrícula já foi cadastrada e False se não, neste primeiro caso já tinha sido, pois testei anteriormente a 'cadastrar' e já realizei o cadastro de Ana antes. <br> Testei elas com AssertEquals como aprendi em aula nos arquivos que a professora passou inicialmente e que, depois, tivemos que fazer os códigos, então peguei aqueles códigos de exemplo. <br> E a função de editar o bolsista, edita o bolsista com tal matrícula, atualizando, neste caso, o somnete o nome da pessoa. Mas depois de corrigir o HUnit e os tipos, não tive nenhum problema com as funções do cadastro.  

Para o teste do Horario foi bem fácil, pois já estava tudo instalado então coloquei "ghci -package HUnit Cadastro.hs Horario.hs TestMyFunctionsh.hs" e depois ":module Horario". Meu terminal ficou assim com as funções que testei: 

    ghci> intervaloFim (Horario 1 "segunda" 8.5 2.0 "202500101")
    10.5
    ghci> horasTotais [Horario 1 "segunda" 8.5 2.0 "202500101", Horario 2 "terca" 10.5 2.0 "202500101"] "202500101"
    4.0
    ghci> escalaBolsistas [Horario 1 "segunda" 8.5 2.0 "202500101", Horario 2 "segunda" 8.5 2.0 "202300202"] "segunda" 8.5
    ["202500101","202300202"]
    ghci> verificaCargaHoraria [Horario 1 "segunda" 8.5 2.0 "202500101"] "202500101"
    False
    ghci> verificaCargaHoraria [Horario 1 "segunda" 8.5 2.0 "202500101", Horario 2 "segunda" 10.5 2.0 "202500101", Horario 3 "terca" 8.5 2.0 "202500101", Horario 4 "terca" 10.5 2.0 "202500101", Horario 5 "quarta" 8.5 2.0 "202500101", Horario 6 "quarta" 10.5 2.0 "202500101"] "202500101"
    True

Isso significa que na última verificação a Ana fechou as 12h semanais obrigatórias para todos os bolsistas enquanto na primeira vez que verifiquei isso, ela só tinha 2h semanais, por isso retornou False na primeira e True na última. 
A parte do intervaloFim é para mostrar que o intervalo de trabalho que começa às 08:30 (8.5) acaba às 10:30 (10.5). E as horasTotais representa o total de horas do bolsista em que coloco os intervalos que ele está livre para trabalhar.

---

## 5. Execução

Explique como executar o projeto, incluindo informações sobre dependências necessárias, comandos para compilar ou executar, etc.

---

## 6. Deploy

Link do serviço publicado: <complete aqui>

Descreva de forma breve como você realizou o deploy a partir da base e das orientações fornecidas. Caso não tenha conseguido, explique o que tentou.

---

## 7. Resultado final

Antes do resultado final quero explicar como é funciona no lab atualmente, todo inicio de semestre a professora solicita no frupo de whatsApp a grade de horários dos alunos e depois ela nos manda a tabela com nossos horários. A desse semestre está assim: <img width="250" height="500" alt="image" src="https://github.com/user-attachments/assets/39da0b7b-2014-4c82-b5fd-388383acfe92" />


Apresente o resultado final do trabalho, na forma de GIF animado ou vídeo curto (máximo 60s)

Você também pode acrescentar uma breve explicação sobre o que está sendo demonstrado.

---

## 8. Uso de IA 

### 8.1 Ferramentas de IA utilizadas 

* Gemini 3 Flash Free modo rápido; (utilizado para ajustar markdown)
* Claude.ia Sonnet 4.6 plano pro; (utilizado para entender passo a passo e para corrigir de acordo com o padrão Haskell)

---

### 8.2 Interações relevantes com IA

#### Interação 1

- **Objetivo da consulta:**  ajustar as setas do markdown 
- **Trecho do prompt ou resumo fiel:**  "poderia me ajudar a deixar cada elemento em uma linha ajustando o markdown que colocarei no README do mwu github: --> POST/bolsistas: Cadastra um novo bolsista no sistema, onde são marcados os horários que ele tem disponível; --> GET/bolsistas: Lista todos os bolsistas e suas grades de horários; --> GET/conflitos: Processa as grades e retorna a disponibilidade dos bolsistas; --> POST/bolsistas/:id/grade: Edita a grade de horários de um bolsista para o semestre atual;"
- **O que foi aproveitado:**  copiei e colei essa tag no meu código "br" e os asteriscos com a retirada das setas.
- **O que foi modificado ou descartado:**
"Usar o <br> (Quebra de linha forçada) Se você quer que o texto fique colado na lista, mas na linha de baixo (sem aquele espaço vazio de um parágrafo novo), use a tag <br> ao final da última linha: Markdown
    * **POST /bolsistas**: Cadastra um novo bolsista.
    * **GET /bolsistas**: Lista os bolsistas.
    * **GET /conflitos**: Retorna a disponibilidade.
    * **POST /bolsistas/:id/grade**: Edita a grade.<br>
Aqui o texto aparece imediatamente na linha de baixo, sem o espaço de um parágrafo"

Esse foi o resultado que ele me deu, mas não queria o bold e ele retirou parte das minhas frases que tinha enviado no email da proposta e passei para o tópico dois, então só aproveitei os * e o "br"

#### Interação 2

- **Objetivo da consulta:**  entender o passo a passo, por continuar, pois tinha feito o código para criar o banco de dados e comecei a fazer o código do cadastro, mas não tinha entendido direito pelo email da proposta então pedi para fazer uma guia para eu ir dando check.
- **Trecho do prompt ou resumo fiel:**  Qual ordem devo fazer? fiz o banco, mas não sei por onde prosseguir, minha professora me aconselhou assim: "sem se preocupar com requisições pela web. Depois que isso estiver funcionando, conecte as funções puras ao scotty.Sobre o deploy no Render, já forneci um exemplo que serve de ponto de partida, mas pode ser que você precise adicionar outras dependências e certamente terá que ajustar a localização do código."
- **O que foi aproveitado:**  todo o passo a passo que ele deu serviu de base para ir implementando as funcionalidades
- **O que foi modificado ou descartado:**  <br> "A professora deu a ordem exata. Segue assim:<br>
        1. Representação dos dados + funções puras
        2. Conectar ao banco 
        3. Conectar ao Scotty 
        4. Deploy no Render (por último)" <br> nada foi ajustado nem modificado

#### Interação 3 

- **Objetivo da consulta:** verificar se tinha algo que eu estava fazendo no meu código que não é considerado de bom uso em Haskell
- **Trecho do prompt ou resumo fiel:**  mandei esse prompt para ele: "tenho esse código, poderia me dizer o que está em desacordo com o padrão da linguagem Haskell.
    module cadastro where 
    
    data Bolsistas = Bolsistas 
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
    
    matriculaCadastrada :: [Bolsistas] -> String -> Bool
    matriculaCadastrada bolsistas matricula =
        length (filter(\b -> matricula b == matricula) bolsistas) > 0
    
    cadastrar :: [Bolsistas] -> String -> String -> String -> String -> String -> [Bolsistas]
    cadastrar bolsistas matricula nome email linha_pesquisa horarios_livres = bolsistas ++ [Bolsistas matricula nome email linha_pesquisa horarios_livres]
        where
            jaCadastrado = matriculaCadastrada bolsistas matricula
    
    editarBolsista :: [Bolsistas] -> String -> String -> [Bolsistas]
    editarBolsista bolsistas matricula nome_editado email_editado linha_pesquisa_editada horarios_livres_editado = map atualizaBolsista bolsistas
        where
            atualizaBolsista b = b { nome = nome_editado, email = email_editado, linha_pesquisa = linha_pesquisa_editada, horarios_livres = horarios_livres_editado}
    
    listarBolsistas :: [Bolsistas] -> [String]
    listarBolsistas bolsistas = map (\b ->  matricula b ++ " . " ++ nome b ++ " . " ++ email b ++ " . " ++ horarios_livres ++ " . " ++ linha_pesquisa b) Bolsistas
    
    buscarPorPesquisa :: [Bolsistas] -> String -> [Bolsistas]
    buscarPorPesquisa bolsistas linha_pesquisa = filter(\b -> linha_pesquisa b == linha_pesquisa) bolsistas
    
    buscaPorMatricula :: [Bolsistas] -> String -> [Bolsistas]
    buscaPorMatricula bolsistas matricula = filter(\b -> matricula b == matricula) bolsistas"
- **O que foi aproveitado:** aproveitei para ajustar o nome das variáveis, pois, segundo ele, não é de bom tom utilizar um variável "linha_pesquisa", mas sim "linhaPesquisa";
- **O que foi modificado ou descartado:**  ele me deu essa resposta - <b> "Aqui estão os problemas encontrados:

    **1. Nome do módulo — deve começar com maiúscula:**
    ```haskell
    -- errado
    module cadastro where
    -- certo
    module Cadastro where
    ```
    
    **2. Nome do tipo no plural — convenção Haskell é singular:**
    ```haskell
    -- errado
    data Bolsistas = Bolsistas
    -- certo
    data Bolsista = Bolsista
    ```
    
    **3. snake_case nos campos — Haskell usa camelCase:**
    ```haskell
    -- errado
    linha_pesquisa, horarios_livres, matricula_bolsista, nome_editado
    -- certo
    linhaPesquisa, horariosLivres, matriculaBolsista, nomeEditado
    ```

<br> * gostaria de ressaltar que eneviei o meu código feito já e só solicitei para que ajustasse de acordo com o padrão da linguagem sem alterar a lógica que já tinha feito!

#### Interação 4

- **Objetivo da consulta:** entender como conectar com o banco, pois não achei em nenhum outro site.
- **Trecho do prompt ou resumo fiel:** "Criei o arquivo database.hs e baixei o pacote com "sudo apt-get install libghc-postgresql-simple-dev" o que devo ter nesse arquivo e como conectar com meu banco lifa_hs no postgres?"
- **O que foi aproveitado:**  aproveitei o código de conexão e as dicas do que eu deveria fazer depois.
- **O que foi modificado ou descartado:** aproveitei todo o código que ele me deu, mas também usei uma biblioteca que o google me indicou, também alterei para a porta e usuário que eu estava usando:


        import Database.PostgreSQL.Simple
        import Cadastro
        import Horario
        
        conectar :: IO Connection
        conectar = connect defaultConnectInfo
          { connectHost     = "localhost"
          , connectDatabase = "lifa_hs"
          , connectUser     = "admin"
          , connectPassword = "admin"
          }

---

### 8.3 Exemplo de erro, limitação ou sugestão inadequada da IA

Bom, antes de comecar a implementar as funções, perguntei para o claude como eu iria representar os horários usando os tipos em Haskell. Ele me respondeu isso: <br> 
           
            data Turno = Manha | Tarde | Noite
                deriving (Show, Eq, Ord)
              
            data DiaSemana = Segunda | Terca | Quarta | Quinta | Sexta
              deriving (Show, Eq, Ord)
            
            data Slot = Slot DiaSemana Turno
              deriving (Show, Eq, Ord)
            
            data Bolsista = Bolsista
              { bolsistaId   :: Int
              , bolsistaNome :: String
              , bolsistaSlots :: [Slot]
              } deriving (Show, Eq)
 <br> -> porém achei muito complexo, ele utilizou coisas que não aprendi em aula. Com isso, fui pesquisar como funcionava os tipos em Haskell e encontrei um material (https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.inf.ufpr.br/andrey/ci062/ProgramacaoHaskell.pdf&ved=2ahUKEwj9gaCaop2UAxVEP7kGHerwHIsQFnoECBkQAQ&usg=AOvVaw1Jn5DlTtiu358ISgqHb2rp) que me ajudou a entender como declarar esses tipos. <br> A partir desse erro, percebi que não adiantaria solicitar para IA os códigos pelo fato de ela não acompanhar o meu nível de entendimento de Haskell, então fui buscando nos materiais e no navegador como usar certas funções. Com esse material consegui declarar de um forma que eu entendesse, sem ser muito complexo, mas que acabei não usando o código que a claude gerou. 

---

### 8.4 Comentário pessoal sobre o processo envolvendo IA

* utilizei a IA do gemini 3 Flash Free para me ajudar a configurar o markdown, pois estava com dificuldade de deixar a setas uma embaixo da outra.

* utilizei a claude sonnert 4.6 pro para me ajudar a identificar o que eu tinha escrito no meu código que estava fora do padrão de programação em Haskell.

<br> Não copiei nenhum código de IA, até porque quando solicitei a ela uma maneira de implementar, ela me deu um código muito mais complexo do que tinha visto em aula, o que não me ajudou, mas me fez buscar no navegador formas para implementar os tipos em Haskell, que não tivemos em aual, então consegui aprender algo de diferente. Mas a IA fica muito fixa em fazer códigos que não estão de acordo com meu nível de conhecimento e por mais que isso poderia ajudar, acaba atrapalhando, pois não sei muito do básico ainda então acaba sendo mais complicado de compreender o que ela gera, pois mistura muita coisa e gera coisas "do além" como o 'deriving' que não sei como funciona.

---

## 9. Referências e créditos

- email de avaliacao da proposta com passos fornecidos pela professora;
- material da aula 11 sobre Scotty -> https://liascript.github.io/course/?https://raw.githubusercontent.com/AndreaInfUFSM/elc117-2026a/main/classes/11/README.md

- Página 50 e 51 para os códigos de mostrar os bolsistas e das "data Bolsistas", serviram de base para implementar os meus códigos. -> https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.inf.ufpr.br/andrey/ci062/ProgramacaoHaskell.pdf&ved=2ahUKEwj9gaCaop2UAxVEP7kGHerwHIsQFnoECBkQAQ&usg=AOvVaw1Jn5DlTtiu358ISgqHb2rp

- material da aula 7 para uso do map/filter e lambda -> https://liascript.github.io/course/?https://raw.githubusercontent.com/AndreaInfUFSM/elc117-2026a/main/classes/07/README.md

- material da aula 8 para uso do where -> https://liascript.github.io/course/?https://raw.githubusercontent.com/AndreaInfUFSM/elc117-2026a/main/classes/08/README.md#1

- para "editar" listas, ou seja, uso do 'map' para criar outra lista baseada na primeira, que, na minha cabeça, funciona como uma função de editar -> https://pt.wikibooks.org/wiki/Haskell/Listas_II

- material utilizado para os teste -> https://github.com/elc117/haskell01-2026a-sofiatonetto

- material utilizado para ajustar a forma de declarar os tipos: https://pt.wikibooks.org/wiki/Haskell/Declaração_de_tipos

- material sobre cálculos para fazer a parte dos horários -> https://folivetti.github.io/courses/Haskell/Funcoes

- documento com código docker do meu outro professor -> https://drive.google.com/file/d/1tL7BF0ey4KO4C--5DPMavt3DmH-rC1CT/view?usp=classroom_web&authuser=0
