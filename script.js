function trocarAba(id) {
    document.querySelectorAll('.pagina').forEach(p => p.classList.remove('ativa'))
    document.querySelectorAll('.aba').forEach(a => a.classList.remove('ativa'))
    document.getElementById(id).classList.add('ativa')
    event.target.classList.add('ativa')
}

function cadastrar() {
    const marcados = Array.from(document.querySelectorAll('.tabela-horarios input[type=checkbox]:checked'))
        .map(cb => cb.value)
        .join(', ')

    const dados = new URLSearchParams({
        matricula: document.getElementById('matricula').value,
        nome: document.getElementById('nome').value,
        email: document.getElementById('email').value,
        linhaPesquisa: document.getElementById('linhaPesquisa').value,
        horariosLivres: marcados
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

function editar(mat, nom, ema, lp, hl) {
    document.querySelectorAll('.pagina').forEach(p => p.classList.remove('ativa'))
    document.querySelectorAll('.aba').forEach(a => a.classList.remove('ativa'))
    document.getElementById('cadastro').classList.add('ativa')
    document.querySelectorAll('.aba')[0].classList.add('ativa')

    document.getElementById('matricula').value = mat
    document.getElementById('matricula').readOnly = true
    document.getElementById('nome').value = nom
    document.getElementById('email').value = ema
    document.getElementById('linhaPesquisa').value = lp

    document.querySelectorAll('.tabela-horarios input[type=checkbox]').forEach(cb => {
        cb.checked = hl.includes(cb.value)
    })

    document.getElementById('btnCadastrar').textContent = 'Salvar'
    document.getElementById('btnCadastrar').setAttribute('onclick', 'salvar()')
}

function salvar() {
    const marcados = Array.from(document.querySelectorAll('.tabela-horarios input[type=checkbox]:checked'))
        .map(cb => cb.value)
        .join(', ')

    const mat = document.getElementById('matricula').value

    const dados = new URLSearchParams({
        matricula: mat,
        nome: document.getElementById('nome').value,
        email: document.getElementById('email').value,
        linhaPesquisa: document.getElementById('linhaPesquisa').value,
        horariosLivres: marcados
    })

    fetch('/bolsistas/' + mat, { method: 'POST', body: dados })
        .then(r => r.json())
        .then(() => {
            const msg = document.getElementById('msgCadastro')
            msg.style.display = 'block'
            msg.className = 'mensagem sucesso'
            msg.textContent = 'Bolsista atualizado com sucesso!'
            document.getElementById('matricula').readOnly = false
            document.getElementById('btnCadastrar').textContent = 'Cadastrar'
            document.getElementById('btnCadastrar').setAttribute('onclick', 'cadastrar()')
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
          <td><button onclick="editar('${b.matricula}','${b.nome}','${b.email}','${b.linhaPesquisa}','${b.horariosLivres}')">✏️</button></td>
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
          <td>${horaParaTexto(e.horaInicio)}</td>
          <td>${horaParaTexto(e.horaFim)}</td>
          <td>${e.bolsistas.join(', ')}</td>
        </tr>`
            ).join('')
        })
}

carregarBolsistas()

function horaParaTexto(h) {
    const hora = Math.floor(h)
    const minutos = h % 1 === 0.5 ? '30' : '00'
    return String(hora).padStart(2, '0') + ':' + minutos
}