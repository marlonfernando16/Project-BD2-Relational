

/*trigger 1 */

Create Or Replace Function func_dataAdm_Funcinario()
Returns Trigger As $$
Begin
  new.data_adm = current_date;
  Return New;
End;
$$ Language 'plpgsql';

Create Trigger trig_dataAdm_Funcinario
Before Insert On Funcionario
For Each Row Execute Procedure func_dataAdm_Funcinario();

/* trigger 2 */

create table log_atendimentos(usuario varchar,
nome_paciente varchar,nome_exame varchar,data_corrente date,convenio varchar,valor_exame numeric);

/*registra um log nas inserções na tabela atendimento*/
CREATE OR REPLACE FUNCTION logs_convenio()
 RETURNS trigger AS $$
 DECLARE
 var_nome_pac varchar;
 var_nome_ex varchar;
 var_conv varchar;
 var_valor_ex numeric;

 BEGIN

 select distinct nome into var_nome_pac from Paciente where id_pac = new.id_pac;
 select nome into var_nome_ex from Exame where id_exame = new.id_exame;
 
select co.nome into var_conv from paciente pa join paciente_convenio pc
 on pa.id_pac = pc.id_pac join convenio co on pc.id_conv = co.id_conv
 where pa.id_pac = new.id_pac;

if var_conv is null then
   select valor into var_valor_ex from Exame where id_exame = new.id_exame;
else
    var_valor_ex = null;
END IF;    
 INSERT INTO log_atendimentos(usuario,nome_paciente,nome_exame,data_corrente,convenio,valor_exame) 
 values(current_user,var_nome_pac,var_nome_ex,current_timestamp,var_conv,var_valor_ex);
 RETURN NEW;

END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER logsExemplo after INSERT
ON atendimento FOR EACH ROW
EXECUTE PROCEDURE logs_convenio(); 
/* trigger 3 */
/*impede atualização indevida na coluna id_enf da tabela atendimento */
create or replace function atualiza_enfermeiro() returns trigger
as $$
declare
var_id_categ integer;
var_categoria_enfermeiro integer;
begin
 select into strict var_id_categ c.id_categ from funcionario f 
 join categoria c on c.id_categ = f.id_categ
 where f.id_func = new.id_enf;

 select id_categ into strict var_categoria_enfermeiro from categoria where nome like 'Enfermeiro';
 
 if var_id_categ <> var_categoria_enfermeiro then
   raise exception 'nao permitido';
 else 
      return new;   
 end if;
 
  exception
   when raise_exception then
     raise notice 'Funcionario não permitido'
     using hint='Por favor, insira o id de um enfermeiro';
     
 end;
 $$ language plpgsql;
 create trigger update_enfermeiro before update
  of id_enf on atendimento
 for each row  execute procedure atualiza_enfermeiro();
 
/* trigger 4 impede atualização indevida na coluna id_bio da tabela atendimento*/
create or replace function atualiza_bio()
returns trigger as $$
declare 
var_id_categ integer;
var_categoria_biomedico integer;
var_categoria_bioquimico integer;
begin
 select into strict var_id_categ c.id_categ from funcionario f 
 join categoria c on c.id_categ = f.id_categ
 where f.id_func = new.id_bio;

 select id_categ into strict var_categoria_biomedico from categoria where nome like 'Biomedico' ;
 select id_categ into strict var_categoria_bioquimico from categoria where nome like 'Bioquimico' ;

 
 if var_id_categ <> var_categoria_biomedico and var_id_categ <> var_categoria_bioquimico then
   raise exception 'nao permitido';
 else 
      return new;   
 end if;
 
  exception
   when raise_exception then
     raise notice 'Funcionario não permitido'
     using hint='Por favor, insira o id de um bioquimico ou biomedico';
     
 end;
 $$ language plpgsql;

  create trigger update_bio before update
  of id_bio on atendimento
 for each row  execute procedure atualiza_bio();


/*trigger 5 */
/*trigger que permite a inserção da view ExameMetodoMaterial */
create or replace function insere_view_exame_metodo_material () returns trigger
as $$
declare
codmet metodo.id_met%type;
codmat material.id_mat%type;
begin

select into  codmet  id_met from metodo
where nome like new.metodo;

select into  codmat id_mat  from material
where nome like new.material;

        if codmat is null and codmet is null then
	  raise notice 'Material e metodo não encontrado';
	  
	  insert into metodo values (default, new.metodo);
	  
	  select into codmet  id_met from metodo
	  where nome like new.metodo;

	  insert into material values (default, new.material);

	  select into codmat id_mat  from material
	  where nome like new.material;

	  insert into exame  values (default, new.exame, new.valor, codmat, codmet);
	  return new;
	  
	elsif codmat is null then
	  raise notice 'material não encontrado';
	  insert into material values (default, new.material);

	  select into codmat id_mat  from material
	  where nome like new.material;

	  insert into exame  values (default, new.exame, new.valor, codmat, codmet);
	  return new;

	elsif codmet is null then

	  raise notice 'metodo não encontrado';
	  
	  insert into metodo values (default, new.metodo);
	  
	  select into codmet  id_met from metodo
	  where nome like new.metodo;

	  insert into exame  values (default, new.exame, new.valor, codmat, codmet);
	  return new;

	else
	  raise notice 'material e metodos encontrados';
	  insert into exame  values (default, new.exame, new.valor, codmat, codmet);

        end if;

end;
$$ language plpgsql;

create trigger insere_view instead of insert on ExameMetodoMaterial
for each row execute procedure insere_view_exame_metodo_material();

insert into ExameMetodoMaterial values ('merlonina','metodojohn','materialnew',70);

insert into ExameMetodoMaterial values ('gravidez','metodobalotales','materialnew',70);

insert into ExameMetodoMaterial values ('testehiv','metodobalotales','materialtales',70);

