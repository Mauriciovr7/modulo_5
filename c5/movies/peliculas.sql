drop table if exists movies;
create table movies (
    id_movie serial primary key,
    movie varchar(255) not null,
    premiere int not null,
    director varchar(255) not null
);

drop table if exists casts;
create table casts(
    id_cast int not null references movies(id_movie),
    actor varchar(255) not null
);

-- mostrando datos ingresados
select * from movies;

-- mostrando datos ingresados
select * from casts;

-- 3. Obtener el ID de la película “Titanic”.
select id_movie from movies
where movie = 'Titanic';

-- 4. Listar a todos los actores que aparecen en la película "Titanic".
select actor, movie from movies
join casts on id_cast = id_movie
where movie = 'Titanic';

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford.
select count(actor)
from casts
join movies on id_cast = id_movie
where actor = 'Harrison Ford' and id_movie <= 100;

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título
-- de manera ascendente.
select movie from movies
where premiere between 1990 and 1999
order by movie asc;

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe
-- ser nombrado para la consulta como “longitud_titulo”
select movie, length(movie) as longitud_titulo
from movies;

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
select max(length(movie))from movies;
-- otra forma , pero mas larga
select length(movie) as longitud_titulo
from movies
order by longitud_titulo desc limit 1;
