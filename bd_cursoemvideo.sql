-- SQL - “Structured Query Language”

-- DDL - Definition - create(database,table) alter drop
-- DML - Manipulation - insert update delete truncate
-- DQL - Query - select pode ser DML em alguns livros
-- linhas tuplas registros
-- colunas campos ou atributos
create database cadastro
default character set utf8
default collate utf8_general_ci; -- permitem o uso de acentos e caracteres especiais
use cadastro;

-- usar nomes entre crases permitem o uso de acentos e caracteres especiais nesses 
create table `pessoas`(
id int not null auto_increment,
`nome` varchar(30) not null,
`nascimento` date,
`sexo` enum('M','F'),
`peso` decimal(5,2),
`altura` decimal(3,2),
`nacionalidade` varchar(20) default 'Brasil',
primary key(id)
)default charset=utf8 engine=innodb;


insert into `pessoas`(id,`nome`,`nascimento`,`sexo`,`peso`,`altura`,`nacionalidade`)
values(null, 'Godofredo', '1984-03-19', 'M', 64.2, 1.87, 'EUA');

insert into `pessoas` (id,`nome`,`nascimento`,`sexo`,`peso`,`altura`, `nacionalidade`)
values(null, 'Maria', '1984-03-19', 'F', 54.2, 1.57, default);

insert into `pessoas`
values(null, 'Creuza', '1967-04-15', 'F', 61.3, 1.67, 'Irlanda');

insert into `pessoas`
values(null, 'Joana', '1964-08-10', 'F', 45.9, 1.73, 'Suécia'),
(null, 'Mário', '1985-02-01', 'M', 100.3, 1.80, 'Nova Zelândia'),
(default, 'Fábio', '1980-12-12', 'M', 81.3, 1.72, 'EUA'),
(default, 'Luís', '1997-10-28', 'M', 90, 1.89, default);

-- alterando colunas
alter table `pessoas` add column(`profissão` varchar(10));
describe `pessoas`;

alter table `pessoas` drop column `profissão`;
describe `pessoas`;

alter table `pessoas` add column `profissão` varchar(10) not null after `altura`;
alter table `pessoas` add `codigo` int first;

-- modify altera tipos e constraints
alter table `pessoas` modify column `profissão` varchar(20) not null default'';

-- change consegue alterar o tipo, constraints e o nome das colunas
alter table `pessoas` change column `profissão` prof varchar(20) not null default'';

-- renomear tabela
alter table `pessoas` rename to `gafanhotos`;
describe `gafanhotos`;

create table if not exists `cursos`(
nome varchar(30), 
descricao text, -- utilizada para escrever textos grandes com paragrafos
carga int, 
tot_aulas int,
ano year default '2020' 
)default charset=utf8 engine=innodb;

alter table cursos add column  teste char(5) not null after nome;
alter table cursos drop column trst;
desc cursos;


alter table `cursos` drop column idcurso;
alter table `cursos` add idcurso int auto_increment not null primary key first;
alter table `cursos` modify column nome varchar(30) unique; -- unique não deixa criar a mesma coisa 2x
desc `cursos`;

create table if not exists teste(
id int,
nome varchar(10),
idade int
)default charset=utf8 engine=innodb;

insert into teste values
(1,'Pedro',22),
(2,'Maria',12),
(3,'Naricota',77);
select * from teste;
drop table if exists teste;

insert into cursos values
('1','HTML4','Curso de HTML5','40','37','2014'),
('2','Algoritimos','Lógica de Programação','20','15','2014'),
('3','Photoshop','Dicas de Photoshop CC','10','8','2014'),
('4','PGP','Curso de PHP para iniciantes','40','20','2014'),
('5', 'Jarva','Introdução à Linguagem Java','10','29','2000'),
('6', 'MySQL','Bancos de Dados MySQL','30','15',2016),
('7', 'Word','Curso completo de Word','40','30','2016'),
('8','Sapateado','Danças Rítmicas','40','30','2018'),
('9', 'Cozinha Árabe','Aprenda a fazer Kibe','40','30','2018'),
('10', 'YouTuber','Gerar polêmica e ganhar inscritos','5','2','2018');
select*from gafanhotos;

describe cursos;

-- alterando linhas
update cursos set nome='HTML5' where idcurso='1';
update cursos set nome='PHP',ano='2015' where idcurso='4';
update cursos set nome='Java',ano='2015',carga='40' where idcurso='5' limit 1; -- Limit limita a ação do comando ou seja so afeta linhas de acordo com o máximo especificado

update cursos set ano='2050',carga='800' where ano ='2018';
update cursos set ano='2018',carga='0' where ano='2050' limit 1; -- Limit alterará somente a primeira linha com essas especifiicações

delete from cursos where idcurso='8';
delete from cursos where ano='2050' limit 2;

-- ambos deleterão os dados mas manterão a estrutura da tabela
truncate table cursos; truncate cursos;
delete from cursos;
-- drop database cadastro;

-- após o novo dump
select nome,carga,ano from cursos
order by ano,nome; -- parametros select = desc - decendent - asc - ascendent

select nome,ano from cursos 
where ano <> '2016' -- <> é o mesmo que !=
order by ano;

select nome, ano from cursos
where ano between 2014 and 2016
order by ano desc, nome asc;

select nome, ano from cursos 
where ano in(2014,2016,2020)
order by ano;

select nome,carga,totaulas from cursos 
where carga > 35 and totaulas < 30;

-- wildcards
-- % caracter coringa que substitui nenhum ou vários caracteres
-- _ exige que tenha algo no local em que for colocado
select * from cursos
where nome like 'P%';

select * from cursos 
where nome like '%A';

select * from cursos
where nome like '%A%';

select * from cursos
where nome not like '%A%';

