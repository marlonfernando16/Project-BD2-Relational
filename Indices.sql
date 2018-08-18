
/* Indice para a data de nascimento dos pacientes */
 CREATE INDEX ind_data_nasc_pac ON
paciente(data_nasc);

/* Indice para o uf dos pacientes */
CREATE INDEX ind_uf_pac ON
paciente(uf);

/* Indice para o a data de atendimento dos pacientes */
CREATE INDEX ind_at_pac ON
atendimento(data_hora);
