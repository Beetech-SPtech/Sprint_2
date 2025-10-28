/*
DAVI VITAL DO PRADO VICENTE PEREIRA - RA: 01252033
JORGE LUIZ CARDOSO DE SIQUEIRA - RA: 01252082
LEONARDO TOMAS FEITOSA DA SILVA - RA: 01252013
MARCOS LOPIS PEREIRA - RA: 01252034
TIAGO DA SILVA SANTOS - RA: 01252133
WAGNER REIS SILVA BRONSTEIN - RA: 01252090
*/


create database Beetech;
use Beetech;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    responsavel VARCHAR(40),
    nomeEmpresa VARCHAR(150),
    cnpj CHAR(18) UNIQUE,
    telFixo CHAR (13),
    telCelular CHAR(14),
    email VARCHAR (45)
);

INSERT INTO empresa (responsavel, nomeEmpresa, cnpj, telFixo, telCelular, email) VALUES
('Jorge Weasley', 'Gemialidade Weasley', '00.000.000/0001-00', '(11)1111-1111', '(11)91111-1111','Jorge.Wealey@outlook.com'),
('Harry Potter', 'PotterChad','11.111.111/0001-00', '(11)2222-2222', '(11)92222-2222','PotterChad@gmail.com'),
('Hermione Granger', 'Sangue Ruim', '22.222.222/0001-00', '(11)4242-5640', '(11)94002-8922', 'Granger.Hermione@Yahoo.com');

select * from empresa;

CREATE TABLE usuarios (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
    sobrenome VARCHAR(50),
    email VARCHAR(70),
    dtNasc DATE,
    telCelular char(14),
    senha VARCHAR(60),
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nivelUser CHAR(3),
    fkEmpresa INT,
		CONSTRAINT fkDaEmpresa
			FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa)
);

INSERT INTO usuarios (nome, sobrenome, email, dtNasc, telCelular, dtCadastro, nivelUser, fkEmpresa) VALUES
('Gandalf','O Branco', 'GandalfMago@hotmail.com', '2001-02-05', '(11)93333-3333', default, 3, 1),
('Bilbo', 'Bolseiro', 'BilboHobbit@sptech.school', '2004-03-27', '(11)94444-4444', default, 2, 2),
('Aragorn', 'Rei de Gondor', 'AragornBrabo@icloud.com', '2001-02-12', '(11)95555-5555', default, 1,3);

select * from usuarios;

CREATE TABLE enderecos(
	idEnderecos INT PRIMARY KEY AUTO_INCREMENT,
	logradouro VARCHAR(90),
    numLogradouro INT,
    cidade VARCHAR (80),
    UF CHAR (2),
    cep CHAR(9),
    bairro VARCHAR(40),
    complemento VARCHAR (50),
    statusEndereco VARCHAR(10),
    fkEmpresa INT,
		CONSTRAINT fkDoEnderecoEmpresa
			FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa),
		CONSTRAINT chkStatus 
			CHECK(statusEndereco IN
				('Livre', 'Ocupado'))
);

INSERT INTO enderecos (logradouro, numLogradouro, cidade, UF, cep, bairro, statusEndereco, fkEmpresa) VALUES
('Rua Altobeni', 737, 'SãoPaulo', 'SP', '08421-130', 'Vila Cosmopolita', 'Livre', 1),
('Rua Mario João Bampa', 71, 'Jundia', 'SP', '08431-120', 'Vila Comercial', 'Ocupado', 2),
('Rua Wilson Fernando S de Carvalho', 480, 'São Paulo', 'SP', '08411-320', 'Barro Branco', 'Livre', 3);

select * from enderecos;

CREATE TABLE colmeia (
	idColmeia INT,
	qtdNinho INT,
	qtdMelgueira INT,
    qtdRainha INT,
    largura FLOAT,
    altura FLOAT,
    comprimento FLOAT,
    fkEmpresa INT,
		CONSTRAINT fkDaColmeiaEmpresa
			FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa),
	PRIMARY KEY (idColmeia, fkEmpresa)
); 

INSERT INTO colmeia (idColmeia, fkEmpresa, qtdNinho, qtdMelgueira, qtdRainha, largura, altura, comprimento) VALUES
(1,1, 20, 30, 60, 13.2, 13.2, 10.5),
(1,2, 30, 20, 70, 20.4, 17.8, 16.5),
(1,3, 60, 24, 50, 8.6, 12.3, 6.4);

select * from colmeia;

