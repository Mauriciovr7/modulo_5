drop table if exists departamentos;
create table departamentos(
id serial primary key,
nombre varchar(255) not null);

drop table if exists locales;
create table locales(
id serial primary key,
nombre varchar(255) not null,
departamento_id integer not null,
foreign key (departamento_id) references departamentos(id));

drop table if exists proyectos;
create table proyectos(
id serial primary key,
nombre varchar(255) not null,
departamento_id integer not null,
local_id integer not null,
foreign key (departamento_id) references departamentos(id),
foreign key (local_id) references locales(id));

drop table if exists empleados;
create table empleados(
id serial primary key,
nombre varchar(50) not null,
rut varchar(12) not null,
direccion varchar(50) not null,
salario integer not null,
sexo varchar(50) not null,
fecha_nacimiento date not null,
departamento_id integer not null,
es_supervisor boolean not null,
es_administrador boolean not null,
fecha_cargo_depa date,
foreign key (departamento_id) references departamentos(id));

drop table if exists pers_depen;
create table pers_depen(
id serial primary key,
nombre varchar(50) not null,
rut varchar(12) not null,
direccion varchar(50) not null,
sexo varchar(50) not null,
fecha_nacimiento date not null,
relacion_empleado varchar(50) not null,
id_empleado integer  not null,
foreign key (id_empleado) references empleados(id));

