# 📂 Gerenciamento de Hospedagens Hoteleiras

<p align="center">
   <a href="#-sobre-o-projeto"> 💻 Sobre o Projeto </a> •
   <a href="#estrutura-do-banco-de-dados"> ⚙️ Estrutura do Banco de Dados </a> •
   <a href="#-inserção-de-dados"> 🎲 Inserção de Dados </a> •
   <a href="#-consultas-e-comandos-sql"> 🔍 Consultas e Comandos SQL </a> •
   
   <a href="#-procedures"> 🔗 Procedures </a> •
   <a href="#-functions"> 🔧 Functions </a> •
   <a href="#-triggers"> 🪝 Triggers </a>
</p>

# 💻 Sobre o Projeto

Este projeto foi desenvolvido em Maio de 2024, como parte de uma atividade acadêmica sobre Banco de Dados em SQL. 

O objetivo desse projeto é fazer o gerenciamento de um sistema de hospedagens hoteleiras, incluindo informações sobre hotéis, quartos, clientes e hospedagens. O banco de dados foi desenvolvido para facilitar a consulta e a administração desses dados, oferecendo funcionalidades para registrar, atualizar e consultar informações de maneira eficiente e objetiva.

<h2 id="estrutura-do-banco-de-dados">⚙️ Estrutura do Banco de Dados</h2>

**Esquema**

O esquema do banco de dados é denominado hospedar_db e inclui as seguintes tabelas:

**1. Hotel**
   
hotel_id (INT, PRIMARY KEY, AUTO_INCREMENT)

nome (VARCHAR(100), NOT NULL)

cidade (VARCHAR(50), NOT NULL)

uf (VARCHAR(2), NOT NULL)

classificacao (INT(1), NOT NULL)

**2. Quarto**
   
quarto_id (INT, PRIMARY KEY, AUTO_INCREMENT)

hotel_id (INT, NOT NULL, FOREIGN KEY para Hotel.hotel_id)

numero (INT, NOT NULL)

tipo (VARCHAR(50), NOT NULL)

preco_diaria (DECIMAL(10, 2), NOT NULL)

**3. Cliente**
   
cliente_id (INT, PRIMARY KEY, AUTO_INCREMENT)

nome (VARCHAR(100), NOT NULL)

email (VARCHAR(50), NOT NULL)

telefone (VARCHAR(15), NOT NULL)

cpf (VARCHAR(15), NOT NULL, UNIQUE)

**4. Hospedagem**

hospedagem_id (INT, PRIMARY KEY, AUTO_INCREMENT)

cliente_id (INT, NOT NULL, FOREIGN KEY para Cliente.cliente_id)

quarto_id (INT, NOT NULL, FOREIGN KEY para Quarto.quarto_id)

dt_checkin (DATE, NOT NULL)

dt_checkout (DATE, NOT NULL)

valor_total_hosp (FLOAT, NOT NULL)

status_hosp (VARCHAR(50), NOT NULL)

# 🎲 Inserção de Dados 

**1. Hotéis**

INSERT INTO Hotel (nome, cidade, uf, classificacao) VALUES 

('Hotel Vale do Sol', 'Itaborai', 'RJ', 4), 

('Hotel Aguas Claras', 'Cabo Frio', 'RJ', 5);

**2. Quartos**

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

**3. Clientes**

INSERT INTO Cliente (nome, email, telefone, cpf) VALUES

('Rosario Nunes', 'rosarionunes123@gmail.com', '21987654321', '12345678901'),

('Carlos Nascimento', 'carlosnascimento765@gmail.com', '11987654321', '23456789012'),

('Maria Silva', 'mariasilva876@gmail.com', '31987654321', '21567890123');

**4. Hospedagens**

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

# 🔍 Consultas e Comandos SQL

A. Lista todos os hotéis e seus respectivos quartos, apresentando os seguintes campos: hotel, nome e cidade; quarto, tipo e preco_diaria;
<p align="center">
  <img src="assets/consulta 1.png">
</p>

B. ​Lista todos os clientes que já realizaram hospedagens (status_hosp igual á “finalizada”), e os respectivos quartos e hotéis;
<p align="center">
  <img src="assets/consulta 2.png">
</p>

C. ​Mostra o histórico de hospedagens em ordem cronológica de um determinado cliente;
<p align="center">
  <img src="assets/consulta 3.png">
