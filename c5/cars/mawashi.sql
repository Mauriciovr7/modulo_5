create table cars (
    id serial primary key,
    brand varchar(50) not null,
    model varchar(50) not null,
    year int not null,
    color varchar(50) not null,
    price money
);

create table ventas(
    fecha date not null,
    id_car int,
    client varchar(50) not null,
    reference varchar(50) not null,
    amount varchar(50),
    pay_method varchar(50) not null
);

-- mostrando datos ingresados
select * from cars;

-- mostrando datos ingresados
select * from ventas;

-- agregando llave foranea
alter table ventas
add foreign key (id_car) references cars (id)

-- contando autos
select model, count (model)
from cars
group by model;

--juntando tablas con JOIN
select brand from cars
join ventas on cars.id = ventas.id_car; 

--seleccionando con join
select id, model 
from cars
join ventas on id = id_car;

-- 1. nombre de los clientes registrados en la tabla venta junto
-- con la marca y el modelo del auto asociado a la venta realizada
-- inner join o join
select client, brand, model 
from cars
inner join ventas on id_car = id
where id_car is not null;

-- 2. registros de la tabla Ventas con o sin
-- autos asociados.
select * from ventas
left join cars on id_car = id;

-- usando exclusive left join
-- 3. autos que no han sido vendidos.
-- todos los autos cuyos id no se encuentran en la tabla Ventas.
select brand, model 
from cars
left join ventas on id = id_car
where id_car is null;

-- 4. todos los registros de las tablas “ventas” y “autos”
select * from cars
full join ventas on id = id_car;

-- 5. registros que no tienen relación entre ambas tablas
select * from cars
full join ventas on id = id_car
where id_car is null or id is null;

-- 6. registros de la tabla Autos que tengan una
-- relación con la tabla Ventas y cuyo método de pago fue débito.
select * from cars
inner join ventas on id = id_car
where pay_method = 'debito';

-- 7.  autos que se han vendido a un precio mayor de $1.500.000
select brand, model from cars
inner join ventas on id = id_car
where price > '$1.500.000';