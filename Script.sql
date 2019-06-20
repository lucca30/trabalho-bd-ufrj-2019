/*
===================	Definição do Banco de de Dados  ====================
*/

CREATE SCHEMA IF NOT EXISTS BD120191 ;
USE BD120191; 

SET FOREIGN_KEY_CHECKS=0; 

drop table if exists 
    TransporteContainer,
	PessoaFisica,
    PessoaJuridica,
    Cliente,
	Armazem,
	Seguradora,
    Acidente,
    Unidade,
    Pedido,
    Rota,
    TipoVeiculo,
    Funcionario,
    Lote,
    Veiculo,
    Container,
    Produto,
    Motorista,
    Estoquista,
    Pilota,
    Transporte,
    Cobre,
    Estoca,
    PedidoContainerProduto;
    
SET FOREIGN_KEY_CHECKS=1;
/*____________________________CRIAÇÃO DAS TABELAS______________________________*/

/*OBSERVAÇÃO IMPORTANTE: as definições de chaves estrangeiras estão no final do script,
na parte "DEFINIÇÃO DE CHAVES ESTRANGEIRAS" */

CREATE TABLE PessoaFisica(

/*Função: guardar as informações específicas do cliente que
	 é cadastrado como pessoa física(cpf e RG, por exemplo).*/

cpf VARCHAR(11) UNIQUE,
rg VARCHAR(9) UNIQUE,

/*Chave estrangeira, que aponta para a instância 
	de Cliente que é criada no momento do cadastro*/
idCliente_SPK INT,
PRIMARY KEY (idCliente_SPK)
);

CREATE TABLE PessoaJuridica (
/*Função: guardar as informações específicas do cliente que
	 é cadastrado como pessoa jurídica(cnpj e razão social, por exemplo).*/

cnpj VARCHAR(14) UNIQUE,
razaoSocial VARCHAR(30),

/*Chave estrangeira, que aponta para a instância 
	de Cliente que é criada no momento do cadastro*/
idCliente_SPK INT 
);

CREATE TABLE Cliente (
/*Função: guardar as informações gerais de um cliente
			(email, endereço, telefone, etc)*/
idCliente_PK INT PRIMARY KEY,
cep VARCHAR(8),
emailCliente VARCHAR(60),

/*Checa se o email do cliente está no formato x@y.z */
CONSTRAINT CHK_emailCliente
	CHECK(emailCliente LIKE '%_@_%._%'),

nome VARCHAR(30),
endereco VARCHAR(30),
telefone VARCHAR(11)
);

CREATE TABLE Armazem (
/*Função: guardar as informações fisicas e de disponibilidade de um armazém.*/
idArmazem_PK INT NOT NULL,
idUnidade_FK INT NOT NULL,
PRIMARY KEY (idArmazem_PK)
);

CREATE TABLE Seguradora (
/*Função: guardar as informações de uma seguradora, que pode ou não 
			cobrir acidentes que podem acontecer com pedidos que são 
					transportados pela empresa;*/


idSeguradora_PK INT PRIMARY KEY,
emailSeguradora VARCHAR(60),

/*Checa se o email da seguradora está no formato x@y.z */
CONSTRAINT CHK_emailSeguradora
	CHECK(emailSeguradora LIKE '%_@_%._%'),

cnpj VARCHAR(14) UNIQUE,
razaoSocial VARCHAR(60),
nome VARCHAR(60),
telefone VARCHAR(11)
);

CREATE TABLE Acidente (
/*Função: guarda informações sobre acidentes em transportes realizados pela empresa*/

idAcidente_PK INT PRIMARY KEY,
descricao VARCHAR(600),
nome VARCHAR(100)
);

CREATE TABLE Unidade (
/*Função: guardar as informações sobre cada unidade da empresa
			(email,telefone, etc)*/

idUnidade_PK INT PRIMARY KEY NOT NULL,

emailUnidade VARCHAR(60),

/*Checa se o email da unidade está no formato x@y.z */
CONSTRAINT CHK_emailUnidade
	CHECK(emailUnidade LIKE '%_@_%._%'),

endereco VARCHAR(30),
cep VARCHAR(8),
telefone VARCHAR(11)
);

CREATE TABLE Pedido (
/*Função: guardar as informações sobre um pedido
			(qual cliente solicitou,datas de solicitação e entrega,
					 qual o destinatário, etc)*/

idPedido_PK INT PRIMARY KEY,
dataEntrega DATE,
dataSolicitacao DATE,

/*Impede que a data da entrega aconteça antes que o pedido tenha sido solicitado*/ 
CONSTRAINT CHK_dataEntrega
	CHECK(dataSolicitacao <= dataEntrega),

idUnidadeOrigem_FK INT,
idUnidadeDestino_FK INT,
/*Chave estrangeira, indica qual cliente solicitou esse pedido*/
idCliente_FK INT
);