CREATE TABLE producaoTotal (
	idProducao INT PRIMARY KEY auto_increment,
	melKg DECIMAL (7,2),
    valorMel DECIMAL (7,2),
    dtCriacao DATETIME,
    fkEmpresa INT,
    fkColmeia INT,
    CONSTRAINT fkColmeiaProducao
		FOREIGN KEY (fkColmeia, fkEmpresa)
			REFERENCES colmeia(idColmeia, fkEmpresa)
);

INSERT INTO producaoTotal (melKg, valorMel, dtCriacao, fkColmeia, fkEmpresa) VALUES
(12.50, 320.00, default, 1, 1),
(15.80, 400.00, default, 1, 2),
(10.25, 270.00, default, 1, 3);

select * from producaoTotal;

CREATE TABLE sensores (
	idSensor INT PRIMARY KEY,
    nomeSensor VARCHAR(50),
    lugar VARCHAR(45),
    descricao VARCHAR(100),
    statusSensor VARCHAR(40),
    fkEmpresa INT, 
		CONSTRAINT fkDaCOmeiaEmpresa
			FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa),
    fkColmeia INT,
		CONSTRAINT fkDaColmeia
			FOREIGN KEY (fkColmeia, fkEmpresa)
				REFERENCES colmeia(idColmeia, fkEMpresa),
		CONSTRAINT checkStatusSensor check(statusSensor in('Ativo', 'Inativo')),
	CONSTRAINT fkColmeiaProducaoEmpresa
		FOREIGN KEY (fkColmeia, fkEmpresa)
			REFERENCES colmeia(idColmeia, fkEmpresa)
);

INSERT INTO sensores (idSensor, nomeSensor, lugar, descricao, statusSensor, fkColmeia, fkEmpresa) VALUES 
(1, 'Sensor1', 'Ninho', 'Mede a temperatura interna da colmeia', 'Ativo', 1, 1),
(2, 'Sensor2', 'Melgueira', 'Mede a temperatura interna da colmeia', 'Ativo', 1, 2),
(3, 'Sensor3', 'Base', 'Mede a temperatura interna da colmeia', 'Inativo', 1, 3);

select * from sensores;

CREATE TABLE registroSensor(
	idREgistroSensor INT PRIMARY KEY AUTO_INCREMENT,
	valorTemp DECIMAL (4,2),
    dtTemp DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensores INT,
		CONSTRAINT fkDoSensor
			FOREIGN KEY (fkSensores)
				REFERENCES sensores(idSensor)
);

INSERT INTO registroSensor (valorTemp, dtTemp, fkSensores) VALUES
(35.50, default, 1),
(36.20, default, 2),
(10.25, default, 3);

select * from registroSensor;

CREATE TABLE contato (
	idContato INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    sobrenome VARCHAR(45),
    email VARCHAR(45),
    telCelular CHAR(14),
    empresa VARCHAR(100),
    cnpj CHAR(18),
    cargo VARCHAR(40),
    comentario VARCHAR(500)
);

select responsavel as Responsavel,
	   nomeEmpresa as NomeFantasia,
       empresa.email as EmailContato,
       usuarios.nome as NomeUsuario,
       usuarios.sobrenome as Titulo,
       usuarios.email as EmailUsuario
       from empresa join usuarios
       on idEmpresa = fkEmpresa;
       
select responsavel as Responsavel,
	   nomeEmpresa as 'Nome Fantasia',
       empresa.email as 'Email de Contato',
       usuarios.nome as 'Nome Úsuario',
       usuarios.sobrenome as Título,
       usuarios.email as 'Email Úsuario', 
       Case when responsavel = 'Jorge Weasley' then 'PotterHead né?' end as 'Fã'
       from empresa join usuarios
       on idEmpresa = fkEmpresa
       where nomeEmpresa like 'G%';

select responsavel as Responsavel,
	   nomeEmpresa as 'Nome Fantasia',
       empresa.email as 'Email Contato',
       usuarios.nome as 'Nome do Usuario',
       usuarios.sobrenome as Titulo,
       usuarios.email as 'Email Usuario'
       from empresa join usuarios
       on idEmpresa = fkEmpresa
       where nomeEmpresa like 'G%';

select nomeEmpresa as 'Nome Fantasia',
	   empresa.email as 'Email de Contato',
       colmeia.qtdNinho as 'Quantidade de Ninhos',
       colmeia.qtdRainha as 'Quantidade de Rainhas'
       from empresa join colmeia
	   on idEmpresa = fkEmpresa;

select sensores.nomeSensor as 'Nome do Sensor',
	   sensores.descricao as 'Descrição',
       sensores.statusSensor as 'Status do Sensor',
       registroSensor.valorTemp as 'Valor da Temperatura'
       from sensores join registroSensor
       on idSensor = fkSensores;
       
drop database Beetech;