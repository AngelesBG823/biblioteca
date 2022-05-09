\c angelesbg823
DROP DATABASE biblioteca;
CREATE DATABASE biblioteca;
\c biblioteca

CREATE TABLE libros(
    isbn VARCHAR(20),
    titulo VARCHAR(30),
    codigo_autor INT,
    num_paginas INT,
    PRIMARY KEY(isbn)
);

--Tabla libros
-INSERT INTO libros(isbn, titulo, codigo_autor, num_paginas)
 VALUES ('111-1111111-111','CUENTOS DE TERROR',3,344);
 INSERT INTO libros(isbn, titulo, codigo_autor, num_paginas)
 VALUES ('111-1111111-111', 'CUENTOS DE TERROR', 4, 344);
 INSERT INTO libros(isbn, titulo, codigo_autor, num_paginas)
 VALUES ('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 1, 167);
 INSERT INTO libros(isbn, titulo, codigo_autor, num_paginas)
 VALUES ('333-3333333-333', 'HISTORIA DE ASIA', 2, 511);
 INSERT INTO libros(isbn, titulo, codigo_autor, num_paginas)
 VALUES ('444-4444444-444', 'MANUAL DE MECÁNICA', 5, 298);

 SELECT * FROM libros

--Crear tabla socios y añadir datos

CREATE TABLE socios(
    rut VARCHAR(10),
    nombre VARCHAR(40),
    apellido VARCHAR(40),
    direccion VARCHAR(80),
    telefono INT,
    PRIMARY KEY (rut)
);

INSERT INTO socios(rut, nombre, apellido, direccion, telefono)
VALUES ('1111111-1','JUAN','SOTO','Avenida 1, Santiago', 911111111);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono)
VALUES ('2222222-2','ANA','PEREZ','Pasaje 2, Santiago', 922222222);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono)
VALUES ('3333333-3','SANDRA', 'AGUILAR', 'Avenida 2, Santiago', 933333333);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono)
VALUES ('4444444-4','ESTEBAN', 'JEREZ', 'Avenida 3, Santiago', 944444444);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono)
VALUES ('5555555-5','SILVANA', 'MUÑOZ', 'Pasaje 3, Santiago', 955555555);

SELECT * FROM socios

--Crear tabla autor y añadir datos 

CREATE TABLE autor(
     cod_autor SERIAL,
     nombre_autor VARCHAR(40),
     apellido_autor VARCHAR(40),
     nacimiento DATE,
     muerte DATE,
     id_libro VARCHAR(20),
     PRIMARY KEY (cod_autor),
     FOREIGN KEY (id_libro) REFERENCES libros(isbn)
);

INSERT INTO autor(cod_autor, nombre_autor, apellido_autor, nacimiento, muerte, isbn)
VALUES(1,'ANDRÉS','ULLOA','1982','-','222-2222222-222');
INSERT INTO autor(cod_autor, nombre_autor, apellido_autor, nacimiento, muerte, isbn)
VALUES(2,'SERGIO','MARDONES', '1950','2012','333-3333333-333');
INSERT INTO autor(cod_autor, nombre_autor, apellido_autor, nacimiento, muerte, isbn)
VALUES(3,'JOSE','SALGADO','1968','2020','111-1111111-111');
INSERT INTO autor(cod_autor, nombre_autor, apellido_autor, nacimiento, muerte, isbn)
VALUES(4,'ANA','SALGADO','1972','-','111-1111111-111');
INSERT INTO autor(cod_autor, nombre_autor, apellido_autor, nacimiento, muerte, isbn)
VALUES(5,'MARTIN','PORTA','1976','-','444-4444444-444');

SELECT * FROM autor

--Tabla tipo_autor

CREATE TABLE tipo_autor(
    producto_editorial VARCHAR(20),
    codAutor SERIAL,
    tipo_autor VARCHAR(10) NOT NULL,
    FOREIGN KEY (producto_editorial) REFERENCES libros(isbn),
    FOREIGN KEY (codAutor) REFERENCES autor(cod_autor)
);


INSERT INTO tipo_autor(isbn, cod_autor, tipo_autor)
VALUES('111-1111111-111', 3,'Principal');
INSERT INTO tipo_autor(isbn, cod_autor, tipo_autor)
VALUES('111-1111111-111', 4,'Coautor');
INSERT INTO tipo_autor(isbn, cod_autor, tipo_autor)
VALUES('222-2222222-222', 1,'Principal');
INSERT INTO tipo_autor(isbn, cod_autor, tipo_autor)
VALUES('333-3333333-333', 2,'Principal');
INSERT INTO tipo_autor(isbn, cod_autor, tipo_autor)
VALUES('444-4444444-444', 5,'Principal');

--Crear tabla prestamo

CREATE TABLE prestamo(
    id_prestamo SERIAL,
    id_isbn VARCHAR(20),
    id_socio VARCHAR(10),
    fecha_inicio DATE,
    fecha_devolucion DATE, 
    PRIMARY KEY (id_prestamo),
    FOREIGN KEY (id_isbn) REFERENCES libros(isbn),
    FOREIGN KEY (id_socio) REFERENCES socios(rut)
);

INSERT INTO prestamo(id_prestamo, isbn, rut, fecha_inicio, fecha_devolucion)
VALUES( 12,'111-1111111-111','1111111-1','20/01/2020','27/01/2020');
INSERT INTO prestamo(rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES( 13,'222-2222222-222','5555555-5','20/01/2020','30/01/2020');
INSERT INTO prestamo(rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES( 14,'333-3333333-333','3333333-3','22/01/2020','30/01/2020');
INSERT INTO prestamo(rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES( 15,'444-4444444-444','4444444-4','23/01/2020','30/01/2020');
INSERT INTO prestamo(rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES( 16,'111-1111111-111','2222222-2','27/01/2020','04/02/2020');
INSERT INTO prestamo(rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES( 17,'444-4444444-444','1111111-1','31/01/2020','12/02/2020');
INSERT INTO prestamo(rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES( 18,'222-2222222-222','3333333-3','31/01/2020','12/02/2020');

-- a. Mostrar todos los libros que posean menos de 300 páginas. (0.5 puntos)
SELECT * FROM libros 
WHERE num_paginas < 300;

-- b. Mostrar todos los autores que hayan nacido después del 01-01-1970.(0.5 puntos)
SELECT * FROM autor 
WHERE nacimiento > "1970";
-- c. ¿Cuál es el libro más solicitado? (0.5 puntos).
SELECT isbn, COUNT(isbn) AS total
FROM prestamo 
GROUP BY isbn
ORDER BY total DESC;

-- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
-- (0.5 puntos)
SELECT * FROM prestamo
WHERE fecha_devolucion - fecha_inicio > 7 AS atraso *
