function trocarAba(id) {
  document.querySelectorAll('.pagina').forEach(p => p.classList.remove('ativa'))
  document.querySelectorAll('.aba').forEach(a => a.classList.remove('ativa'))
  document.getElementById(id).classList.add('ativa')
  event.target.classList.add('ativa')
}

function cadastrar() {
  const dados = new URLSearchParams({
    matricula:      document.getElementById('matricula').value,
    nome:           document.getElementById('nome').value,
    email:          document.getElementById('email').value,
    linhaPesquisa:  document.getElementById('linhaPesquisa').value,
    horariosLivres: document.getElementById('horariosLivres').value
  })

  fetch('/bolsistas', { method: 'POST', body: dados })
    .then(r => r.json())
    .then(data => {
      const msg = document.getElementById('msgCadastro')
      msg.style.display = 'block'
      msg.className = 'mensagem sucesso'
      msg.textContent = data.mensagem || 'Cadastrado com sucesso!'
    })
    .catch(() => {
      const msg = document.getElementById('msgCadastro')
      msg.style.display = 'block'
      msg.className = 'mensagem erro'
      msg.textContent = 'Erro ao cadastrar!'
    })
}

function carregarBolsistas() {
  fetch('/bolsistas')
    .then(r => r.json())
    .then(data => {
      const tbody = document.getElementById('tabelaBolsistas')
      tbody.innerHTML = data.map(b =>
        `<tr>
          <td>${b.matricula}</td>
          <td>${b.nome}</td>
          <td>${b.email}</td>
          <td>${b.linhaPesquisa}</td>
          <td>${b.horariosLivres}</td>
        </tr>`
      ).join('')
    })
}

function carregarEscala() {
  fetch('/escala')
    .then(r => r.json())
    .then(data => {
      const tbody = document.getElementById('tabelaEscala')
      tbody.innerHTML = data.map(e =>
        `<tr>
          <td>${e.dia}</td>
          <td>${e.horaInicio}</td>
          <td>${e.horaFim}</td>
          <td>${e.bolsistas.join(', ')}</td>
        </tr>`
      ).join('')
    })
}

carregarBolsistas()