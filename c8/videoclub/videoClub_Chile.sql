drop table if exists peliculas;
create table peliculas(
    cod serial primary key,
    titulo varchar(255) not null,
    anio int not null
);

create table clientes(
    rut varchar(12) not null  primary key,
    nombre varchar(255) not null
);

create table directores(
    id serial primary key,
    nombre varchar (255) not null
);

drop table if exists alquileres;
create table alquileres( 
    fecha_arriendo date not null default now(),
    fecha_devolucion date not null,
    cliente_rut varchar(12) not null references clientes(rut) on delete cascade,
    pelicula_cod int not null references peliculas(cod) on delete cascade ,
    primary key(cliente_rut, pelicula_cod)
);

-- tabla intermedia
create table directores_peliculas(
    director_id int not null references directores(id) on delete cascade,
    pelicula_cod int not null references peliculas(cod) on delete cascade,    
    primary key (director_id, pelicula_cod)
);

-- insertando datos de ejemplo
insert into  peliculas(titulo, anio) 
values('Avatar', 2009),
      ('Star Wars: Episodio VII',2015),
      ('Avengers: Infinity war', 2018),
      ('Titanic', 1997),
      ('Avengers:Endgame', 2019); 
       
insert into directores(nombre)
values('Russo,A.'),
      ('Russo,J.'),
      ('Cameron,J.'),
      ('Abrams,J.')

insert into clientes(rut,nombre)
values('15.654.685-5', 'Gonzalez Gomez, Juan'),
      ('11.654.655-0', 'Juvenal Pereira, James'),
      ('05.584.685-k', 'Garcia Soto, Rosa'),
      ('10.111.685-7', 'Sanchez Molina, Ana')
      
insert into directores_peliculas(director_id, pelicula_cod)
values(3,6), 
      (4,7),
      (1,8),
      (2,8),
      (3,9),
      (1,10),
      (2,10);

-- transacciones
begin transaction;
insert into alquileres (fecha_devolucion, cliente_rut, pelicula_cod)
values('2022-07-25','11.654.655-0',1),
      ('2022-07-30','10.111.685-7',2),
      ('2022-07-27','11.654.655-0',3),
      ('2022-07-29','05.584.685-k',4),
      ('2022-08-01','15.654.685-5',5);
commit;

rollback;

-- forzamos eliminacion de datos de la tabla peliculas
truncate peliculas cascade;

-- listado de peliculas y nombre director 
select titulo, nombre
from peliculas
join directores_peliculas on peliculas.cod = pelicula_cod
join directores on directores.id = director_id;

select*from peliculas;
select*from clientes;
select*from directores;
select*from alquileres;
select*from directores_peliculas;