select * from cursos 
where nome like 'ph%p_';

select * from cursos
where nome like 'p__t%';


select distinct nacionalidade from gafanhotos;

-- funçoes de agregaçao
select count(*) from cursos where carga > 40;
select max(totaulas) from cursos where ano = 2016;
select min(totaulas) from cursos where ano = 2016;
select sum(totaulas) from cursos where ano = 2016;
select avg(totaulas) from cursos where ano = 2016;

-- exercicios
/*
1) Uma lista com o nome de todos os gafanhotos Mulheres.
2) Uma lista com os dados de todos aqueles que nasceram entre 1/Jan/2000 e 31/Dez/2015.
3) Uma lista com o nome de todos os homens que trabalham como programadores.
4) Uma lista com os dados de todas as mulheres que nasceram no Brasil e que têm seu nome iniciando com a letra J.
5) Uma lista com o nome e nacionalidade de todos os homens que têm Silva no nome, não nasceram no Brasil e pesam menos de 100 Kg.
6) Qual é a maior altura entre gafanhotos Homens que moram no Brasil?
7) Qual é a média de peso dos gafanhotos cadastrados?
8) Qual é o menor peso entre os gafanhotos Mulheres que nasceram fora do Brasil e entre 01/Jan/1990 e 31/Dez/2000?
9) Quantas gafanhotos Mulheres tem mais de 1.90cm de altura?
*/
-- 1
 select nome from gafanhotos where sexo = 'F';
-- 2
select * from gafanhotos where nascimento between '2000-01-01' and '2015-12-31';
-- 3
select nome from gafanhotos where sexo = 'M' and profissao = 'Programador';
-- 4
select nome from gafanhotos where sexo = 'F' and nome like 'J%' and nacionalidade = 'Brasil' order by nome;
-- 5
select nome, nacionalidade from gafanhotos where sexo = 'M' and nome like '%Silva%' and nacionalidade !='Brasil' and  peso < 100;
-- 6
select max(altura) as maior_altura from gafanhotos where sexo = 'M' and nacionalidade = 'Brasil';
-- 7
select avg(peso) as media_peso from gafanhotos;
-- 8
select min(peso) from gafanhotos where sexo = 'F' and nacionalidade != 'Brasil' and nascimento between '1990-01-01' and '2000-12-31';
-- 9
select count(*) from gafanhotos where sexo = 'F' and altura > 1.9;
 
-- agrupamentos
select totaulas, count(*) from cursos
group by totaulas
order by totaulas;

select carga, count(nome) from cursos where totaulas = 30
group by carga;

select ano, count(*) from cursos
group by ano
having count(ano) >= 5
order by count(*) desc;

select ano, count(*) from cursos 
where totaulas > 30
group by ano
having ano > 2013
order by count(*) desc;

select carga, count(*) from cursos
where ano>2015
group by carga
having carga > (select avg(carga) from cursos);

-- exercicios
/*
1-uma lista com as profissoes dos gafanhatos e seus respectivos quantitativos.
2- Quantos gafanhotos homens e mulheres nasceram após 01/jan/2005 ?
3- Lista com gafanhotos que nasceram fora do BRASIL, mostrando o país de origem
e o total de pessoas nascidas lá. Só nos interessam os países que tiveram mais de 3
gafanhotos com essa nacionalidade. 
4- uma lista agrupada pela altura dos gafanhotos ,mostrando quantas pessoas 
pesam mais de 100kg e que estao acima da media da altura de todos os gafanhotoso.*/

describe gafanhotos;

-- 1
select profissao, count(*) from gafanhotos
group by profissao
order by count(*) desc;
-- 2
select sexo, count(*) from gafanhotos
where nascimento > '2005-01-01'
group by sexo;
-- 3
select nacionalidade, count(*) from gafanhotos 
where nacionalidade <> 'Brasil'
group by nacionalidade
having count(*) > 3;
-- 4
select avg(altura) from gafanhotos;
select nome,altura,count(*) from gafanhotos
where peso > 100
group by altura
having altura > (select avg(altura) from gafanhotos);

-- chaves estrangeiras e join

desc cursos;
desc gafanhotos;
alter table gafanhotos add column cursopreferido int;
alter table gafanhotos add foreign key (cursopreferido) references cursos(idcurso);

update gafanhotos set cursopreferido = 6 where id=1;
select*from gafanhotos;

select gafanhotos.nome, gafanhotos.cursopreferido, cursos.nome, cursos.ano
from gafanhotos join cursos
on cursos.idcurso = gafanhotos.cursopreferido
order by gafanhotos.nome;

select g.nome, g.cursopreferido, c.nome, c.ano
from gafanhotos as g left outer join cursos as c
on c.idcurso = g.cursopreferido
order by c.nome desc;

select g.nome, g.cursopreferido, c.nome, c.ano
from gafanhotos as g right outer join cursos as c
on c.idcurso = g.cursopreferido;

-- criando tabela extra para relacionamento n-n

create table gafanhoto_assiste_curso(
id int not null auto_increment,
data date,
idgafanhoto int,
idcursos int,
primary key(id),
foreign key (idgafanhoto) references gafanhotos(id),
foreign key(idcursos) references cursos(idcurso)
)engine=innodb default charset=utf8;

insert into gafanhoto_assiste_curso values
(default,'2014-03-01','1','1');
select*from gafanhoto_assiste_curso;

select g.nome, a.idcursos, c.nome from gafanhotos as g join gafanhoto_assiste_curso as a
on g.id = a.idgafanhoto join cursos c on c.idcurso=a.idcursos;

update cursos,gafanhotos set cursos.nome = 'l',gafanhotos.nome='l' where cursos.idcurso=1 and gafanhotos.id=1;
