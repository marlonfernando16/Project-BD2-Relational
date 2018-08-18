/* Grupo atendente com dois usuários */
CREATE ROLE gp_atendente;

GRANT SELECT, INSERT ON atendimento, paciente
TO GROUP gp_atendente;

GRANT EXECUTE ON FUNCTION sum_salarios_func()
TO gp_atendente;

--Inicio das correcoes pro trigger
--insert atendimento

GRANT SELECT ON exame, convenio, paciente_convenio
TO GROUP gp_atendente;

GRANT INSERT 
(usuario,nome_paciente,nome_exame,data_corrente,convenio,valor_exame)
ON log_atendimentos
TO GROUP gp_atendente;

--update atendimento
GRANT SELECT ON funcionario, categoria
TO GROUP gp_atendente;

--Fim  das correcoes pro trigger

GRANT UPDATE (id_enf, id_bio) ON atendimento
TO GROUP gp_atendente;

CREATE ROLE usr_atendente_1 WITH 
LOGIN PASSWORD 'bd2'
IN ROLE gp_atendente;

CREATE ROLE usr_atendente_2 WITH 
LOGIN PASSWORD 'bd2'
IN ROLE gp_atendente;