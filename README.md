## Gerenciamento-De-Hospedagens-Hoteleiras

# 💻 Sobre o Projeto 

Este projeto foi desenvolvido em Maio de 2024, como parte de uma atividade acadêmica sobre Banco de Dados em SQL. 

O objetivo desse projeto é fazer o gerenciamento de um sistema de hospedagens hoteleiras, incluindo informações sobre hotéis, quartos, clientes e hospedagens. O banco de dados foi desenvolvido para facilitar a consulta e a administração desses dados, oferecendo funcionalidades para registrar, atualizar e consultar informações de maneira eficiente e objetiva.

# ⚙️ Estrutura do Banco de Dados 

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

# 🔍 Consultas & Comandos SQL:

A. Lista todos os hotéis e seus respectivos quartos, apresentando os seguintes campos: hotel, nome e cidade; quarto, tipo e preco_diaria;

B. ​Lista todos os clientes que já realizaram hospedagens (status_hosp igual á “finalizada”), e os respectivos quartos e hotéis;

C. ​Mostra o histórico de hospedagens em ordem cronológica de um determinado cliente;

D. ​Apresenta o cliente com maior número de hospedagens (não importando o tempo em que ficou hospedado);

E. ​Apresenta clientes que tiveram hospedagem “cancelada” e seus respectivos quartos e hotéis.

F. ​Faz o cálculo da receita de todos os hotéis (hospedagem com status_hosp igual a “finalizada”), ordenando os dados de forma decrescente;

G. ​Lista todos os clientes que já fizeram uma reserva em algum um hotel específico;

H. ​Lista o quanto cada cliente que gastou em hospedagens (status_hosp igual a “finalizada”), ordenando os dados de forma decrescente por valor gasto.
I. ​Lista todos os quartos que ainda não receberam hóspedes.

J. ​Apresenta a média de preços de diárias em todos os hotéis, por tipos de quarto.

L. ​Cria a coluna checkin_realizado do tipo booleano na tabela Hospedagem. E atribui verdadeiro para as Hospedagens com status_hosp “finalizada” e “hospedado”, e como falso para Hospedagens com status_hosp “reserva” e “cancelada”.

M. ​Muda o nome da coluna “classificacao” da tabela Hotel para “ratting”.

# 🔗 Procedures:

A. Cria uma procedure chamada "RegistrarCheckIn" que aceita hospedagem_id e data_checkin como parâmetros. A procedure atualiza a data de check-in na tabela "Hospedagem" e muda o status_hosp para "hospedado".​

B. Cria uma procedure chamada "CalcularTotalHospedagem" que aceita hospedagem_id como parâmetro. A procedure calcula o valor total da hospedagem com base na diferença de dias entre check-in e check-out e o preço da diária do quarto reservado. O valor é atualizado na coluna valor_total_hosp.​

C. Cria uma procedure chamada "RegistrarCheckout" que aceita hospedagem_id e data_checkout como parâmetros. A procedure atualiza a data de check-out na tabela "Hospedagem" e muda o status_hosp para "finalizada".​

# 🔧 Functions:

A. Cria uma function chamada "TotalHospedagensHotel" que aceita hotel_id como parâmetro. A função retorna o número total de hospedagens realizadas em um determinado hotel.​

B. Cria uma function chamada "ValorMedioDiariasHotel" que aceita hotel_id como parâmetro. A função calcula e retorna o valor médio das diárias dos quartos deste hotel.

C. Cria uma function chamada "VerificarDisponibilidadeQuarto" que aceita quarto_id e data como parâmetros. A função retorna um valor booleano indicando se o quarto está disponível ou não para reserva na data especificada.​

# 🪝 Triggers:

A. Cria um trigger chamado "AntesDeInserirHospedagem" que é acionado antes de uma inserção na tabela "Hospedagem". O trigger verifica se o quarto está disponível na data de check-in. Se não estiver, a inserção é cancelada.

B. Cria um trigger chamado "AposDeletarCliente" que é acionado após a exclusão de um cliente na tabela "Cliente". O trigger registra a exclusão em uma tabela de log.​

