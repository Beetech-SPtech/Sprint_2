/* NOMES: LESLEY DE OLIVEIRA - RA: 01252075
		  GUSTAVO RUCAGLIA BOZETTI SANTIAGO - RA: 01252040
          JOSUÉ ALVAREZ AVENDANO - RA: 01252002
		  RAFAEL PRAZERES CALDERON - RA: 01252126
          TIAGO DA SILVA SANTOS - RA: 01252133
          VICTOR RAFAEL LOURENÇO OLIVEIRA - RA: 01252058 
*/

-- Criação do banco de dados
create database projetoPIA;

-- Seleção do banco de dados
use projetoPIA;

-- Criação da tabela 'usuarios' com suas respectivas colunas e restrições
create table usuarios(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
sobrenome VARCHAR(50) NOT NULL, 
email VARCHAR(70) NOT NULL UNIQUE,
dtNascimento DATE NOT NULL,
telCelular VARCHAR (13) UNIQUE,
telFixo VARCHAR(10) UNIQUE,
senha VARCHAR(60) NOT NULL,
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
nivelUsuario CHAR(3), 
CONSTRAINT chkCargo CHECK( nivelUsuario IN('ADM', 'SUB'))
);

-- Inserção de registros na tabela
INSERT INTO usuarios(nome, sobrenome, email, dtNascimento, telCelular, senha, nivelUsuario) VALUES
	('Josué', 'Alvarez Avendano', 'josue.avendano@rancho.maia', '2000-02-02', '11960181191', 'J0su3!12th3', 'SUB'),
    ('Rafael', 'Prazeres Calderon', 'rafael.calderon@nagro.valley', '2007-02-23', '11948353845', 'R4f4!12ol', 'SUB'),
    ('Lesly', 'Oliveira', 'lesly.oliveira@bee.tec', '2004-06-21', '11961692152', 'K0l3s_3r', 'SUB'),
    ('Cláudio', 'Frizzarini', 'claudio.frizzarini@pedro.colmeia', '1968-05-20', '11932841827', 'fr1zz0l_', 'SUB'),
    ('Victor', 'Oliveira', 'victor.oliveira@rancho.maia', '2004-11-20', '11984739532', 'V!ctor_23', 'ADM'),
    ('Thais', 'Miranda', 'thais.miranda@nagro.valley', '1999-02-28', '62998570998', 'b1n4r1_t4bl3', 'ADM'),
    ('Guilherme', 'Lima', 'guilherme.lima@bee.tech', '1978-12-04', '62903843945', '#gu1_Lim4', 'ADM'),
    ('Pedro', 'Cardoso', 'pedro.cardoso@pedro.colmeia', '1971-04-07', '86978420913', 'pedroFarm_$', 'ADM');

-- Seleção de todos os registros contidos na tabela
SELECT * FROM usuarios;

-- Seleção do nome completo dos usuários (nome e sobrenome), com apelido de 'Nome Completo'
SELECT CONCAT(nome, ' ', sobrenome) AS 'Nome Completo' FROM usuarios;

-- Exibição dos nomes e emails com alias, além da identificação da empresa como 'Parceiras' se o e-mail contiver '@'
SELECT nome AS 'Nome do Usuário', email AS 'Email Corporativo', 
CASE 
WHEN email LIKE '%@%' THEN 'Parceiras' END AS 'Empresas' 
FROM usuarios;

-- Alteração no tamanho da coluna 'email' para 80 caractéres totais
ALTER TABLE usuarios MODIFY COLUMN email VARCHAR(80);

-- Exibição da estrutura dentro da tabela
DESCRIBE usuarios;

-- Atualização do nome do usuário com ID igual a 1
UPDATE usuarios SET nome = 'Matheus' WHERE idUsuario = 1;

-- Seleção apenas da coluna 'nome', com alias 'Nomes'
SELECT nome as Nomes FROM usuarios;
/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'empresa' armazenando informações de empresas parceiras
CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
responsavel VARCHAR(40) NOT NULL,
nomeEmpresa VARCHAR(150) NOT NULL,
cnpj CHAR(18),
telFixo VARCHAR(12) UNIQUE,
telCelular VARCHAR(13) UNIQUE
);

-- Inserção de registros na tabela
INSERT INTO empresa (responsavel, nomeEmpresa, cnpj, telCelular) VALUES
('Victor Rafael', 'Rancho do Maia', '20.000.258/0001-03', '1123750853'),
('Thais Lima', 'Nagro Valley', '16.465.514/0001-52' ,'6274859048'),
('Guilherme Jesus', 'BeeTec', '47.287.021/0001-01' ,'6274890985'),
('Pedro Henrique', 'Fazenda Pedro da Colmeia', '76.168.937/0001-32' ,'8674830941');

