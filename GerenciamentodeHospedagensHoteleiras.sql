CREATE SCHEMA hospedar_db;
USE hospedar_db;

CREATE TABLE Hotel(
hotel_id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
cidade VARCHAR(50) NOT NULL,
uf VARCHAR(2) NOT NULL,
classificacao INT(1) NOT NULL
);

CREATE TABLE Quarto(
quarto_id INT PRIMARY KEY AUTO_INCREMENT,
hotel_id INT NOT NULL,
numero INT NOT NULL,
tipo VARCHAR(50) NOT NULL,
preco_diaria DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id) -- CHAVE ESTRANGEIRA PARA REFERENCIAR A TABELA HOTEL, NO CAMPO HOTEL_ID.
);

CREATE TABLE Cliente(
cliente_id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
email VARCHAR(50) NOT NULL,
telefone VARCHAR(15) NOT NULL,
cpf VARCHAR(15) NOT NULL,
UNIQUE(cpf, email)
);

CREATE TABLE Hospedagem(
hospedagem_id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT NOT NULL,
quarto_id INT NOT NULL,
dt_checkin DATE NOT NULL,
dt_checkout DATE NOT NULL,
valor_total_hosp FLOAT NOT NULL,
status_hosp VARCHAR (50) NOT NULL, 
FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id) ON DELETE CASCADE,
FOREIGN KEY (quarto_id) REFERENCES Quarto(quarto_id)
);

-- Inserção de Dados

INSERT INTO Hotel (nome, cidade, uf, classificacao) VALUES 
('Hotel Vale do Sol', 'Itaborai', 'RJ', 4), 
('Hotel Aguas Claras', 'Cabo Frio', 'RJ', 5);

-- Hotel Vale do Sol

INSERT INTO Quarto (hotel_id, numero, tipo, preco_diaria) VALUES 
(1, 1001, 'Solteiro', 100.00), 
(1, 1002, 'Duplo Solteiro', 150.00), 
(1, 1003, 'Casal', 250.00), 
(1, 1004, 'Deluxe', 300.00), 
(1, 1005, 'Solteiro', 100.00); 

-- Hotel Aguas Claras

INSERT INTO Quarto (hotel_id, numero, tipo, preco_diaria) VALUES 
(2, 2001, 'Solteiro', 150.00),
(2, 2002, 'Duplo Solteiro', 200.00), 
(2, 2003, 'Casal', 300.00),
(2, 2004, 'Deluxe', 350.00), 
(2, 2005, 'Solteiro', 150.00); 

-- Clientes 

INSERT INTO Cliente (nome, email, telefone, cpf) VALUES
('Rosario Nunes', 'rosarionunes123@gmail.com', '21987654321', '12345678901'),
('Carlos Nascimento', 'carlosnascimento765@gmail.com', '11987654321', '23456789012'),
('Maria Silva', 'mariasilva876@gmail.com', '31987654321', '21567890123');

-- Hospedagem

INSERT INTO Hospedagem (cliente_id, quarto_id, dt_checkin, dt_checkout, valor_total_hosp, status_hosp) VALUES
(1, 5, '2024-01-01', '2024-01-04', 300.00, 'Finalizada'),
(3, 10, '2024-03-07', '2024-03-09', 200.00, 'Finalizada'),
(3, 6, '2024-04-03', '2024-04-06', 450.00, 'Finalizada'),
(2, 8, '2024-02-15', '2024-02-19', 1200.00, 'Finalizada'),
(2, 2, '2024-05-01', '2024-05-05', 600.00, 'Finalizada'),
(2, 2, '2024-02-08', '2024-02-10', 300.00, 'Cancelada'),
(3, 1, '2024-07-01', '2024-07-04', 300.00, 'Cancelada'),
(1, 4, '2024-07-10', '2024-07-12', 600.00, 'Cancelada'),
(2, 5, '2024-07-08', '2024-07-09', 100.00, 'Cancelada'),
(3, 2, '2024-07-16', '2024-07-18', 300.00, 'Cancelada'),
(3, 4, '2024-05-07', '2024-05-09', 600.00, 'Hospedado'),
(3, 9, '2024-05-09', '2024-05-10', 350.00, 'Hospedado'),
(1, 10, '2024-05-01', '2024-05-05', 600.00, 'Hospedado'),
(1, 10, '2024-05-15', '2024-05-17', 300.00, 'Hospedado'),
(3, 4, '2024-05-15', '2024-05-17', 600.00, 'Hospedado'),
(1, 5, '2024-06-06', '2024-06-08', 200.00, 'Reserva'),
(2, 7, '2024-06-01', '2024-06-03', 400.00, 'Reserva'),
(3, 10, '2024-07-15', '2024-07-18', 450.00, 'Reserva'),
(2, 1, '2024-08-01', '2024-08-03', 200.00, 'Reserva'),
(1, 4, '2024-08-10', '2024-09-12', 600.00, 'Reserva');

