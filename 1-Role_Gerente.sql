
/* Criando grupo de gerente como super usuário */

CREATE ROLE gp_gerente WITH 
SUPERUSER 
CREATEDB 
CREATEROLE;

/* Criando o usuario gerente */

CREATE ROLE usr_gerente WITH 
LOGIN PASSWORD 'bd2';

/* Vinculando o usr_gerente ao grupo gp_gerente */

GRANT gp_gerente TO usr_gerente;

/* Tive que fazer isso pq o usr_gerente não herda essas permissões do gp_gerente */

ALTER ROLE usr_gerente WITH 
SUPERUSER 
CREATEDB 
CREATEROLE;