CREATE TABLE Rota (
/*Função: indica que há um caminho entre as unidadeOrigem e unidadeDestino*/

id INT,

/*Chave estrangeira, aponta para a unidade de origem*/
idUnidadeOrigem_SPK INT,

/*Chave estrangeira, aponta para a unidade de destino*/
idUnidadeDestino_SPK INT,

idTipoVeiculo_FK INT,

PRIMARY KEY (id)
);

CREATE TABLE TipoVeiculo (

id INT not null,
nome VARCHAR(50),
numMaxContainers INT, 

PRIMARY KEY (id)

);

CREATE TABLE Funcionario (
/*Função: guarda infos. gerais sobre um funcionário(email, 
			matricula, departamento, endereço, etc)*/
idFuncionario_PK INT PRIMARY KEY,
emailFuncionario VARCHAR(60),
/*Checa se o email do funcionário está no formato x@y.z */
CONSTRAINT CHK_emailFuncionario
	CHECK(emailFuncionario LIKE '%_@_%._%'),
dataContratacao DATE,
salario float,
endereco VARCHAR(30),
rg VARCHAR(9) UNIQUE,
telefone VARCHAR(11),
dataNascimento DATE,

/*Impede que a data de nascimento do funcionário esteja posterior a 
		data de sua contratação*/
CONSTRAINT CHK_dataContratacao
	CHECK(dataNascimento < dataContratacao),

/*Chave estrangeira, indica qual unidade o funcionário trabalha*/
idUnidade_FK INT
);

CREATE TABLE Lote (
/*Função: guarda informações sobre um espaço específico no armazem
		(cada "vaga" no "estacionamento")*/
idLote_PK INT NOT NULL PRIMARY KEY,
setor INT,
posicao INT,

/*Chave estrangeira, indica a qual armazem esse lote pertence*/
idArmazem_FK INT NOT NULL
);

CREATE TABLE Veiculo (
/*Função: guarda infos. gerais sobre um veiculo da empresa(carga maxima em quilos, 
			numero máximo de containers, tipo do veículo, localização, unidade de origem, etc)*/
idVeiculo_PK INT PRIMARY KEY,
fabricante VARCHAR(20),
dataAquisicao DATE,

idTipoVeiculo_FK INT
);

CREATE TABLE Container (
/*Função: guarda infos. sobre um container da empresa(caracteristicas fisicas, 
			status, vida util em meses, lotação atual, etc)*/

idContainer_PK INT PRIMARY KEY,
dataAquisicao DATE,

/* Vida util em meses */
vidaUtil INT
);

CREATE TABLE Produto (
/*Função: guarda infos. sobre um produto que está sendo transportado(descrição, 
			caracteristicas fisicas, pedido a qual o produto pertence, etc)*/
idProduto_PK INT PRIMARY KEY,
descricao VARCHAR(500),
nome VARCHAR(100) unique
/*Chave estrangeira, indica qual pedido o produto pertence*/
);

CREATE TABLE Motorista (
idFuncionario_SPK INT UNIQUE NOT NULL PRIMARY KEY
);

CREATE TABLE Estoquista (
idFuncionario_SPK INT UNIQUE NOT NULL PRIMARY KEY
);

CREATE TABLE Pilota (
idMotorista_FK INT, 
idTipoVeiculo_FK INT,
PRIMARY KEY(idMotorista_FK, idTipoVeiculo_FK)
);

CREATE TABLE TransporteContainer (
    idTransporte_FK INT,
    idContainer_FK INT,
    PRIMARY KEY (idTransporte_FK, idContainer_FK)
);

CREATE TABLE Transporte (
/*Função: guarda info. de qual veiculo transporta qual container, e em qual data*/

id INT,

idRota_FK INT,

idAcidente_FK INT,

idVeiculo_FK INT,

idMotorista_FK INT,

dataInicio DATE,
dataFim DATE,

/*Impede que a data de inicio do tranporte seja posterior a data de termino*/
CONSTRAINT CHK_dataInicio
	CHECK(dataInicio <= dataFim),

PRIMARY KEY(id)
);

CREATE TABLE Cobre (
/*Função: guarda info. de qual segurado cobriu qual pedido e em qual tipo de acidente*/

/*Chave estrangeira, indica qual pedido foi o pedido coberto*/
idPedido_SPK INT,

/*Chave estrangeira, indica qual foi o tipo de acidente*/
idAcidente_SPK INT,

/*Chave estrangeira, indica qual a seguradora que cobriu o pedido*/
idSeguradora_SPK INT,

PRIMARY KEY(idPedido_SPK,idAcidente_SPK,idSeguradora_SPK)
);

