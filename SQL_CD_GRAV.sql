create database db_cds;
use db_cds;

create table tb_artista(
	cod_art int primary key auto_increment,
    nome_art varchar(100) unique not null 
);

select * from tb_artista;

create table tb_gravadora(
	cod_grav int primary key auto_increment,
    nome_grav varchar(50) unique not null
);

create table tb_categoria(
	cod_cat int primary key auto_increment,
    nome_cat varchar(50) unique not null
);

create table tb_estado(
	sigla_est char(2) primary key not null,
    nome_est char(50) not null 
);

create table tb_cidade(
	cod_cid int primary key auto_increment,
    sigla_est char(2) not null, constraint FK_sigla_est foreign key(sigla_est) references tb_estado(sigla_est),
    nome_cid varchar(100) not null
);

create table tb_cliente(
	cod_cli int primary key auto_increment,
    cod_cid int not null, constraint FK_cod_cid foreign key(cod_cid) references tb_cidade(cod_cid),
    nome_cli varchar(100) not null,
    end_cli varchar(200) not null,
    renda_cli decimal(10,2) not null,
    sexo enum('f', 'm')
);

create table tb_conjuge(
	cod_cli int primary key not null, constraint FK_cod_cli foreign key(cod_cli) references tb_cliente(cod_cli),
    nome_conj varchar(100) not null,
    renda_conj decimal(10,2) not null,
    sexo_conj enum('f', 'm') not null
);

create table tb_funcionario(
	cod_func int primary key auto_increment,
    nome_func varchar(100) not null,
    end_func varchar(200) not null,
    sal_func decimal(10,2) not null,
    sexo_func enum('f', 'm') not null
);

create table tb_dependente(
	cod_dep int primary key auto_increment,
    cod_func int not null, constraint FK_cod_func foreign key(cod_func) references tb_funcionario(cod_func),
    nome_dep varchar(100) not null,
    sexo_dep enum('f', 'm') not null
);

create table tb_titulo(
	cod_tit int primary key auto_increment,
    cod_cat int not null, constraint FK_cod_cat foreign key(cod_cat) references tb_categoria(cod_cat),
	cod_grav int not null, constraint FK_cod_grav foreign key(cod_grav) references tb_gravadora(cod_grav),
    nome_cd varchar(100) unique not null,
    val_cd decimal(10,2) not null,
    qtd_estq int not null
);

create table pedido(
	num_ped int primary key auto_increment,
    cod_cli int not null, constraint FK_cod_cli_ped foreign key(cod_cli) references tb_cliente(cod_cli),
    cod_func int not null,  constraint FK_cod_func_ped foreign key(cod_func) references tb_funcionario(cod_func),
    data_ped datetime not null,
    val_ped decimal(10,2) not null
);

create table tb_titulo_pedido(
	num_ped int not null,  constraint FK_num_ped_tp foreign key(num_ped) references pedido(num_ped),
    cod_tit int not null,  constraint FK_cod_tit_tp foreign key(cod_tit) references tb_titulo(cod_tit),
    qtd_cd int not null,
    val_cd decimal(10,2) not null
);

create table tb_titulo_artista(
	 cod_tit int not null,  constraint FK_cod_tit foreign key(cod_tit) references tb_titulo(cod_tit),
     cod_art int not null,  constraint FK_cod_art foreign key(cod_art) references tb_artista(cod_art)
);

INSERT INTO tb_artista (nome_art)
VALUES ('John Carlos Junior'),
       ('Lucas Smith'),
       ('Michael Johnson Jr.');

INSERT INTO tb_gravadora (nome_grav)
VALUES ('Universal Music Group'),
       ('Sony Music Entertainment'),
       ('Warner Music Group');

INSERT INTO tb_categoria (nome_cat)
VALUES ('Rock'),
       ('Pop'),
       ('Hip Hop');

