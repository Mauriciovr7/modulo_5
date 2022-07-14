create table pokemones (
    pokedex int primary key,
    nombre varchar(10) not null,
    tipo1 varchar(10) not null,
    tipo2 varchar(10)    
);

create table mis_pokemones (
    id serial primary key,
    pokedex int, -- fkey
    fecha_captura date not null,
    lugar varchar(20),
    huevo bool,
    peso float,
    estatura float,
    foreign key (pokedex) references pokemones(pokedex)
);

-- A. Listar los pokemones cuya columna pokédex sea mayor a 50.
select nombre, peso from pokemones
join mis_pokemones
on mis_pokemones.pokedex = 50;
-- B. Listar pokemones de tipo psíquico
select nombre from pokemones
where tipo1 = 'psiquico' OR tipo2 = 'psiquico';
-- C. Listar los primeros 22 registros de la tabla pokemones.
select pokedex, nombre from pokemones limit 22;
-- consulta a la tabla pokemones donde la columna nombre
-- tenga un alias “pokename” y pokédex tenga el alias “nro_pokedex”. La consulta debe
-- obtener como límite 30 registros
select pokemones.pokedex AS nro_pokedex, pokemones.nombre AS pokename
from pokemones limit 30;
-- consulta para saber cuántos registros se tienen en la tabla
-- pokemones. Ocupe el comando COUNT para esto
select COUNT (pokedex) AS total_pokes from pokemones;
-- consulta para saber cuántos pokemones tienen como segundo
-- tipo, el tipo roca en la tabla pokemones.
select * from pokemones where tipo2 = 'roca';