CREATE TABLE Estoca (
/*Função: guarda info. de quando um container foi alocado e em qual lote.*/

dataEstoc DATETIME,

/*Chave estrangeira, indica em qual lote o container foi alocado*/
idLote_SPK INT,

/*Chave estrangeira, indica qual container está transportando*/
idContainer_SPK INT,

PRIMARY KEY(idLote_SPK,idContainer_SPK)
);

CREATE TABLE PedidoContainerProduto(
	idPedido INT,
    idContainer INT,
    idProduto INT,
    quantidade INT,
    
    PRIMARY KEY(idPedido, idContainer, idProduto)
);


/*_________________________DEFINIÇÃO DE CHAVES ESTRANGEIRAS_________________________________*/

/*Chaves estrangeiras da tabela PessoaFisica*/
ALTER TABLE PessoaFisica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK);

/*Chaves estrangeiras da tabela PessoaJuridica*/
ALTER TABLE PessoaJuridica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK);

/*Chaves estrangeiras da tabela Armazem*/
ALTER TABLE Armazem ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK);

/*Chaves estrangeiras da tabela Veiculo*/
ALTER TABLE Veiculo ADD FOREIGN KEY(idTipoVeiculo_FK) REFERENCES TipoVeiculo(id);

/*Chaves estrangeiras da tabela Cobre*/
ALTER TABLE Cobre ADD FOREIGN KEY(idPedido_SPK) REFERENCES Pedido(idPedido_PK);
ALTER TABLE Cobre ADD FOREIGN KEY(idAcidente_SPK) REFERENCES Acidente(idAcidente_PK);
ALTER TABLE Cobre ADD FOREIGN KEY(idSeguradora_SPK) REFERENCES Seguradora(idSeguradora_PK);

/*Chaves estrangeiras da tabela Pedido*/
ALTER TABLE Pedido ADD FOREIGN KEY(idCliente_FK) REFERENCES Cliente (idCliente_PK);
ALTER TABLE Pedido ADD FOREIGN KEY(idUnidadeOrigem_FK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Pedido ADD FOREIGN KEY(idUnidadeDestino_FK) REFERENCES Unidade (idUnidade_PK);


/*Chaves estrangeiras da tabela Rota*/
ALTER TABLE Rota ADD FOREIGN KEY(idUnidadeOrigem_SPK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Rota ADD FOREIGN KEY(idUnidadeDestino_SPK) REFERENCES Unidade (idUnidade_PK);

/*Chaves estrangeiras da tabela Funcionario*/
ALTER TABLE Funcionario ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK);

/*Chaves estrangeiras da tabela Lote*/
ALTER TABLE Lote ADD FOREIGN KEY(idArmazem_FK) REFERENCES Armazem (idArmazem_PK);

/*Chaves estrangeiras da tabela Motorista*/
ALTER TABLE Motorista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK);

ALTER TABLE Estoquista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK);


ALTER TABLE Pilota ADD foreign key (idMotorista_FK) REFERENCES Motorista (idFuncionario_SPK);
ALTER TABLE Pilota ADD foreign key (idTipoVeiculo_FK) REFERENCES TipoVeiculo (id);