/* CONSULTAS */

-- LETRA A
SELECT Hotel.nome AS nome_hotel,
Hotel.cidade AS cidade,
Quarto.tipo AS tipo_quarto,
Quarto.preco_diaria AS preco_diaria
FROM Hotel
JOIN Quarto ON Hotel.hotel_id = Quarto.hotel_id;

-- LETRA B
SELECT Cliente.nome AS nome,
Quarto.tipo AS tipo_quarto,
Hotel.nome AS nome_hotel,
Hotel.cidade AS cidade
FROM Cliente
JOIN Hospedagem ON Cliente.cliente_id = Hospedagem.cliente_id
JOIN Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
JOIN Hotel ON Quarto.hotel_id = Hotel.hotel_id
WHERE Hospedagem.status_hosp = 'Finalizada';

-- LETRA C
SELECT Hospedagem.hospedagem_id,
Hotel.nome AS nome_hotel,
Quarto.tipo AS tipo_quarto,
Hospedagem.dt_checkin,
Hospedagem.dt_checkout,
Hospedagem.valor_total_hosp,
Hospedagem.status_hosp
FROM Hospedagem
JOIN Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
JOIN Hotel ON Quarto.hotel_id = Hotel.hotel_id
WHERE Hospedagem.cliente_id = (SELECT cliente_id FROM Cliente WHERE nome = 'Maria Silva')
ORDER BY Hospedagem.dt_checkin, Hospedagem.dt_checkout;

-- LETRA D 
SELECT Cliente.nome AS nome_cliente,
COUNT(Hospedagem.hospedagem_id) AS total_hospedagens
FROM Cliente
JOIN Hospedagem ON Cliente.cliente_id = Hospedagem.cliente_id
GROUP BY Cliente.cliente_id
ORDER BY total_hospedagens DESC
LIMIT 1;

-- LETRA E
SELECT Cliente.nome AS nome,
Quarto.tipo AS tipo_quarto,
Hotel.nome AS nome_hotel,
Hotel.cidade AS cidade
FROM Cliente
JOIN Hospedagem ON Cliente.cliente_id = Hospedagem.cliente_id
JOIN Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
JOIN Hotel ON Quarto.hotel_id = Hotel.hotel_id
WHERE Hospedagem.status_hosp = 'Cancelada';

-- LETRA F
SELECT Hotel.nome AS nome_hotel,
SUM(Hospedagem.valor_total_hosp) AS receita_total
FROM Hotel
JOIN Quarto ON Hotel.hotel_id = Quarto.hotel_id
JOIN Hospedagem ON Quarto.quarto_id = Hospedagem.quarto_id
WHERE Hospedagem.status_hosp = 'finalizada'
GROUP BY Hotel.hotel_id
ORDER BY receita_total DESC;

-- LETRA G
SELECT Cliente.nome AS nome,
Cliente.cpf AS cpf,
Hotel.nome AS nome_hotel
FROM Cliente
JOIN Hospedagem ON Cliente.cliente_id = Hospedagem.cliente_id
JOIN Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
JOIN Hotel ON Quarto.hotel_id = Hotel.hotel_id
WHERE Hospedagem.status_hosp = 'Reserva'
AND Hotel.nome = 'Hotel Vale do Sol';

-- LETRA H
SELECT Cliente.nome AS nome,
SUM(Hospedagem.valor_total_hosp) AS gasto_total_cliente
FROM Cliente
JOIN Hospedagem ON Cliente.cliente_id = Hospedagem.cliente_id
JOIN Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
JOIN Hotel ON Quarto.hotel_id = Hotel.hotel_id
WHERE Hospedagem.status_hosp = 'finalizada'
GROUP BY Cliente.cliente_id
ORDER BY gasto_total_cliente DESC;

-- LETRA I
SELECT Quarto.numero AS numero_quarto,
Quarto.tipo AS tipo_quarto,
Hotel.nome AS nome_hotel
FROM Quarto
JOIN Hotel ON Quarto.hotel_id = Hotel.hotel_id
LEFT JOIN Hospedagem ON Quarto.quarto_id = Hospedagem.quarto_id
WHERE Hospedagem.hospedagem_id IS NULL;

-- LETRA J
SELECT Quarto.tipo AS tipo_quarto,
ROUND (AVG(Quarto.preco_diaria), 2) AS media_preco_diaria
FROM Quarto
GROUP BY Quarto.tipo;

-- LETRA L
ALTER TABLE Hospedagem
ADD checkin_realizado BOOLEAN;

SET SQL_SAFE_UPDATES = 0; /* DESATIVAR PROTEÇÃO */

