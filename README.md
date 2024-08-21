# Gerenciamento-de-hospedagens-hoteleiras
------------------------------------------------------------------------------------------------------------------------------------------
Linguagem Utilizada: SQL
Ferramenta Utilizada: MySql
Realização do Projeto: Abr - Jul de 2024 (5° semestre)
Matéria: Banco de Dados II
Estado do Projeto: 100% Concluído.
Descrição: Meu primeiro projeto envolvendo banco de dados, aqui criei um sistema de gerenciamento de hospedagens para hotéis. O sistema desenvolvido tem capacidade de armazenar informações sobre hotéis, quartos, clientes e hospedagens. Os clientes podem se hospedar em quartos de hotéis diferentes, e o sistema mantém um registro das reservas/hospedagens. Nesse projeto haverão divisões para facilitar a visualização do código, as divisões serão de: consultas, procedures, functions e triggers.
------------------------------------------------------------------------------------------------------------------------------------------
- Consultas e Comandos SQL:
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

- Procedures:
A. Cria uma procedure chamada "RegistrarCheckIn" que aceita hospedagem_id e data_checkin como parâmetros. A procedure atualiza a data de check-in na tabela "Hospedagem" e muda o status_hosp para "hospedado".​
B. Cria uma procedure chamada "CalcularTotalHospedagem" que aceita hospedagem_id como parâmetro. A procedure calcula o valor total da hospedagem com base na diferença de dias entre check-in e check-out e o preço da diária do quarto reservado. O valor é atualizado na coluna valor_total_hosp.​
c. Cria uma procedure chamada "RegistrarCheckout" que aceita hospedagem_id e data_checkout como parâmetros. A procedure atualiza a data de check-out na tabela "Hospedagem" e muda o status_hosp para "finalizada".​

- Functions:
A. Cria uma function chamada "TotalHospedagensHotel" que aceita hotel_id como parâmetro. A função retorna o número total de hospedagens realizadas em um determinado hotel.​
B. Cria uma function chamada "ValorMedioDiariasHotel" que aceita hotel_id como parâmetro. A função calcula e retorna o valor médio das diárias dos quartos deste hotel.
C. Cria uma function chamada "VerificarDisponibilidadeQuarto" que aceita quarto_id e data como parâmetros. A função retorna um valor booleano indicando se o quarto está disponível ou não para reserva na data especificada.​

- Triggers:
A. Cria um trigger chamado "AntesDeInserirHospedagem" que é acionado antes de uma inserção na tabela "Hospedagem". O trigger verifica se o quarto está disponível na data de check-in. Se não estiver, a inserção é cancelada.
B. Cria um trigger chamado "AposDeletarCliente" que é acionado após a exclusão de um cliente na tabela "Cliente". O trigger registra a exclusão em uma tabela de log.​
------------------------------------------------------------------------------------------------------------------------------------------