/*Chaves estrangeiras da tabela Transporte*/
ALTER TABLE Transporte ADD FOREIGN KEY(idRota_FK) REFERENCES Rota (id);
ALTER TABLE Transporte ADD FOREIGN KEY(idAcidente_FK) REFERENCES Acidente (idAcidente_PK);
ALTER TABLE Transporte ADD FOREIGN KEY(idVeiculo_FK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Transporte ADD FOREIGN KEY(idMotorista_FK) REFERENCES Motorista (idFuncionario_SPK);



/*Chaves estrangeiras da tabela Transporte Container*/
ALTER TABLE TransporteContainer ADD foreign key(idTransporte_FK) references Transporte(id);
ALTER TABLE TransporteContainer ADD FOREIGN KEY(idContainer_FK) references Container(idContainer_PK);



/* 
================================== Populando o Banco de Dados ===========================
*/

insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (1, 83108184, 'emaudling0@webs.com', 'Emlyn Maudling', '22 Tennessee Junction', '2798678942');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (2, 37183203, 'gbeazer1@cam.ac.uk', 'Garald Beazer', '39829 Bunting Circle', '8051765396');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (3, 43896814, 'yspick2@posterous.com', 'Yettie Spick', '7 Westerfield Street', '8829909282');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (4, 25649381, 'esapauton3@cloudflare.com', 'Edee Sapauton', '10 Charing Cross Street', '8604534377');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (5, 77457947, 'rughi4@java.com', 'Richmound Ughi', '9 Jay Road', '8673124426');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (6, 27750592, 'phutcheon5@illinois.edu', 'Preston Hutcheon', '4 3rd Junction', '3654571232');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (7, 34849688, 'cbirdseye6@bing.com', 'Corrina Birdseye', '1 Stephen Street', '8064818857');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (8, 82523045, 'ijachimczak7@ebay.co.uk', 'Irving Jachimczak', '9 Coleman Court', '4054188536');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (9, 90625202, 'wvarrow8@webs.com', 'Whitney Varrow', '3597 Cardinal Pass', '6101164045');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (10, 93055668, 'keakins9@nydailynews.com', 'Kathe Eakins', '19937 Holy Cross Park', '3209087201');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (11, 65230485, 'asimmersa@drupal.org', 'Abba Simmers', '728 Autumn Leaf Court', '1817345215');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (12, 66854627, 'pnorleyb@ibm.com', 'Penn Norley', '9386 Fair Oaks Drive', '7306192315');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (13, 15499180, 'mmartelc@vimeo.com', 'Morissa Martel', '161 4th Circle', '9838998606');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (14, 86525872, 'tromerild@hexun.com', 'Tad Romeril', '626 Stang Crossing', '1193683937');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (15, 71475425, 'kknollesgreene@shutterfly.com', 'Kirsten Knolles-Green', '53 Old Shore Parkway', '4566570058');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (16, 61794903, 'echelleyf@icio.us', 'Eve Chelley', '54 Haas Road', '7536856601');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (17, 79367324, 'jcampeyg@jimdo.com', 'Juana Campey', '90302 Clemons Parkway', '8702819772');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (18, 93344329, 'rperassih@fda.gov', 'Reilly Perassi', '072 Onsgard Parkway', '4956121253');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (19, 17882454, 'tmaggiorii@fda.gov', 'Tine Maggiori', '16 Scott Avenue', '8256407048');
insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values (20, 65651657, 'nburnessj@cbslocal.com', 'Nobie Burness', '86 Montana Court', '3686211811');


insert into PessoaFisica (cpf, rg, idcliente_spk) values (12307464, 742823667, 1);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (12237248, 215650067, 2);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (98844830, 803770109, 3);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (78875560, 187983078, 4);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (84748551, 547885409, 5);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (42704120, 354806024, 6);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (56590045, 846890239, 7);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (31826044, 479107123, 8);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (62200017, 510210157, 9);
insert into PessoaFisica (cpf, rg, idcliente_spk) values (32540326, 608628049, 10);

insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (82846901343573, 'Teklist', 1);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (67679279091259, 'Dynazzy', 2);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (34341917482154, 'Jaxspan', 3);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (37551524565334, 'Fliptune', 4);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (82834446973393, 'Gabcube', 5);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (32661894370093, 'Skipstorm', 6);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (83755403712886, 'Quatz', 7);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (56148392097914, 'Vinte', 8);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (65386468514319, 'Fivechat', 9);
insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values (23351464466687, 'Myworks', 10);

insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (1, 'nboorne0@flickr.com', '8147 Warbler Lane', 81204605, '7372348838');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (2, 'stollfree1@g.co', '18242 Esker Court', 80281182, '1648938667');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (3, 'gpitbladdo2@facebook.com', '0 Tony Parkway', 76190888, '1858552526');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (4, 'csimison3@nytimes.com', '7 Clyde Gallagher Point', 96973511, '4029350484');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (5, 'whowen4@un.org', '0 7th Hill', 90425625, '5707773912');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (6, 'cgorick5@unesco.org', '889 Springview Plaza', 50997639, '3627130795');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (7, 'gdunckley6@desdev.cn', '40981 Holmberg Place', 29814403, '1444452139');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (8, 'llindegard7@flavors.me', '08523 Jenna Lane', 64003071, '5929202353');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (9, 'bsemor8@state.tx.us', '338 Lakewood Gardens Point', 60320590, '6497894737');
insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values (10, 'dwhales9@forbes.com', '78621 Carpenter Circle', 18034477, '2026672951');

insert into TipoVeiculo (id, nome, numMaxContainers) values 
(1, 'Caminhão', 1),
(2, 'Navio', 50),
(3, 'Trem', 20);

insert into Veiculo (idVeiculo_PK, fabricante, dataAquisicao, idTipoVeiculo_FK) values 
(1, 'Hermstron', '2018-03-01', 1),
(2, 'Toyota', '2018-03-01', 1),
(3, 'Nravetch', '2018-03-01', 2),
(4, 'Vrouka', '2018-03-01', 2),
(5, 'Pretchsok', '2018-03-01', 3),
(6, 'Trosti', '2018-03-01', 3)
;

insert into Acidente (idAcidente_PK,nome,descricao) values
(1, "Queda de Container", "Os containeres que estavam presentes no transporte sofreram uma queda e a carga provavelmente se encontra danificada."),
(2, "Acidente com Perda Total", "Todos os containeres presentes no veículo desse transporte sofreram perda total, nada poderá ser recuperado."),
(3, "Tombamento de Carga", "O veículo tombou e as cargas tem risco alto de ser danificado.")
;

insert into Pedido (idPedido_PK,dataEntrega,dataSolicitacao,idUnidadeOrigem_FK,idUnidadeDestino_FK,idCliente_FK)
values 
(1, '2018-04-01', '2018-03-05',1, 9, 1),
(2, '2019-06-18', '2019-03-15',2, 3, 3),
(3, '2019-06-18', '2019-03-15',7, 1, 4),
(4, '2019-06-17', '2019-03-16',5, 3, 1),
(5, '2019-04-18', '2019-03-15',8, 3, 1),
(6, '2019-02-18', '2019-01-10',4, 2, 1),
(7, '2019-06-18', '2019-03-15',7, 10, 1)
;

insert into Rota (id,idUnidadeOrigem_SPK,idUnidadeDestino_SPK,idTipoVeiculo_FK)
values
(1, 1, 10, 1),
(2, 10, 1, 1),
(3, 1, 5, 2),
(4, 5, 1, 2),
(5, 7, 9, 3),
(6, 9, 7, 3),
(7, 7, 9, 1),
(8, 9, 7, 1)
;

insert into Seguradora (idseguradora_pk, emailseguradora, cnpj, razaosocial, nome, telefone) values 
(1, 'rburdus0@sogou.com', 74840948902839, 'Plajo', 'Riffpedia', '6378410850'),
(2, 'jbrowne1@wunderground.com', 78232328093931, 'Jaloo', 'Topiczoom', '1715075024'),
(3, 'mblacksell2@buzzfeed.com', 42128383071301, 'Reallinks', 'Oyoba', '4125863691'),
(4, 'mheggison3@irs.gov', 15322184981194, 'Gigashots', 'Bluejam', '4038603080');


insert into Cobre (idPedido_SPK, idAcidente_SPK, idSeguradora_SPK) 
values
(1, 2, 4),
(3, 1, 3),
(4, 3, 4),
(5, 1, 2),
(6, 2, 1),
(6, 1, 3)
;

insert into Armazem (idArmazem_PK,idUnidade_FK) 
values
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 5),
(8, 6),
(9, 7),
(10, 8),
(11, 9),
(12, 10), 
(13, 7),
(14, 7)
;