</p>

D. ​Apresenta o cliente com maior número de hospedagens (não importando o tempo em que ficou hospedado);
<p align="center">
  <img src="assets/consulta 4.png">
</p>

E. ​Apresenta clientes que tiveram hospedagem “cancelada” e seus respectivos quartos e hotéis.
<p align="center">
  <img src="assets/consulta 5.png">
</p>

F. ​Faz o cálculo da receita de todos os hotéis (hospedagem com status_hosp igual a “finalizada”), ordenando os dados de forma decrescente;
<p align="center">
  <img src="assets/consulta 6.png">
</p>

G. ​Lista todos os clientes que já fizeram uma reserva em algum um hotel específico;
<p align="center">
  <img src="assets/consulta 7.png">
</p>

H. ​Lista o quanto cada cliente que gastou em hospedagens (status_hosp igual a “finalizada”), ordenando os dados de forma decrescente por valor gasto.
<p align="center">
  <img src="assets/consulta 8.png">
</p>
I. ​Lista todos os quartos que ainda não receberam hóspedes.
<p align="center">
  <img src="assets/consulta 9.png">
</p>

J. ​Apresenta a média de preços de diárias em todos os hotéis, por tipos de quarto.
<p align="center">
  <img src="assets/consulta 10.png">
</p>

L. ​Cria a coluna checkin_realizado do tipo booleano na tabela Hospedagem. E atribui verdadeiro para as Hospedagens com status_hosp “finalizada” e “hospedado”, e como falso para Hospedagens com status_hosp “reserva” e “cancelada”.
<p align="center">
  <img src="assets/consulta 11.png">
</p>

M. ​Muda o nome da coluna “classificacao” da tabela Hotel para “ratting”.
<p align="center">
  <img src="assets/consulta 12.png">
</p>

# 🔗 Procedures

A. Cria uma procedure chamada "RegistrarCheckIn" que aceita hospedagem_id e data_checkin como parâmetros. A procedure atualiza a data de check-in na tabela "Hospedagem" e muda o status_hosp para "hospedado".​
<p align="center">
  <img src="assets/procedimento 1.png">
</p>

B. Cria uma procedure chamada "CalcularTotalHospedagem" que aceita hospedagem_id como parâmetro. A procedure calcula o valor total da hospedagem com base na diferença de dias entre check-in e check-out e o preço da diária do quarto reservado. O valor é atualizado na coluna valor_total_hosp.​
<p align="center">
  <img src="assets/procedimento 2.png">
</p>

C. Cria uma procedure chamada "RegistrarCheckout" que aceita hospedagem_id e data_checkout como parâmetros. A procedure atualiza a data de check-out na tabela "Hospedagem" e muda o status_hosp para "finalizada".​
<p align="center">
  <img src="assets/procedimento 3.png">
</p>

# 🔧 Functions

A. Cria uma function chamada "TotalHospedagensHotel" que aceita hotel_id como parâmetro. A função retorna o número total de hospedagens realizadas em um determinado hotel.​
<p align="center">
  <img src="assets/função 1.png">
</p>

B. Cria uma function chamada "ValorMedioDiariasHotel" que aceita hotel_id como parâmetro. A função calcula e retorna o valor médio das diárias dos quartos deste hotel.
<p align="center">
  <img src="assets/função 2.png">
</p>

C. Cria uma function chamada "VerificarDisponibilidadeQuarto" que aceita quarto_id e data como parâmetros. A função retorna um valor booleano indicando se o quarto está disponível ou não para reserva na data especificada.​
<p align="center">
  <img src="assets/função 3.png">
</p>

# 🪝 Triggers

A. Cria um trigger chamado "AntesDeInserirHospedagem" que é acionado antes de uma inserção na tabela "Hospedagem". O trigger verifica se o quarto está disponível na data de check-in. Se não estiver, a inserção é cancelada.
<p align="center">
  <img src="assets/trigger 1.png">
</p>

B. Cria um trigger chamado "AposDeletarCliente" que é acionado após a exclusão de um cliente na tabela "Cliente". O trigger registra a exclusão em uma tabela de log.​
<p align="center">
  <img src="assets/trigger 2.png">
</p>

##
# 📄 Autores 
**Nicolas Ryan - Engenheiro de Software** 
