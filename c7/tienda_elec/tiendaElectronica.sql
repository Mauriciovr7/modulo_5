create table clientes(
    id serial primary key,
    nombre varchar(255) not null,
    rut varchar(12) not null,
    direccion varchar(255) not null
);

create table categorias(
    id serial primary key,
    nombre varchar(255) not null,
    descripcion varchar(255) not null
);

create table facturas(
    numero serial primary key,
    fecha date not null,
    subtotal int not null,
    iva float not null,
    total int not null,
    cliente_id int not null references clientes(id)
);

create table productos(
    id serial primary key,
    nombre varchar(255) not null,
    descripcion varchar(255)not null,
    valor_unitario int not null,
    stock int not null,
    categoria_id int not null references categorias(id)
);

create table lista_productos(
    factura_numero int not null,
    producto_id int not null,
    cantidad int not null,
    valor_total int not null,
    foreign key (factura_numero) references facturas(numero),
    foreign key (producto_id) references productos(id),
    primary key (factura_numero,producto_id)
);

-- 5. ¿Cuál es el nombre del cliente que realizó la compra más cara?
select nombre from clientes
join facturas on cliente_id = clientes.id
where total > (select total from facturas);

-- 6. ¿Cuáles son los nombres de los clientes que pagaron más de 60$? Considere un
-- IVA del 19%
select nombre from clientes
join facturas on cliente_id = clientes.id
where total > (select total from facturas where total > 60);

-- 7. ¿Cuántos clientes han comprado más de 5 productos? Considere la cantidad por
-- producto comprado.
select sum(nombre) from clientes
join facturas on cliente_id = clientes.id
join lista_productos on factura_numero = facturas.numero
where cantidad > 5;