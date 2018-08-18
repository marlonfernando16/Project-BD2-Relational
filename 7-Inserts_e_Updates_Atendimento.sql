--Logar com um atendente.

/*inserções em atendimento */
insert into atendimento values(3,1,'2018-02-04');
insert into atendimento values(1,2,'2018-06-15');
insert into atendimento values(2,3,'2018-03-07');
insert into atendimento values(7,4,'2018-04-15');
insert into atendimento values(8,5,'2018-01-06');
insert into atendimento values(2,6,current_timestamp);
insert into atendimento values(1,7,current_timestamp);
insert into atendimento values(5,8,current_timestamp);
insert into atendimento values(6,9,current_timestamp);
insert into atendimento values(7,10,current_timestamp);

--os funcionarios 4 e 5 sao enfermeiras
--os funcionarios de 6 a 9 sao bio...

Update atendimento
Set id_enf = 4, id_bio = 8
Where id_exame = 1;

Update atendimento
Set id_bio = 9
Where id_exame = 3;

--Logar com um bioquimico/biomedico.

Update atendimento
Set descricao = 'paciente com verme'
Where id_exame = 3;

Update atendimento
Set descricao = 'paciente com taxa de hemacias elevada'
Where id_exame = 1;