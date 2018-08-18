/*view 1 tras os nomes dos funcionarios e suas respectivas categorias e salario */ /*permissão do gerente */
create or replace view funcionarioCategoria as
Select f.id_func Id ,f.nome Funcionário, c.nome Categoria, c.salario Salário
From funcionario f Join categoria c
On f.id_categ = c.id_categ
Order By f.nome;


/*view 2 tras os nomes dos exames e seus metodos e materiais, permite a inserção através do trigger*//*permissao do atendente*/

create or replace view ExameMetodoMaterial (exame, metodo, material, valor) as
select  e.nome, me.nome, ma.nome, e.valor from exame e  join material ma on ma.id_mat = e.id_mat join metodo
me on me.id_met = e.id_met;




/*view que mostra o laudo dos exames, nome do paciente, nome do biomedico que analizou o laudo, nome do enfermeiro */
create or replace view ExameLaudo as
select p.nome paciente, ex.nome exame, me.nome metodo, ma.nome material, a.descricao, e.nome enfermeiro, b.nome biomedicobioquimico, a.data_hora 
from paciente p join atendimento a on a.id_pac = p.id_pac join funcionario e on a.id_enf = e.id_func join funcionario b on b.id_func = a.id_bio
 join exame ex on ex.id_exame = a.id_exame join material ma on ma.id_mat = ex.id_mat join metodo
me on me.id_met = ex.id_met;

select * from funcionarioCategoria;
select * from ExameMetodoMaterial;
select * from ExameLaudo;