insert into Container (idContainer_PK,dataAquisicao,vidaUtil) 
values
(1, "2018-03-13", 9),
(2, "2017-08-21", 11),
(3, "2019-11-17", 20),
(4, "2015-03-02", 14),
(5, "2018-05-12", 9),
(6, "2018-10-02", 9)
;

insert into Lote (idLote_PK,setor,posicao,idArmazem_FK) 
values
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 2, 1, 1),
(5, 2, 2, 1),
(6, 1, 1, 9),
(7, 1, 2, 9),
(8, 1, 3, 9),
(9, 2, 1, 9),
(10, 2, 2, 9),
(11, 1, 1, 13),
(12, 1, 2, 13),
(13, 1, 3, 13),
(14, 2, 1, 13),
(15, 2, 2, 13),
(16, 1, 1, 14),
(17, 1, 2, 14),
(18, 1, 3, 14),
(19, 2, 1, 14),
(20, 2, 2, 14),
(21, 1, 1, 2),
(22, 1, 2, 3),
(23, 1, 3, 2),
(24, 2, 1, 5),
(25, 2, 2, 6),
(26, 1, 1, 9),
(27, 1, 2, 8),
(28, 1, 3, 8),
(29, 2, 1, 7),
(30, 2, 2, 12),
(31, 1, 1, 8),
(32, 1, 2, 1),
(33, 1, 3, 13),
(34, 2, 1, 12),
(35, 2, 2, 11)
;

insert into Estoca (idLote_SPK, idContainer_SPK, dataEstoc) values
(6, 1, '2018-05-03'),
(7, 3, '2019-04-12'),
(8, 2, '2017-12-11'),
(9, 6, '2016-09-20'),
(10, 5, '2018-07-28'),
(11, 2, '2018-08-23'),
(13, 4, '2018-05-03'),
(15, 1, '2020-01-04'),
(18, 5, '2018-05-03'),
(19, 4, '2018-05-13'),
(20, 4, '2019-05-20'),
(20, 2, '2018-04-30');


insert into Produto(idProduto_PK,nome,descricao)
values
(1, "Açúcar", "Saco de açúcar refinado."),
(2, "Mel", "Caixa de mel."),
(3, "Ferro", "Caixa com lingote de ferro" ),
(4, "Alumínio", "Caixa com lingotes de alumínio")
;

insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (1, 'lwillison0@w3.org', '2018-09-25', 16274.14, '264 Forest Run Alley', 135877144, '6464702056', '1980-03-27', 5);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (2, 'slapides1@businessinsider.com', '2018-07-09', 4389.27, '63188 Kedzie Road', 812245976, '1549713000', '1965-05-10', 3);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (3, 'bfieldhouse2@free.fr', '2018-10-12', 23654.59, '788 Dahle Circle', 177090584, '2294651044', '1986-08-29', 7);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (4, 'fhammerberg3@ca.gov', '2018-10-10', 9003.81, '3 Morningstar Parkway', 973045443, '5327210544', '1994-02-09', 2);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (5, 'mfiloniere4@foxnews.com', '2019-04-13', 10992.45, '37 Katie Circle', 732246387, '8996112700', '1971-09-05', 10);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (6, 'crymell5@a8.net', '2019-05-24', 14234.83, '36 Di Loreto Trail', 525968466, '2266406801', '1963-12-03', 9);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (7, 'sclimson6@deviantart.com', '2018-07-06', 27031.78, '13795 Warbler Plaza', 287719102, '4635946567', '1973-12-08', 2);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (8, 'eblaik7@timesonline.co.uk', '2018-10-02', 1829.11, '9 Lien Hill', 879864547, '8334420036', '1997-03-03', 3);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (9, 'emccrudden8@yale.edu', '2018-11-20', 29089.63, '5127 Acker Lane', 174585761, '9284135882', '1995-12-13', 10);
insert into Funcionario (idfuncionario_pk, emailfuncionario, datacontratacao, salario, endereco, rg, telefone, datanascimento, idunidade_fk) values (10, 'kfarrington9@arizona.edu', '2018-11-14', 18916.29, '458 Blackbird Plaza', 148242594, '4552305297', '1992-02-26', 5);

insert into Motorista (idFuncionario_SPK)
values 
(2), 
(4), 
(5),
(10),
(9),
(1)
;

insert into Estoquista (idFuncionario_SPK)
values 
(3), 
(6), 
(7),
(8)
;


insert into Pilota (idMotorista_FK, idTipoVeiculo_FK)
values
(2, 1), 
(4, 2), 
(5, 3),
(10, 1),
(9, 1),
(1, 2),
(1, 3),
(1, 1)
;

insert into PedidoContainerProduto (idProduto,idContainer,quantidade, idPedido)
values
(1, 1, 20, 1),
(2, 1, 10, 1),
(3, 2, 20, 1),
(4, 3, 15, 2),
(4, 2, 5, 1),
(3, 2, 7, 3)
;


insert into Transporte (id,idRota_FK,idAcidente_FK,idVeiculo_FK,idMotorista_FK,dataInicio,dataFim)
values
(1, 8, 2, 1, 2, "2018-05-01", "2018-05-03"),
(2, 6, null, 5, 5, "2019-06-04", "2019-06-07"),
(3, 6, null, 6, 1, "2019-01-02", "2019-01-03"),
(4, 3, 2, 3, 4, "2019-06-11", "2019-06-13"),
(5, 7, null, 2, 10, "2019-04-30", "2019-05-02"),
(6, 6, 2, 5, 5, "2020-06-04", "2020-06-07"),
(7, 7, 1, 2, 10, "2019-05-13", "2019-05-16"),
(8, 8, 3, 1, 2, "2021-05-01", "2021-05-03")
;

insert into TransporteContainer (idTransporte_FK, idContainer_FK)
values
(1, 1),
(2, 3),
(2, 4),
(3, 5)
;


/*
 ============================================== Definindo as consultas ======================
*/

/*
Selecionar todos os motoristas que pilotam são capazes de pilotar todos os veículos

Atende: cláusula IN, EXISTS, divisão e pelo menos 3 tabelas
*/

select idFuncionario_SPK from Motorista as M where not exists (
	select id from TipoVeiculo as TV where id not in (
		select idTipoVeiculo_FK from Pilota as P 
        where 
        TV.id = P.idTipoVeiculo_FK and 
        M.idFuncionario_SPK = P.idMotorista_FK
    )
);

/*
As operações INTERSECT e MINUS não existem no MySQL e são comumente substituídas por IN e NOT IN respectivamente.
Usaremos então a função UNION

O RH para fins de pesquisa precisa do email de 2 funcionários para cada faixa salarial.
Listar, no máximo 2 emails de funcionários para cada uma das três faixas salariais acompanhado de sua faixa salarial

Atende: Union
*/

(SELECT emailFuncionario, 1 as FaixaSalarial from Funcionario where salario BETWEEN 1000 and 10000 limit 2) 
UNION
(SELECT emailFuncionario, 2 as FaixaSalarial from Funcionario where salario BETWEEN 10001 and 20000 limit 2)
UNION
(SELECT emailFuncionario, 3 as FaixaSalarial from Funcionario where salario BETWEEN 20001 and 30000 limit 2);


