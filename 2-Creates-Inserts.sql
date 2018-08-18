
/*tabela categoria */
CREATE TABLE categoria(
id_categ serial not null,
nome varchar(20) not null,
salario numeric not null,
constraint PK_categoria PRIMARY KEY(id_categ),
constraint CK_categoria_salario CHECK (salario >0));




/*tabela funcionario */
CREATE TABLE Funcionario(
id_func serial not null,
nome varchar(45) not null,
login varchar(20) not null,
senha varchar(20) not null,
rg int not null,
cpf varchar(12) not null,
sexo varchar(1) not null,
cidade varchar,
estcivil varchar(1),
data_nasc date not null,
data_adm date not null,
id_categ int not null,
constraint PK_funcionario PRIMARY KEY(id_func),
constraint AK_funcionario_login UNIQUE(login),
constraint AK_funcionario_senha UNIQUE(senha),
constraint CK_funcionario_sexo CHECK(sexo in('F','M')),
constraint AK_funcionario_rg UNIQUE (rg),
constraint AK_funcionario_cpf UNIQUE(cpf),
--constraint CK_funcionario_cpf CHECK (cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
constraint CK_paciente_estcivil CHECK (estcivil in('S','C','D','V','O')),
constraint CK_funcionario_data_nasc CHECK (extract (year from data_nasc)>18),
constraint CK_funcionario_data_adm CHECK (data_adm <= now()),
constraint FK_funcionario_categoria FOREIGN KEY(id_categ) references
Categoria);


/*tabela telefone */
CREATE TABLE telefone(
num varchar(12) not null,
id_func int not null,
constraint PK_telefone PRIMARY KEY(num, id_func),
constraint FK_telefone_funcionario FOREIGN KEY (id_func)
references Funcionario);


/*tabela paciente */
CREATE TABLE Paciente(
id_pac serial not null,
nome varchar(45) not null,
login varchar(20) not null,
senha varchar(20) not null,
cpf varchar(12) not null,
rg int not null,
email  varchar(45),
cep varchar(8) null,
bairro varchar(20) null,
rua varchar(30) null,
num int null,
uf varchar(2) not null,
cidade varchar(20) not null,
sexo varchar(1) not null,
estcivil varchar(1),
data_nasc date not null,
constraint PK_paciente PRIMARY KEY(id_pac),
constraint AK_paciente_login UNIQUE(login),
constraint AK_paciente_senha UNIQUE(senha),
constraint AK_paciente_rg UNIQUE (rg),
constraint AK_paciente_cpf UNIQUE(cpf),
--constraint CK_paciente_cpf CHECK (cpf LIKE '[0-9] [0-9][0-9] [0-9] [0-9] [0-9] [0-9][0-9] [0-9] [0-9] [0-9]'),
constraint CK_paciente_cep CHECK (length(cep) =8),
constraint CK_paciente_uf CHECK (length(uf) = 2),
constraint CK_paciente_sexo CHECK(sexo in('F','M')),
constraint CK_paciente_estcivil CHECK (estcivil in('S','C','D','V','O')),
constraint CK_paciente_data_nasc CHECK 
(extract (year from data_nasc)>18));


/*tabela telefone_pac */
CREATE TABLE telefone_pac(
num varchar(12) not null,
id_pac int not null,
constraint PK_telefone_pac PRIMARY KEY(num, id_pac),
constraint FK_telefone_paciente FOREIGN KEY (id_pac)
references Paciente);


/*Tabela convenio */
create table convenio (
id_conv serial not null,
nome varchar(45) not null,
constraint PK_convenio PRIMARY KEY (id_conv));



/*Tabela paciente_convenio */
create table paciente_convenio(
id_pac int not null,
id_conv int not null,
data_validade date not null,
constraint PK_paciente_convenio PRIMARY KEY (id_pac, id_conv),
constraint FK_paciente_convenio_paciente FOREIGN KEY(id_pac)
references paciente,
constraint FK_paciente_convenio_convenio FOREIGN KEY(id_conv)
references convenio,
constraint CK_paciente_convenio_data_validade CHECK (data_validade>= now()));




/*tabela material */
create table material (
id_mat serial not null,
nome varchar(30) not null,
constraint AK_material_nome UNIQUE (nome),
constraint PK_maerial PRIMARY KEY (id_mat));

/*tabela metodo */
create table metodo (
id_met serial not null,
nome varchar(30) not null,
constraint AK_metodo_nome UNIQUE (nome),
constraint PK_metodo PRIMARY KEY (id_met));

/*tabela Exame */
create table exame (
id_exame serial not null,
nome varchar(30) not null,
valor numeric not null,
id_mat int not null,
id_met int null,
constraint PK_exame PRIMARY KEY (id_exame),
constraint AK_exame_nome UNIQUE (nome),
constraint CK_exame_valor CHECK(valor>0),
constraint FK_exame_material FOREIGN KEY (id_mat)
references material,
constraint FK_exame_metodo FOREIGN KEY (id_met)
references metodo);

/*tabela atendimento */
create table atendimento (
id_exame int not null,
id_pac int not null,
data_hora date not null,
descricao varchar(100) null,
id_enf int null,
id_bio int null,
constraint PK_atendimento PRIMARY KEY(id_exame, id_pac, data_hora),
constraint FK_atendimento_exame FOREIGN KEY (id_exame)
references exame,
constraint FK_atendimento_paciente FOREIGN KEY (id_pac)
references paciente,
constraint FK_atendimento_enfermeiro FOREIGN KEY (id_enf)
references Funcionario,
constraint FK_atendimento_biomedico_bioquimico FOREIGN KEY
(id_bio) references funcionario);

/*inserções categoria*/
insert into categoria values (default, 'Gerente', 4.000);
insert into categoria values (default, 'Atendente', 1.000);
insert into categoria values (default, 'Enfermeiro', 2.000);
insert into categoria values (default, 'Biomedico', 3.500);
insert into categoria values (default, 'Bioquimico', 3.500);

/*inserções Funcionarios */
insert into funcionario values (default, 'Neil Johns', 'neil', 'pistoneil123',321562,'01463227469','M','Joao Pessoa','S','1988-02-14','2017-05-23',1);
insert into funcionario values (default, 'Jorge Nunes', 'jorge', 'jorge123',371762,'01768297469','M','Ferreiros','S','1982-04-17','2015-07-25',2);
insert into funcionario values (default, 'Amanda Freitas', 'amanda', 'amanda123',581762,'01968797969','F','Santa Rita','C','1988-01-01','2016-01-05',2);
insert into funcionario values (default, 'Kamila Freitas', 'kamila', 'kamila123',451792,'01912397419','F','Campina Grande','S','1988-06-20','2016-06-20',3);
insert into funcionario values (default, 'Daniela almeida', 'dani', 'dani123',772792,'07785669855','F','Florianópolis','D','1985-02-25','2015-07-27',3);
insert into funcionario values (default, 'Carol Barros', 'carol', 'carol123',321566,'07785663214','F','Recife','C','1992-08-20','2015-01-20',4);
insert into funcionario values (default, 'Sergio Busquets', 'busquets', 'busquets123',778855,'02225898752','M','Recife','C','1990-02-25','2014-08-25',4);
insert into funcionario values (default, 'Yane Vasquez', 'yane', 'yane123',225588,'07585963221','F','Sao Paulo','S','1989-02-24','2017-08-20',5);
insert into funcionario values (default, 'Antoni Griezman', 'griezman', 'griezman123',665588,'01463589662','M','Rio de Janeiro','S','1987-02-10','2014-08-10',5);

/*inserções telefones */
insert into telefone values ('98858-1383',1);
insert into telefone values ('99895-9293',1);
insert into telefone values ('98528-2526',2);
insert into telefone values ('98525-3366',3);
insert into telefone values ('99925-2445',3);
insert into telefone values ('98858-1383',4);
insert into telefone values ('98609-6082',5);
insert into telefone values ('98254-2445',6);
insert into telefone values ('99925-4885',6);
insert into telefone values ('98825-0202',7);
insert into telefone values ('98905-6036',8);
insert into telefone values ('99885-2513',9);

/*inserções pacientes */
insert into paciente values (default, 'Gel Guimarães', 'gel', 'gel123','07862589632',345866,'gel123@gmail.com','58085000','bancarios','r. das flores',625,'PB','João Pessoa','M','C','1988-02-14');
insert into paciente values (default, 'Mohamed Salah', 'salah', 'salah123','08526547885',385874,'salah478@gmail.com','85084555','torre','r. das neves',125,'PB','João Pessoa','M','C','1990-01-15');
insert into paciente values (default, 'James Rodrigues', 'james', 'james123','07458996525',323336,'james123@gmail.com','85085666','expedcionarios','r. das rosas',620,'PB','João Pessoa','M','S','1992-04-15');
insert into paciente values (default, 'Cristiano Ronaldo', 'cr7', 'cr7123','01465228596',458522,'cr7@gmail.com','54789666','mangabeira','r. desembargador guedes',123,'PB','João Pessoa','M','S','1980-04-15');
insert into paciente values (default, 'Neymar Jr.', 'neymar', 'neymar123','017850888',442850,'neymar123@gmail.com','50085000','jaguaribe','r. tenende antonio',622,'PB','João Pessoa','M','S','1991-02-14');
insert into paciente values (default, 'Kun Aguero', 'aguero', 'aguero123','015852222',336996,'aguero@gmail.com','50850632','bairro nobre','r. antono guedes',620,'PB','João Pessoa','M','S','1985-02-17');
insert into paciente values (default, 'Lionel Messi', 'messi', 'messi23','01585225869',303022,'messi@gmail.com','54084000','bancarios','r. linda',647,'PB','João Pessoa','M','C','1984-02-14');
insert into paciente values (default, 'Paolo Guerrero', 'guerrero', 'guerrero123','09585221422',303021,'guerrero@gmail.com','54084002','rua do rio','r. do barro',620,'PB','João Pessoa','M','S','1984-07-14');
insert into paciente values (default, 'Mariana Ximenes', 'mari', 'mari123','02522485223',377885,'mari123@gmail.com','54085006','jacarape','r. sr antonio',601,'PB','João Pessoa','F','C','1982-02-17');
insert into paciente values (default, 'Renata Fan', 'renata', 'renata123','01325885225',374852,'renatafan@gmail.com','58047000','bessa','r. das cinzas',689,'PB','João Pessoa','M','C','1980-02-14');


/*inserções tabela telefone_pac */
/*inserções telefones */
insert into telefone_pac values ('98755-1383',1);
insert into telefone_pac values ('99815-9213',1);
insert into telefone_pac values ('98888-2526',2);
insert into telefone_pac values ('98525-3435',3);
insert into telefone_pac values ('99925-3738',3);
insert into telefone_pac values ('98858-1485',4);
insert into telefone_pac values ('98609-7012',5);
insert into telefone_pac values ('98254-8025',6);
insert into telefone_pac values ('99925-4052',6);
insert into telefone_pac values ('98825-2058',7);
insert into telefone_pac values ('98905-9058',8);
insert into telefone_pac values ('99885-7525',9);

/*inserções convenio */
insert into convenio values(default,'Unimed');
insert into convenio values(default,'Unimed');
insert into convenio values(default,'Hap Vida');
insert into convenio values(default,'Plano mais Vida');
insert into convenio values(default,'Up');

/*inserções paciente_convenio*/
insert into paciente_convenio values (1,1,'2018-12-02');
insert into paciente_convenio values (1,2,'2019-11-02');
insert into paciente_convenio values (3,1,'2020-10-02');
insert into paciente_convenio values (4,3,'2020-06-02');
insert into paciente_convenio values (4,4,'2019-04-02');
insert into paciente_convenio values (6,1,'2020-06-02');
insert into paciente_convenio values (8,3,'2020-10-02');
insert into paciente_convenio values (10,1,'2020-07-02');
/*paciente 2,5, 7 e 9 não tem planos */

/*inserções material*/
insert into material values(default,'material 1');
insert into material values(default,'material 2');
insert into material values(default,'material 3');
insert into material values(default,'material 4');
insert into material values(default,'material 5');
insert into material values(default,'material 6');
insert into material values(default,'material 7');
insert into material values(default,'material 8');

/*inserções metodo*/
insert into metodo values(default,'metodo marloniano');
insert into metodo values(default,'metodo johnoniano');
insert into metodo values(default,'metodo talesman');
insert into metodo values(default,'metodo pahnoniano');
insert into metodo values(default,'metodo bico doce');
insert into metodo values(default,'metodo Kamila tqr');
insert into metodo values(default,'metodo Rafael sucesso');
insert into metodo values(default,'metodo frustracao');

/*inserções exame*/
insert into exame values(default,'sangue',50,1,1);
insert into exame values(default,'urina',100,2,2);
insert into exame values(default,'feze',110,3,3);
insert into exame values(default,'leucocitos',120,4,4);
insert into exame values(default,'hemacias',130,5,5);
insert into exame values(default,'licose',140,6,6);
insert into exame values(default,'colesterol',150,7,7);
insert into exame values(default,'acido urico',160,8,8);