INSERT INTO tb_estado (sigla_est, nome_est)
VALUES ('SP', 'São Paulo'),
       ('RJ', 'Rio de Janeiro'),
       ('MG', 'Minas Gerais');

INSERT INTO tb_cidade (sigla_est, nome_cid)
VALUES ('SP', 'São Paulo'),
       ('RJ', 'Rio de Janeiro'),
       ('MG', 'Belo Horizonte');

INSERT INTO tb_cliente (cod_cid, nome_cli, end_cli, renda_cli, sexo)
VALUES (1, 'João Silva', 'Rua A, 123', 3000.00, 'M'),
       (2, 'Maria Santos', 'Av. B, 456', 2500.00, 'F'),
       (3, 'Pedro Souza', 'Rua C, 789', 4000.00, 'M');

INSERT INTO tb_conjuge (cod_cli, nome_conj, renda_conj, sexo_conj)
VALUES (1, 'Ana Silva', 2000.00, 'F'),
       (3, 'Carla Souza', 3500.00, 'F');

INSERT INTO tb_funcionario (nome_func, end_func, sal_func, sexo_func)
VALUES ('Fernanda Oliveira', 'Rua X, 987', 5000.00, 'F'),
       ('Marcos Santos', 'Av. Y, 654', 4500.00, 'M');

INSERT INTO tb_dependente (cod_func, nome_dep, sexo_dep)
VALUES (1, 'Luiza Oliveira', 'F'),
       (1, 'Pedro Oliveira', 'M'),
       (2, 'Sophia Santos', 'F');

INSERT INTO tb_titulo (cod_cat, cod_grav, nome_cd, val_cd, qtd_estq)
VALUES (1, 1, 'Álbum 1', 29.99, 50),
       (2, 2, 'Álbum 2', 19.99, 100),
       (3, 3, 'Álbum 3', 24.99, 75);

INSERT INTO pedido (cod_cli, cod_func, data_ped, val_ped)
VALUES (1, 1, '2023-05-22 10:00:00', 59.98),
       (2, 2, '2023-05-22 11:30:00', 39.98),
       (3, 1, '2023-05-22 14:45:00', 74.97);

INSERT INTO tb_titulo_pedido (num_ped, cod_tit, qtd_cd, val_cd)
VALUES (1, 1, 2, 59.98),
       (2, 2, 1, 19.99),
       (3, 3, 3, 74.97);

INSERT INTO tb_titulo_artista (cod_tit, cod_art)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (3, 1);

-------------------------------------------------------------       
SELECT c.nome_cat, t.nome_cd
FROM tb_categoria c
JOIN tb_titulo t ON c.cod_cat = t.cod_cat;

SELECT *
FROM tb_categoria;

SELECT c.nome_cat, t.nome_cd
FROM tb_categoria AS c
JOIN tb_titulo AS t ON c.cod_cat = t.cod_cat;

SELECT c.nome_cat, t.nome_cd	
FROM tb_categoria c
JOIN tb_titulo t ON c.cod_cat = t.cod_cat
WHERE c.nome_cat = 'pop';

-------------------------------------------------------------  

SELECT p.num_ped, c.nome_cli
FROM pedido p
JOIN tb_cliente c ON p.cod_cli = c.cod_cli;
-------------------------------------------------------------  

SELECT f.nome_func AS nome_funcionario, d.nome_dep AS nome_dependente
FROM tb_funcionario f
JOIN tb_dependente d ON f.cod_func = d.cod_func;
------------------------------------------------------------- 

SELECT f.nome_func AS nome_funcionario, SUM(tp.val_cd) AS valor_pedidos
FROM tb_funcionario f
JOIN pedido p ON f.cod_func = p.cod_func
JOIN tb_titulo_pedido tp ON p.num_ped = tp.num_ped
GROUP BY f.nome_func;
------------------------------------------------------------- 