/*
Liste todas as unidades que possuem gastos com funcionarios superior a 10 mil.

Para essas unidades deve ser exibido o gasto total

Como a métrica de qualidade de uma unidade é exatamente o número de transportes que partem daquela unidade,
retorne também o número de transportes que partiram daquela unidade

Atende: função de agregação, cláusula group by, having e pelo menos 3 tabelas.
*/
SELECT SQ1.idUnidade_PK as 'Id Unidade', concat('R$', round(SQ1.GT, 2)) as 'Gasto Total', count(SQ2.idTransporte) as 'Número de Partidas' from
(
SELECT U.idUnidade_PK, sum(F.salario) as GT from Unidade as U 
	left join Funcionario as F on
		F.idUnidade_FK = U.idUnidade_PK
	group by U.idUnidade_PK
   	having sum(F.salario) >= 10000

) as SQ1 LEFT JOIN
(
SELECT T.id as idTransporte, R.idUnidadeOrigem_SPK from Transporte as T
	inner join Rota as R on
		R.id = T.idRota_FK
) as SQ2 on
SQ2.idUnidadeOrigem_SPK = SQ1.idUnidade_PK
group by SQ1.idUnidade_PK, SQ1.GT
;



/*
Listar todos os pedidos que sofreram um acidente

*/

select distinct P.idPedido_PK from Pedido as P
	inner join PedidoContainerProduto as PCP on
		PCP.idPedido = P.idPedido_PK
	inner join TransporteContainer as TC on
		TC.idContainer_FK = PCP.idContainer
	inner join Transporte as T on
		T.id = TC.idTransporte_FK
        
	where T.idAcidente_FK is not null;


/*
Dada a chegada do transporte de ID 1 na sua unidade de destino, liste  a localização de 
todos os lotes disponíveis nessa data
*/

select concat('Armazém ', idArmazem_PK, ', setor ', setor, ', posição ', posicao) as 'Localização' from
(select R.idUnidadeDestino_SPK as 'Unidade', dataFim from Transporte as T 
	left join Rota as R 
		on R.id = T.idRota_FK
where T.id = 1) as SQ1
	left join Armazem as A on
		A.idUnidade_FK = SQ1.Unidade
	left join Lote as L on
		L.idArmazem_FK = A.idArmazem_PK
	left join Estoca as E on
		E.idLote_SPK = L.idLote_PK
	where E.dataEstoc <> SQ1.dataFim
;

/*
Listar a quantidade de lotes que existem em cada uma das unidades. (Lembrando que cada unidade possui
vários Armazéns e os Armazéns possuem vários lotes)

*/
select U.idUnidade_PK as Unidade , count(L.idLote_PK) as 'Total de Lotes' from Unidade as U 
	left join Armazem as A on
		A.idUnidade_FK = U.idUnidade_PK
	inner join Lote as L on
		L.idArmazem_FK = A.idArmazem_PK
	group by U.idUnidade_PK
;

/*
Listar, para cada acidente, o nome e o total de vezes que ele foi coberto e o total de vezes que ele ocorreu	
*/

select nome, Ocorridos, count(idAcidente_PK) as Cobertos from
	(select A.idAcidente_PK, A.nome, count(T.id) as Ocorridos from Acidente as A 
		left join Transporte as T 
			on A.idAcidente_PK = T.idAcidente_FK 
		group by A.nome, A.idAcidente_PK) as SQ1 
		left join Cobre as C
			on SQ1.idAcidente_PK = C.idAcidente_SPK 
		group by nome, Ocorridos
;


/* ========================PROCEDURES===========================  */

/*
 Procedimento que envolva a criação e o povoamento de uma (ou mais) nova(s) tabela(s);
*/
DELIMITER $$
CREATE PROCEDURE INSERE_REALTORIO_MENSAL(in in_mes VARCHAR(30), in in_lucro FLOAT)
BEGIN
	start transaction;
    /*Caso ainda não tenham criado a tabela de relatório então crie*/
	CREATE TABLE IF NOT EXISTS Relatorio_Mensal (
		lucro FLOAT,
		mes VARCHAR(30)
	);
    
    insert into Relatorio_Mensal(mes, lucro)  values (in_mes, in_lucro);
	commit;

END $$
DELIMITER ;

#call INSERE_REALTORIO_MENSAL('Abril', 10000);


/*
	Aumentar o salário dos motoristas que pilotam todo tipo de veículo
*/

