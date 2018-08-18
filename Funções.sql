/* funcoes */

/* 1 - Somatório do salário de todos os funcionários da empresa */

create or replace function sum_salarios_func()
returns numeric as $$
declare
total categoria.salario%type; 
begin
select SUM(salario) into total from categoria c join
funcionario f on c.id_categ = f.id_categ;
return total;
end;
$$ language plpgsql;

/* 2 - Salario do funcionario de acordo com a categoria  */

create or replace function salario_func(funcao varchar)
returns numeric as $$
declare
total categoria.salario%type; 
begin
select ca.salario into strict total from categoria ca where ca.nome = funcao;
return total;
exception 
  when no_data_found then
    raise notice 'Função inexistente!';
    return 0;
    end;
$$ language plpgsql;

select salario_func('Biomedico');

/* 3 - Nome e quantidade do exame mais solicitado */

create or replace function qtd_nome_maior_exa()
returns varchar as $$
declare
texto varchar;
req integer;
begin
select count(atd.id_exame) quantidade,ex.nome into strict req,texto from exame ex join 
atendimento atd on ex.id_exame = atd.id_exame
group by ex.nome
order by quantidade desc
limit 1;
return 'O exame mais solicitado foi: ' || texto || '.' ||' Quantidade: ' || req;
exception 
  when no_data_found then
    raise notice 'Nenhum exame foi realizado até o momento!';
    return 0;
end;
$$ language plpgsql;
select qtd_nome_maior_exa();




/* 4 - 	Os pacientes que realizaram mais exames */

create or replace function cliente_maior_exame()
returns varchar as $$
declare 
qtd integer;
pac varchar;
begin
select count(atd.id_pac) quantidade ,p.nome into  qtd,pac from paciente p join atendimento atd
on p.id_pac = atd.id_pac group by p.nome,atd.id_pac order by quantidade desc
;
return ' O paciente que mais realizou o exame foi: ' || pac || ' Quantidade de vezes: ' || qtd;
end;
$$ language plpgsql;

select cliente_maior_exame();
