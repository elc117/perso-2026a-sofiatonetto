create table if not exists producao.bolsistas(
	matricula text primary key,
	nome varchar(50) not null,
	email varchar(50) not null,
	linha_pesquisa text not null,
	horarios_livres text not null
);

create table if not exists producao.horarios(
	id integer primary key,
	dia text not null, 
	intervalo integer not null,
	matricula_bolsista text not null,
	foreign key (matricula_bolsista) references producao.bolsistas(matricula)
);
