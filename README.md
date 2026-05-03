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

- como a ideia inicial evoluiu (ok)

  A fazer: (tudo a partir daqui)
- decisões tomadas ao longo do desenvolvimento
- erros encontrados
- dificuldades específicas enfrentadas
- tentativas de solução
- mudanças de rumo
- comentários pessoais sobre o que você compreendeu no processo e sobre questões que ainda persistem
- como você separou a lógica do serviço da parte ligada ao Scotty
- quais funções puras e estruturas de dados foram importantes no trabalho
- quais aspectos de programação funcional apareceram no desenvolvimento

Este não é um espaço para escrever algo como "foi difícil mas superei as dificuldades". O objetivo é mostrar sinais reais de desenvolvimento, reflexão, aprendizado e resolução de problemas. 

Se o desenvolvimento não conseguir atingir todos os objetivos e requisitos, essa seção é muito importante para mostrar o que você tentou.

---

## 4. Testes

Descreva brevemente como você lidou com os testes unitários das funções que implementam a lógica do serviço, independentemente do Scotty.

Inclua, se necessário:

- quais funções puras foram testadas;
- como os testes foram organizados;
- se você usou HUnit ou outro modo simples de teste;
- exemplos curtos do que foi verificado.

Lembre que não se trata de testar se o serviço funciona pela web, mas sim de testar as funções puras que implementam a lógica.

---

## 5. Execução

Explique como executar o projeto, incluindo informações sobre dependências necessárias, comandos para compilar ou executar, etc.

---

## 6. Deploy

Link do serviço publicado: <complete aqui>

Descreva de forma breve como você realizou o deploy a partir da base e das orientações fornecidas. Caso não tenha conseguido, explique o que tentou.

---

## 7. Resultado final

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
