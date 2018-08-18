
/* Consultas */

/* 1- Nome do funcionário, sua função e seu salário */

Select f.id_func Id,f.nome Funcionário, c.nome Categoria, c.salario Salário
From funcionario f Join categoria c
On f.id_categ = c.id_categ
Order By f.nome;

/* 2 - Nome do exame, seu material e seu método*/
Select ex.nome Exame, me.nome Método, ma.nome Material
From metodo me Join exame ex
On me.id_met = ex.id_met Join material ma
On ex.id_mat = ma.id_mat;


/* 3 - Mostrando o nome, sexo, idade e data de admissão dos funcionarios que são atendentes */
select f.nome, f.sexo, extract(year from age(f.data_nasc)) idade,
f.data_adm  from funcionario f
where id_categ in (select id_categ from categoria where nome like 'Atendente');

/*rescrevendo a subconsulta com join */
select f.nome, f.sexo, extract(year from age(f.data_nasc)) idade,
f.data_adm  from funcionario f join categoria c 
on c.id_categ = f.id_categ 
where c.nome like 'Atendente';

/* 4 - mostando nome  , sexo, e idade dos paciente que não possuem convênio ordenados pela idade */
select nome,extract(year from age(data_nasc)) idade, sexo  from paciente p
where id_pac not in (select id_pac from paciente_convenio)
order by idade;

/*rescrevendo com join*/
select p.nome,extract(year from age(p.data_nasc)) idade, p.sexo  from paciente p left join 
paciente_convenio pa on p.id_pac = pa.id_pac
where pa.id_pac is null
order by idade;


/* 5 - Listando o nome dos exames e a quantidade de vezes que foi realizado */
select e.nome,count( a.id_exame) Quantidade from atendimento a
Join exame e on e.id_exame = a.id_exame
Group by e.nome	;

/*6 listando os pacientes, sua idade e seus convenios */
select distinct p.nome paciente, extract (year from age(p.data_nasc)) idade, c.nome convenio from paciente p join paciente_convenio a
on a.id_pac = p.id_pac join convenio c on c.id_conv = a.id_conv
order by idade;


/* 7 - listando o nome, cidade e uf de todos os pacientes que realizaram exames e seus metodos e materiais e a data do exame ordenados pela data do exame e uf do paciente*/
select p.nome, p.cidade, p.uf, e.nome, me.nome, ma.nome, a.data_hora from paciente p join 
atendimento a on a.id_pac = p.id_pac join exame e on e.id_exame
= a.id_exame join material ma on ma.id_mat = e.id_mat join metodo
me on me.id_met = e.id_met
order by a.data_hora ,p.uf;

/* 8 - Listando os dois paciente que mais realizaram exames */
 select p.nome, count (a.id_pac) quantidade from 
 paciente p join atendimento a on a.id_pac = p.id_pac
group by p.nome order by quantidade desc limit 2;

/* 9 - Listando o nome dos convenios e a quantidade de clientes que tem o convenio  */
select c.nome, count(pa.id_conv) from convenio c join paciente_convenio pa
on c.id_conv = pa.id_conv
group by c.nome;

/* 10 listando nome dos pacientes, exame, metodo, material nome do enfermeiro e biomedico dos atendimentos com laudo*/
select p.nome paciente, ex.nome exame, me.nome metodo, ma.nome material, a.descricao, e.nome enfermeiro, b.nome biomedicobioquimico, a.data_hora 
from paciente p join atendimento a on a.id_pac = p.id_pac join funcionario e on a.id_enf = e.id_func join funcionario b on b.id_func = a.id_bio
 join exame ex on ex.id_exame = a.id_exame join material ma on ma.id_mat = ex.id_mat join metodo
me on me.id_met = ex.id_met