SELECT nomeEmpresa, telCelular, CASE 
		WHEN telCelular LIKE '11%' THEN 'DDD 11 - São Paulo'
        WHEN telCelular LIKE '21%' THEN 'DDD 21 - Rio de Janeiro'
        WHEN telCelular LIKE '31%' THEN 'DDD 31 - Minas Gerais'
        WHEN telCelular LIKE '41%' THEN 'DDD 28 - Espírio Santo'
ELSE 'Outro DDD' END AS 'Região' FROM empresa;

SELECT nomeEmpresa, telCelular, CASE WHEN telCelular IS NULL THEN 'Sem celular'
ELSE 'Celular cadastrado' END AS 'Situação' FROM empresa;
/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'contato' armazenando mensagens e dados de contato de interessados
CREATE TABLE contato(
idContato INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (50) NOT NULL,
sobrenome VARCHAR (50) NOT NULL,
email VARCHAR (70) NOT NULL,
telFixo CHAR (12),
telCelular CHAR (13) NOT NULL,
empresa VARCHAR (100) NOT NULL,
cnpj CHAR (18) NOT NULL,
cargo VARCHAR(40) NOT NULL,
comentario VARCHAR(500) NOT NULL
);

-- Inserção de registros na tabela
INSERT INTO contato (nome, sobrenome, email, telCelular, empresa, cnpj, cargo, comentario) VALUES
('Victor', 'Oliveira', 'victor.oliveira@rancho.maia', '11984739532', 'Rancho do Maia', '22.245.445/0001-45' ,'ADM', 
'Sou produtor de médio porte e percebo que, em dias de calor intenso, minhas colmeias sofrem bastante. 
Gostaria de entender se o seu sistema poderia me ajudar a monitorar melhor essas variações e evitar perdas de abelhas.'),

('Thais', 'Miranda', 'thais.miranda@nagro.valley', '62998570998', 'Nagro Valley', '23.542.882/0001-52' ,'ADM', 
'Tenho várias colmeias distribuídas em diferentes apiários e a distância dificulta o acompanhamento constante. 
Vi que seu sistema pode registrar os dados remotamente, e isso me interessou muito.'),

('Guilherme', 'Lima', 'guilherme.lima@bee.tech', '62903843945', 'BeeTec', '81.523.238/0001-01', 'ADM', 
'Nos últimos anos perdi parte da produção por conta de problemas relacionados à temperatura dentro da colmeia. 
Se o seu sistema realmente ajudar a acompanhar isso em tempo real, pode ser uma ótima ferramenta para o meu trabalho.'),

('Pedro', 'Cardoso', 'pedro.cardoso@pedro.colmeia', '86978420913', 'Fazenda Pedro da Colmeia', '64.705.559/0001-08', 'ADM', 
'Aqui na minha propiedade alugamos colmeias para polinização de lavouras vizinhas. 
Saber que existe um sistema que pode monitorar a saúde térmica das colmeias me deixa animado, 
pois garante mais segurança na hora de disponibilizar as abelhas.');

-- Exibição de todos os contatos registrados
SELECT * FROM contato;

-- Exibição específica para o contato com idContato igual a 4, exibindo nome completo, e-mail e comentário, com apelidos semânticos no campos
SELECT CONCAT(nome, sobrenome) AS Nome, email AS 'Email do Usuário', comentario AS 'Comentário' FROM contato WHERE idContato = 4; 
/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'registroSensor', armazenando registros de temperatura capturados por sensores
CREATE TABLE registroSensor(
idRegistroSensor INT PRIMARY KEY AUTO_INCREMENT,
sensor VARCHAR(14),
qtdTemperatura DECIMAL(4, 2),
dtTemperatura DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserção de registros de temperatura para os sensores em determinado horário
INSERT INTO registroSensor (sensor, qtdTemperatura) VALUES
('Sensor_001', 34.43),
('Sensor_002', 35.99),
('Sensor_003', 35.44),
('Sensor_004', 37.25);

-- Inserção de registros de temperatura para os sensores em outro determinado horário
INSERT INTO registroSensor (sensor, qtdTemperatura) VALUES
('Sensor_001', 34.23),
('Sensor_002', 35.29),
('Sensor_003', 35.74),
('Sensor_004', 34.25);

-- Exibição de todos os registros do sensor 'Sensor_001'
SELECT * FROM registroSensor WHERE sensor = 'Sensor_001';

SELECT CASE WHEN qtdTemperatura > 36 THEN CONCAT('Temperatura Elevada: ', qtdTemperatura) END FROM registroSensor;
/* ------------------------------------------------------------------------------------------------------- */

-- Criação da tabela 'sensores', armazenando informações sobre sensores utilizados pelos clientes
CREATE TABLE sensores(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nomeSensor VARCHAR(10),
cliente VARCHAR(50)
);

-- Inserção de dados na tabela
INSERT INTO sensores (nomeSensor, cliente) VALUES
('Sensor_001', 'Nagro Valley'),
('Sensor_002', 'Rancho do Maia'),
('Sensor_003', 'BeeTec'),
('Sensor_004', 'Fazenda Pedro da Colmeia');

-- Seleção de todos os dados dentro da tabela
SELECT * FROM sensores;

SELECT idSensor, nomeSensor, cliente, CASE WHEN cliente LIKE '%Fazenda%' THEN 'Alta prioridade'
ELSE 'Normal' END AS prioridade FROM sensores ORDER BY prioridade;
/* ------------------------------------------------------------------------------------------------------- */


-- Criação da tabela 'producaoTotal' com campos para registro de produção de mel
CREATE TABLE producaoTotal(
idProducao INT PRIMARY KEY AUTO_INCREMENT,
melKg DECIMAL(7, 2) NOT NULL,
qtdColmeia INT NOT NULL,
temperaturaMedia DECIMAL(4, 2) NOT NULL,
valorMel DECIMAL(7, 2),
dtCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
cnpj VARCHAR(18)
)AUTO_INCREMENT = 1000;

-- Inserção de registros na tabela
INSERT INTO producaoTotal (melKg, qtdColmeia, temperaturaMedia, valorMel) VALUES
(12502.87, 87, 34.87, 3600.00),
(9875.09, 71, 34.99, 2850.00),
(15029.11, 94, 36.43, 6700.85),
(14500.94, 58, 35.76, 1400.90);

-- Seleção de todos os registros da tabela
SELECT * FROM producaoTotal;

-- Exibição da quantidade de colmeias e da temperatura, caso a temperatura seja maior que 36°C
SELECT qtdColmeia AS 'Quantidade de Colmeias', 
CASE WHEN temperaturaMedia > 36 
THEN CONCAT('Alta Temperatura', ' - ', temperaturaMedia, '°C') 
END AS 'Temperatura' 
FROM producaoTotal;

-- Exibição da quantidade de colmeias, mel produzido em KG e valor do mel, com apelidos semânticos
SELECT qtdColmeia AS 'Quantidade de Colmeias', melKg AS 'Mel Por Quilo', valorMel AS 'Preço do Mel' FROM  producaoTotal;
/* ------------------------------------------------------------------------------------------------------- */

CREATE TABLE enderecos(
	idEnderecos INT PRIMARY KEY AUTO_INCREMENT,
	cnpj CHAR(18),
	logradouro VARCHAR (90) NOT NULL,
	numLogradouro VARCHAR(10) NOT NULL,
	cidade VARCHAR(80) NOT NULL,
	UF CHAR(2) NOT NULL,
	cep CHAR (9) NOT NULL,
    bairro VARCHAR(40),
    complemento VARCHAR(50),
    statusEndereco VARCHAR(10) DEFAULT 'Ativo',
    CONSTRAINT chkEndereco CHECK( statusEndereco IN('Ativo', 'Inativo'))
);

INSERT INTO enderecos (cnpj, logradouro, numLogradouro, cidade, UF, cep, bairro, complemento, statusEndereco) VALUES
('12.345.678/0001-90', 'Avenida Paulista', '1000', 'São Paulo', 'SP', '01310-100', 'Bela Vista', 'Conjunto 101', 'Ativo'),
('98.765.432/0001-55', 'Rua XV de Novembro', '250', 'Curitiba', 'PR', '80020-310', 'Centro', 'Sala 5', 'Ativo'),
('55.444.333/0001-22', 'Avenida Atlântica', '5000', 'Rio de Janeiro', 'RJ', '22021-001', 'Copacabana', 'Apt 130', 'Inativo'),
('77.888.999/0001-11', 'Rua das Flores', '123', 'Florianópolis', 'SC', '88010-200', 'Centro', 'Casa 2', 'Ativo');

SELECT idEnderecos, cidade, CASE WHEN statusEndereco = 'Ativo' THEN 'Endereço em uso'
ELSE 'Endereço desativado' END AS situacao FROM enderecos;

SELECT cep, CASE WHEN cep LIKE '_____-___' THEN 'Formato válido'
ELSE 'Formato inválido' END AS 'Validação do CEP' FROM enderecos;

/* ------------------------------------------------------------------------------------------------------- */
-- SPRINT 2

/* NOMES: DAVI VITAL DO PRADO VICENTE PEREIRA - RA: 01252
		  JORGE LUIZ CARDOSO DE SIQUEIRA - RA: 01252
          LEONARDO TOMAS FEITOSA DA SILVA - RA: 01252013
		  MARCOS LOPIS PEREIRA - RA: 01252
          TIAGO DA SILVA SANTOS - RA: 01252
          WAGNER REIS SILVA BRONSTEIN - RA: 01252090
*/

-- Usuarios relacionado à empresa
ALTER TABLE usuarios 
ADD COLUMN fkEmpresa INT,
ADD CONSTRAINT fkUsuarioxEmpresa 
FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa);

-- Registros de sensores relacionado à sensores
ALTER TABLE registroSensor
ADD COLUMN fkSensores INT,
ADD CONSTRAINT fkRegistroxSensor
FOREIGN KEY (fkSensores) REFERENCES sensores(idSensor);

-- Sensores relacionado à empresa
ALTER TABLE sensores
ADD COLUMN fkEmpresa INT,
ADD CONSTRAINT fkSensoresxEmpresa
FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa);

-- Alterar CNPJ da tabela empresa para UNIQUE
ALTER TABLE empresa
ADD CONSTRAINT cnpjUniqueEmpresa UNIQUE (cnpj);

-- Alterar CNPJ da tabela enderecos para UNIQUE
ALTER TABLE enderecos
ADD CONSTRAINT cnpjUniqueEndereco UNIQUE (cnpj);

-- Produção total relacionado à empresa
ALTER TABLE producaoTotal
ADD COLUMN fkEmpresa INT,
ADD CONSTRAINT fkProducaoxEmpresa
FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa);

-- Endereços relacionado à empresa
ALTER TABLE enderecos
ADD COLUMN fkEmpresa INT,
ADD CONSTRAINT fkEnderecoxEmpresa
FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa);

-- Criar tabela para local dos sensores / com chave estrangeira localSensor relacionado à sensores
CREATE TABLE localSensor (
idLocal INT PRIMARY KEY AUTO_INCREMENT,
nomeLocal VARCHAR(45) NOT NULL,
descricao VARCHAR(100),
fkSensores INT,
CONSTRAINT fkLocalSensorxSensores
FOREIGN KEY (fkSensores) REFERENCES sensores(idSensor)
);

-- Inserir dados localSensor
INSERT INTO localSensor (nomeLocal, descricao) VALUES
('Apiário Principal', 'Local principal com várias colmeias de alta produção'),
('Apiário Secundário', 'Local menor');

-- Seleção para conferir os dados inseridos
SELECT * FROM localSensor;

-- Alterar nome de coluna
ALTER TABLE registroSensor
RENAME COLUMN qtdTemperatura TO valorTemperatura;

-- Remover a coluna telFixo da tabela usuarios e contato
ALTER TABLE usuarios
DROP COLUMN telFixo;

ALTER TABLE contato
DROP COLUMN telFixo;

-- JOIN com CASE (usuários e empresas)
SELECT 
CONCAT(u.nome, ' ', u.sobrenome) AS 'Nome Completo',
e.nomeEmpresa AS 'Nome Empresa',
CASE
WHEN u.nivelUsuario = 'ADM' THEN 'Administrador'
WHEN u.nivelUsuario = 'SUB' THEN 'Subordinado'
ELSE 'Outro'
END AS Nível
FROM usuarios u
JOIN empresa e ON u.fkUsuarioEmpresa = e.idEmpresa;

-- JOIN sensores + empresa + localSensor
SELECT 
s.nomeSensor AS 'Identificação do Sensor',
e.nomeEmpresa AS 'Nome da Empresa',
l.nomeLocal AS 'Local',
IFNULL(l.descricao, 'Sem descrição') AS 'Descrição Local'
FROM sensores s
JOIN empresa e 
ON s.fkSensorEmpresa = e.idEmpresa
JOIN localSensor l 
ON s.fkSensoresLocalSensor = l.idLocal;

-- JOIN registroSensor + sensores + empresa (com CASE para status)
SELECT 
r.idRegistroSensor AS 'Registro do Sensor',
s.nomeSensor AS 'Identificação do Sensor',
e.nomeEmpresa AS 'Nome da Empresa',
r.valorTemperatura AS 'Temperatura',
CASE 
WHEN r.valorTemperatura > 36 THEN 'Temperatura Alta Crítica'
WHEN r.valorTemperatura BETWEEN 33 AND 36 THEN 'Temperatura Normal'
ELSE 'Temperatura Baixa Crítica'
END AS Situação
FROM registroSensor r
JOIN sensores s ON r.sensor = s.nomeSensor
JOIN empresa e ON s.cliente = e.nomeEmpresa;