UPDATE Hospedagem
SET checkin_realizado = 
CASE 
WHEN status_hosp IN ('finalizada', 'hospedado') THEN TRUE
ELSE FALSE
END;
SET SQL_SAFE_UPDATES = 1; /* REATIVAR PROTEÇÃO */
SELECT * FROM hospedagem; /* CONSULTA PARA CONFIRMAÇÃO DO UPDATE */

-- LETRA M
ALTER TABLE Hotel RENAME COLUMN classificacao TO ratting;
SELECT * FROM Hotel; /* CONSULTA PARA CONFIRMAÇÃO DE ALTERAÇÃO NA TABELA HOTEL */

/* =================== FIM DAS CONSULTAS ====================== */

/* PROCEDURES */ 

-- LETRA A 
DELIMITER //
CREATE PROCEDURE RegistrarCheckIn (
IN p_hospedagem_id INT,
IN p_data_checkin DATE
)
BEGIN
UPDATE Hospedagem
SET dt_checkin = p_data_checkin,
status_hosp = 'Hospedado'
WHERE hospedagem_id = p_hospedagem_id;
END //
DELIMITER ;

CALL RegistrarCheckIn(16,'2024-06-06'); /* CHAMANDO O PROCEDIMENTO */
SELECT * FROM hospedagem; /* CONSULTA PARA VERIFICAR A ALTERAÇÃO */

-- LETRA B
DELIMITER //
CREATE PROCEDURE CalcularTotalHospedagem (
IN p_hospedagem_id INT
)
BEGIN
DECLARE v_dt_checkin DATE;
DECLARE v_dt_checkout DATE;
DECLARE v_preco_diaria DECIMAL(15,2);
DECLARE v_num_dias INT;
DECLARE v_valor_total DECIMAL(15,2);

SELECT H.dt_checkin, H.dt_checkout, Q.preco_diaria
INTO v_dt_checkin, v_dt_checkout, v_preco_diaria
FROM Hospedagem H
JOIN Quarto Q ON H.quarto_id = Q.quarto_id
WHERE H.hospedagem_id = p_hospedagem_id;

SET v_num_dias = DATEDIFF(v_dt_checkout, v_dt_checkin);
SET v_valor_total = v_num_dias * v_preco_diaria;

UPDATE Hospedagem
SET valor_total_hosp = v_valor_total
WHERE hospedagem_id = p_hospedagem_id;
END //
DELIMITER ;

CALL CalcularTotalHospedagem(5); /* CHAMANDO O PROCEDIMENTO */
SELECT /* CONSULTA PARA CHECAR SE O CÁLCULO ESTÁ CORRETO */
H.hospedagem_id,
H.dt_checkin,
H.dt_checkout,
Q.preco_diaria,
H.valor_total_hosp
FROM 
Hospedagem H
JOIN 
Quarto Q ON H.quarto_id = Q.quarto_id
WHERE 
H.hospedagem_id = 5;

-- LETRA C
DELIMITER //
CREATE PROCEDURE RegistrarCheckout (
IN p_hospedagem_id INT,
IN p_data_checkout DATE
)
BEGIN
UPDATE Hospedagem
SET dt_checkout = p_data_checkout,
status_hosp = 'Finalizada'
WHERE hospedagem_id = p_hospedagem_id;
END //
DELIMITER ;

CALL RegistrarCheckout(16,'2024-06-08'); /* CHAMANDO O PROCEDIMENTO */
SELECT * FROM hospedagem; /* CONSULTA PARA VERIFICAR A ALTERAÇÃO */

/* ========= FIM PROCEDURES ============ */ 

/* FUNÇÕES */ 

