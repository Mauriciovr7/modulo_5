drop table if exists clientes;
create table clientes(
    id serial primary key,
    nombre varchar(255) not null,
    rut varchar(12) not null,
    direccion varchar(255)
);

drop table if exists categorias;
create table categorias(
    id serial primary key,
    nombre varchar(255) not null,
    descripcion varchar(255)
);

drop table if exists facturas;
create table facturas(
    numero serial primary key,
    fecha date not null default now(),
    subtotal int not null,
    iva float not null,
    total int not null,
    cliente_id int not null references clientes(id) on delete cascade
);

drop table if exists productos;
create table productos(
    id serial primary key,
    nombre varchar(255) not null,    
    stock int not null,    
    valor_unitario int not null,
    descripcion varchar(255),
    categoria_id int not null references categorias(id) on delete cascade 
);

drop table if exists lista_productos;
create table lista_productos(
    factura_numero int not null,
    producto_id int not null,
    cantidad int not null default 1,    
    foreign key (factura_numero) references facturas(numero) on delete cascade,
    foreign key (producto_id) references productos(id) on delete cascade,
    primary key (factura_numero,producto_id)
    --valor_total int not null,
);


--
insert into clientes (nombre, rut)
values ('Axel Ferreira', '4152132-8'),
        ('juan Ferreira', '4152132-8'),
        ('andres Ferreira', '4152132-8');
        
select * from clientes;
--
insert into categorias (nombre)
values ('electrohogar'),
        ('lineablanca');
        
select * from categorias;
--
insert into productos (nombre, stock, valor_unitario, categoria_id)
values ('microondas', 1000, 50000, 2),
        ('tv', 2000, 450000, 1),
        ('sanguchera', 4500, 10000, 2),
        ('control', 10000, 500, 1),
        ('nintendo', 100, 150000, 1);
        
select * from productos;

select * from clientes;
select * from categorias;
select * from productos;
select * from facturas;

-- transacciones
begin transaction;
insert into facturas (subtotal, iva, total, cliente_id)
values (390000,0.19,464100,1); -- es del ejemplo
insert into lista_productos (factura_numero, producto_id)
values(1,1), (1,2), (1,3);
commit;
--
begin transaction;
insert into facturas (subtotal, iva, total, cliente_id)
values (40400,0.19,48076,2);
insert into lista_productos (factura_numero, producto_id)
values(2,4), (2,5);
commit;
--
begin transaction;
insert into facturas (subtotal, iva, total, cliente_id)
values (80000,0.19,95200,3);
insert into lista_productos (factura_numero, producto_id)
values(3,2);
commit;

rollback;

select * from lista_productos;
select * from facturas;


-- 5. ¿Cuál es el nombre del cliente que realizó la compra más cara?
select nombre, total from clientes
join facturas on cliente_id = clientes.id
order by total desc limit 1;

-- 6. ¿Cuáles son los nombres de los clientes que pagaron más de 60$? Considere un
-- IVA del 19%
select nombre from clientes
join facturas on cliente_id = clientes.id
where total > 60;
-- ó
select distinct nombre from clientes
join facturas on cliente_id = clientes.id
where total > 60000;

-- 7. ¿Cuántos clientes han comprado más de 5 productos? Considere la cantidad por
-- producto comprado.
select count(id) from clientes
join facturas on cliente_id = clientes.id
join lista_productos on factura_numero = facturas.numero
where cantidad > 5;
--
select count(id) from clientes
join facturas on cliente_id = clientes.id
join lista_productos on factura_numero = facturas.numero
where cantidad > 5;
