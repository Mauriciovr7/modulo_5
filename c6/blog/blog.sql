drop table if exists usuarios;
CREATE TABLE usuarios(
    id_usuario serial primary key,
    email character varying(255) NOT NULL
);

drop table if exists posts;
CREATE TABLE IF NOT EXISTS posts(
    id_post serial primary key,
    usuario_id integer NOT NULL references usuarios(id_usuario),
    titulo character varying(255) NOT NULL,
    fecha date NOT NULL
);

drop table if exists comentarios;
CREATE TABLE comentarios(
    id_comentario serial primary key,
    usuario_id integer NOT NULL references usuarios(id_usuario),
    post_id integer NOT NULL references posts(id_post),    
    texto text NOT NULL,
    fecha date NOT NULL
);
   
-- ver tablas
select * from usuarios;
select * from posts;
select * from comentarios;

select * from usuarios full join posts on id_usuario = id_post;

--● Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
select email, id_post, titulo from usuarios
join posts on id_usuario = id_post
where id_usuario = 5;
--● Listar el correo, id y el detalle de todos los comentarios que no hayan sido
--realizados por el usuario con email usuario06@hotmail.com.
select email, id_comentario, texto from usuarios
join comentarios on id_usuario = id_comentario
where email = 'usuario06@hotmail.com';
--● Listar los usuarios que no han publicado ningún post.
select * from usuarios
left join posts on usuario_id = id_usuario 
where usuario_id is null;
--● Listar todos los post con sus comentarios (incluyendo aquellos que no poseen
--comentarios).
select * from posts
left join comentarios on id_post = post_id;
-- ó
select * from posts full join comentarios on id_post = post_id;
--● Listar todos los usuarios que hayan publicado un post en Junio.
select * from usuarios
join posts on id_usuario = usuario_id
where fecha between '2020-06-01' and '2020-06-30'
order by fecha asc;