-- LETRA A
DELIMITER // 
CREATE FUNCTION TotalHospedagensHotel (p_hotel_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total_hospedagens INT;

SELECT COUNT(*)
INTO total_hospedagens
FROM Hospedagem H
JOIN Quarto Q ON H.quarto_id = Q.quarto_id
WHERE Q.hotel_id = p_hotel_id;

RETURN total_hospedagens;
END //
DELIMITER ;

SELECT TotalHospedagensHotel(1); /* CONSULTA PARA VERIFICAR AS INFORMAÇÕES */

-- LETRA B
DELIMITER //
CREATE FUNCTION ValorMedioDiariasHotel (p_hotel_id INT)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
DECLARE avg_diaria DECIMAL(15, 2);

SELECT AVG(preco_diaria)
INTO avg_diaria
FROM Quarto
WHERE hotel_id = p_hotel_id;

RETURN avg_diaria;
END//
DELIMITER ;

SELECT ValorMedioDiariasHotel(1); /* CONSULTA PARA VERIFICAR AS INFORMAÇÕES */

-- LETRA C
DELIMITER //
CREATE FUNCTION VerificarDisponibilidadeQuarto (p_quarto_id INT, p_data DATE)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE disponivel BOOLEAN;

SELECT COUNT(*) = 0
INTO disponivel
FROM Hospedagem
WHERE quarto_id = p_quarto_id
AND p_data >= dt_checkin AND p_data < dt_checkout;

RETURN disponivel;
END//
DELIMITER ;

SELECT VerificarDisponibilidadeQuarto(1,'2024-01-08') AS disponibilidade; /* CONSULTA PARA VERIFICAR AS INFORMAÇÕES */

/* ========= FIM FUNÇÕES ============ */ 

/* TRIGGERS */ 

-- LETRA A
DELIMITER //
CREATE TRIGGER AntesDeInserirHospedagem
BEFORE INSERT ON Hospedagem
FOR EACH ROW
BEGIN
DECLARE disponivel BOOLEAN;

SELECT COUNT(*)
INTO disponivel
FROM Hospedagem
WHERE quarto_id = NEW.quarto_id
AND (NEW.dt_checkin >= dt_checkin AND NEW.dt_checkin < dt_checkout
OR NEW.dt_checkout > dt_checkin AND NEW.dt_checkout <= dt_checkout);

IF disponivel > 0 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O quarto não está disponível na data de check-in. A inserção foi cancelada.';
END IF;
END//
DELIMITER ;

INSERT INTO Hospedagem (cliente_id, quarto_id, dt_checkin, dt_checkout, valor_total_hosp, status_hosp) VALUES
(1, 5, '2024-01-01', '2024-01-04', 300.00, 'Finalizada'); /* TESTE PARA VERIFICAR A FUNCIONALIDADE DO TRIGGER */
SELECT * FROM Hospedagem; /* CONSULTA DE VERIFICAÇÃO DAS INFORMAÇÕES */

-- LETRA B
/* CRIA UMA TABELA PARA ARMAZENAR OS CLIENTES EXCLUÍDOS */
CREATE TABLE IF NOT EXISTS ExclusaoCliente (
cliente_id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
email VARCHAR(50) NOT NULL,
telefone VARCHAR(15) NOT NULL,
cpf VARCHAR(15) NOT NULL,
dataExclusao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
UNIQUE(cpf, email)
);

/* O TRIGGER PARA A EXECUÇÃO */
DELIMITER //
CREATE TRIGGER AposDeletarCliente
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
INSERT INTO ExclusaoCliente (cliente_id, nome, email, telefone, cpf)
VALUES (OLD.cliente_id, OLD.nome, OLD.email, OLD.telefone, OLD.cpf);
DELETE FROM Hospedagem WHERE cliente_id = OLD.cliente_id;
END//
DELIMITER ;

/* COMANDOS PARA TESTAGEM DO TRIGGER */

/* REMOÇÃO DO CLIENTE */

DELETE FROM Cliente WHERE cliente_id = 1; /* UM TESTE DE EXCLUSÃO PARA CONFIRMAR A FUNCIONALIDADE DO TRIGGER */
SELECT * FROM ExclusaoCliente; /* VERIFICA SE O CLIENTE EXCLUÍDO FOI PARA A TABELA EXCLUSAOCLIENTE */
SELECT * FROM Cliente; /* VERIFICA SE O CLIENTE FOI TOTALMENTE EXCLUÍDO DA TABELA CLIENTE */

/* RE-ADICIONAMENTO DO CLIENTE */

SET FOREIGN_KEY_CHECKS = 0; /* DESATIVA TEMPORARIAMENTE A VERIFICAÇÃO DE CHAVES ESTRANGEIRAS */
ALTER TABLE Cliente MODIFY COLUMN cliente_id INT; /* DESATIVA O AUTO_INCREMENT DA COLUNA CLIENTE_ID DA TABELA CLIENTE */
INSERT INTO Cliente (cliente_id, nome, email, telefone, cpf) VALUES /* ADICIONA NOVAMENTE O CLIENTE EXCLUÍDO NA TABELA CLIENTE */
(1, 'Rosario Nunes', 'rosarionunes123@gmail.com', '21987654321', '12345678901');
DELETE FROM ExclusaoCliente WHERE cliente_id = 1; /* REMOVE O CLIENTE DA TABELA EXCLUSAOCLIENTE */
ALTER TABLE Cliente MODIFY COLUMN cliente_id INT AUTO_INCREMENT; /* ATIVA NOVAMENTE O AUTO_INCREMENT */
SET FOREIGN_KEY_CHECKS = 1; /* ATIVA NOVAMENTE A VERIFICAÇÃO DE CHAVES ESTRANGEIRAS */ 
SELECT * FROM Cliente; /* CONSULTA PARA VERIFICAR AS MODIFICAÇÕES */ 

 /* ============== FIM TRIGGERS ================= */ 
 
 /* ============================ FIM PROJETO - BD II =================================================== */