DELIMITER $$
CREATE PROCEDURE AUMENTA_SALARIO_MELHORES_MOTORISTAS(in salario_novo FLOAT)
BEGIN
	start transaction;
	
    update Funcionario set salario = salario_novo
		where idFuncionario_PK in 
		(
			select idFuncionario_SPK from Motorista as M where not exists (
				select id from TipoVeiculo as TV where id not in (
					select idTipoVeiculo_FK from Pilota as P 
					where 
					TV.id = P.idTipoVeiculo_FK and 
					M.idFuncionario_SPK = P.idMotorista_FK
				)
            )
		);

	
	commit;

END $$
DELIMITER ;

#call AUMENTA_SALARIO_MELHORES_MOTORISTAS(100000);


/*
 =============================VIEWS============================
*/
DROP VIEW IF EXISTS VW_VeiculosLivre;
CREATE VIEW VW_VeiculosLivre AS 
	select idVeiculo_PK as 'Código', fabricante as 'Fabricante', dataAquisicao from Veiculo
		where idVeiculo_PK not in 
        (
			select idVeiculo_FK from Transporte
		)
;


/*View para listar os funcionários e o seu salário*/        
DROP VIEW IF EXISTS VW_salarioFuncionarioPorUnidade;
CREATE VIEW VW_salarioFuncionarioPorUnidade AS select u.idUnidade_PK AS 'idUnidade',
    u.cep,f.emailFuncionario,f.salario,f.telefone from Unidade u right join Funcionario f on 
        f.idUnidade_FK = u.idUnidade_PK order by u.idUnidade_PK
;


/*View para fazer uma síntese das contratações de planos das seguradoras*/
DROP VIEW IF EXISTS VW_seguradorasContradas;
CREATE VIEW VW_seguradorasContradas AS
select S.razaoSocial as 'Seguradora', S.telefone as 'Telefone', S.emailSeguradora as 'Email', A.nome as 'Acidente Coberto' , count(A.idAcidente_PK) as 'Número de Contrações' from Seguradora as S 
	inner join Cobre as C on
		S.idSeguradora_PK = C.idSeguradora_SPK
	inner join Acidente as A on
		A.idAcidente_PK = C.idAcidente_SPK
	group by S.razaoSocial, S.telefone, S.emailSeguradora, A.nome 
;


/*View para sumarizar os gastos gerados por cada unidade*/
DROP VIEW IF EXISTS VW_gastoUnidades;
CREATE VIEW VW_gastoUnidades AS

SELECT SQ1.idUnidade_PK as 'Id Unidade', concat('R$', round(SQ1.GT, 2)) as 'Gasto Total', count(SQ2.idTransporte) as 'Número de Partidas' from
(
SELECT U.idUnidade_PK, sum(F.salario) as GT from Unidade as U 
	left join Funcionario as F on
		F.idUnidade_FK = U.idUnidade_PK
	group by U.idUnidade_PK
   	having sum(F.salario) >= 10000

) as SQ1 LEFT JOIN
(
SELECT T.id as idTransporte, R.idUnidadeOrigem_SPK from Transporte as T
	inner join Rota as R on
		R.id = T.idRota_FK
) as SQ2 on
SQ2.idUnidadeOrigem_SPK = SQ1.idUnidade_PK
group by SQ1.idUnidade_PK, SQ1.GT
;


/*

=========================PERMISSIONAMENTO=========================
*/


CREATE USER IF NOT EXISTS 'GerenteTesouraria'@'localhost' IDENTIFIED BY 'GerenteTesouraria';
CREATE USER IF NOT EXISTS 'AnalistaTesouraria'@'localhost' IDENTIFIED BY 'AnalistaTesouraria';
CREATE USER IF NOT EXISTS 'ConsultorTesouraria'@'localhost' IDENTIFIED BY 'ConsultorTesouraria';

CREATE USER IF NOT EXISTS 'ManutencaoVeiculos'@'localhost' IDENTIFIED BY 'ManutencaoVeiculos';

CREATE USER IF NOT EXISTS 'RH'@'localhost' IDENTIFIED BY 'RH';

/* A nossa versão do MYSQL não tinha roles, por isso não conseguimos garantir permissões por Papeis */

grant select on VW_salarioFuncionarioPorUnidade to 'RH'@'localhost';

grant select on VW_VeiculosLivre to 'ManutencaoVeiculos'@'localhost';


grant select on VW_gastoUnidades to 'GerenteTesouraria'@'localhost';
grant select on VW_gastoUnidades to 'AnalistaTesouraria'@'localhost';
grant select on VW_gastoUnidades to 'ConsultorTesouraria'@'localhost';


grant select on VW_seguradorasContradas to 'GerenteTesouraria'@'localhost';
grant select on VW_seguradorasContradas to 'AnalistaTesouraria'@'localhost';
grant select on VW_seguradorasContradas to 'ConsultorTesouraria'@'localhost';

