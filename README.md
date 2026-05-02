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

* Gemini 3 Flash Free modo rápido;

Liste as principais ferramentas de IA utilizadas, com suas versões/modelos/planos. Por exemplo, ChatGPT Free com GPT-5.2 Thinking, GitHub Copilot com Gemini 2.0 Flash, Antigravity com Claude Sonnet 4.6 (Thinking), etc.

---

### 8.2 Interações relevantes com IA

Inclua **de 3 a 5 interações relevantes** com ferramentas de IA.


#### Interação 1

- **Objetivo da consulta:**  ajustar as setas do markdown 
- **Trecho do prompt ou resumo fiel:**  "poderia me ajudar a deixar cada elemento em uma linha ajustando o markdown que colocarei no README do mwu github: --> POST/bolsistas: Cadastra um novo bolsista no sistema, onde são marcados os horários que ele tem disponível; --> GET/bolsistas: Lista todos os bolsistas e suas grades de horários; --> GET/conflitos: Processa as grades e retorna a disponibilidade dos bolsistas; --> POST/bolsistas/:id/grade: Edita a grade de horários de um bolsista para o semestre atual;"
- **O que foi aproveitado:**  copiei e colei essa tag no meu código "br" e os asteriscos com a retirada das setas.
- **O que foi modificado ou descartado:**
"Usar o <br> (Quebra de linha forçada) Se você quer que o texto fique colado na lista, mas na linha de baixo (sem aquele espaço vazio de um parágrafo novo), use a tag <br> ao final da última linha:
Markdown
* **POST /bolsistas**: Cadastra um novo bolsista.
* **GET /bolsistas**: Lista os bolsistas.
* **GET /conflitos**: Retorna a disponibilidade.
* **POST /bolsistas/:id/grade**: Edita a grade.<br>
Aqui o texto aparece imediatamente na linha de baixo, sem o espaço de um parágrafo"

Esse foi o resultado que ele me deu, mas não queria o bold e ele retirou parte das minhas frases que tinha enviado no email da proposta e passei para o tópico dois, então só aproveitei os * e o <br>

#### Interação 2

- **Objetivo da consulta:**  
- **Trecho do prompt ou resumo fiel:**  
- **O que foi aproveitado:**  
- **O que foi modificado ou descartado:**  

#### Interação 3 

- **Objetivo da consulta:**  
- **Trecho do prompt ou resumo fiel:**  
- **O que foi aproveitado:**  
- **O que foi modificado ou descartado:**  

#### Interação 4 (opcional)

- **Objetivo da consulta:**  
- **Trecho do prompt ou resumo fiel:**  
- **O que foi aproveitado:**  
- **O que foi modificado ou descartado:**  

#### Interação 5 (opcional)

- **Objetivo da consulta:**  
- **Trecho do prompt ou resumo fiel:**  
- **O que foi aproveitado:**  
- **O que foi modificado ou descartado:**  

---

### 8.3 Exemplo de erro, limitação ou sugestão inadequada da IA

Descreva **ao menos um caso** em que a IA:

- errou
- foi incompleta
- sugeriu algo inadequado ou incompreensível
- produziu código que precisou de correção relevante

Explique brevemente o que aconteceu e como você percebeu ou corrigiu o problema.

---

### 8.4 Comentário pessoal sobre o processo envolvendo IA

* utilizei a IA do gemini 3 Flash Free para me ajudar a configurar o markdown, pois estava com dificuldade de deixar a setas uma embaixo da outra.

Escreva um breve comentário pessoal sobre o processo envolvendo IA.

Você pode comentar, por exemplo:

- algo que passou a compreender melhor
- uma dificuldade que conseguiu superar
- uma limitação que ainda sente
- como o uso de IA ajudou ou atrapalhou em certos momentos.

---

## 9. Referências e créditos

Liste referências e créditos de forma detalhada, com título e URL, incluindo, quando aplicável:

- sites consultados
- documentações
- materiais de aula
- colegas
- trechos de código adaptados
- imagens, vídeos 

Exemplo:

- Documentação do Scotty: ...
- Documentação do Render: ...
- Material de aula da disciplina: ...
- Vídeo sobre Scotty: ...
