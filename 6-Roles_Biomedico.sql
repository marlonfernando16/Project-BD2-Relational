/* Grupo biomedico/bioquímico com dois usuários */
CREATE ROLE gp_biomedico;

GRANT SELECT ON atendimento
TO GROUP gp_biomedico;
--Precisa do select pra poder usar o where
--quando for dar update.

GRANT UPDATE (descricao) ON atendimento 
TO GROUP gp_biomedico;

CREATE ROLE usr_biomedico_1 WITH 
LOGIN PASSWORD 'bd2'
IN ROLE gp_biomedico;

CREATE ROLE usr_biomedico_2 WITH 
LOGIN PASSWORD 'bd2'
IN ROLE gp_biomedico;