SELECT c.nome_cli, ci.nome_cid
FROM tb_cliente c
JOIN tb_cidade ci ON c.cod_cid = ci.cod_cid
WHERE c.sexo = 'f';
------------------------------------------------------------- 

SELECT t.nome_cd, g.nome_grav
FROM tb_titulo t
JOIN tb_gravadora g ON t.cod_grav = g.cod_grav
WHERE t.nome_cd LIKE 'R%' OR t.nome_cd LIKE 'T%';
------------------------------------------------------------- 

SELECT g.nome_grav, t.nome_cd, t.val_cd, t.qtd_estq
FROM tb_titulo t
JOIN tb_gravadora g ON t.cod_grav = g.cod_grav
WHERE t.qtd_estq < 500;
------------------------------------------------------------- 

SELECT c.nome_cli, SUM(tp.val_cd) AS valor_pedidos
FROM tb_cliente c
JOIN pedido p ON c.cod_cli = p.cod_cli
JOIN tb_titulo_pedido tp ON p.num_ped = tp.num_ped
WHERE c.sexo = 'f'
  AND YEAR(p.data_ped) = 2002
  AND MONTH(p.data_ped) = 6
GROUP BY c.nome_cli;
------------------------------------------------------------- 

SELECT p.num_ped, p.val_ped, p.data_ped, f.nome_func
FROM pedido p
JOIN tb_funcionario f ON p.cod_func = f.cod_func
WHERE YEAR(p.data_ped) = 2003
  AND f.nome_func LIKE 'Paula%';
-------------------------------------------------------------

SELECT p.num_ped, c.nome_cli
FROM pedido p
JOIN tb_cliente c ON p.cod_cli = c.cod_cli
WHERE p.val_ped = (SELECT MAX(val_ped) FROM pedido);
-------------------------------------------------------------

SELECT DISTINCT a.nome_art, c.nome_cat
FROM tb_artista a
JOIN tb_titulo_artista ta ON a.cod_art = ta.cod_art
JOIN tb_titulo t ON ta.cod_tit = t.cod_tit
JOIN tb_categoria c ON t.cod_cat = c.cod_cat;
-------------------------------------------------------------

SELECT c.cod_cli, f.cod_func
FROM tb_cliente c, tb_funcionario f;

SELECT c.nome_cli, f.nome_func
FROM tb_cliente c, tb_funcionario f;
-------------------------------------------------------------

SELECT c.nome_cli, t.nome_cd
FROM tb_cliente c
JOIN pedido p ON c.cod_cli = p.cod_cli
JOIN tb_titulo_pedido tp ON p.num_ped = tp.num_ped
JOIN tb_titulo t ON tp.cod_tit = t.cod_tit;
-------------------------------------------------------------

SELECT t.nome_cd, g.nome_grav, c.nome_cat
FROM tb_titulo t
JOIN tb_gravadora g ON t.cod_grav = g.cod_grav
JOIN tb_categoria c ON t.cod_cat = c.cod_cat;
-------------------------------------------------------------

SELECT f.nome_func, d.nome_dep, c.nome_cli, cj.nome_conj
FROM tb_funcionario f
LEFT JOIN tb_dependente d ON f.cod_func = d.cod_func
LEFT JOIN tb_cliente c ON f.cod_func = c.cod_cli
LEFT JOIN tb_conjuge cj ON c.cod_cli = cj.cod_cli;
-------------------------------------------------------------

SELECT c.nome_cli, f.nome_func, t.nome_cd, cat.nome_cat, g.nome_grav
FROM tb_cliente c
JOIN pedido p ON c.cod_cli = p.cod_cli
JOIN tb_funcionario f ON p.cod_func = f.cod_func
JOIN tb_titulo_pedido tp ON p.num_ped = tp.num_ped
JOIN tb_titulo t ON tp.cod_tit = t.cod_tit
JOIN tb_categoria cat ON t.cod_cat = cat.cod_cat
JOIN tb_gravadora g ON t.cod_grav = g.cod_grav;





















