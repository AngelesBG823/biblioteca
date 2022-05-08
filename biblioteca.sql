\c angelesbg823
DROP DATABASE biblioteca;
CREATE DATABASE biblioteca;
\c biblioteca

CREATE TABLE libros(
    isbn SERIAL,
    titulo VARCHAR(30),
    codigo_autor SERIAL,
    numero paginas SMALLINT,
    PRIMARY KEY(isbn)
);

CREATE TABLE socios(
    rut VARCHAR(10),
    nombre VARCHAR(40),
    apellido VARCHAR(40),
    direccion VARCHAR(80),
    telefono INT,
    PRIMARY KEY (rut)
)

CREATE TABLE autor(
    codigo_autor SERIAL,
    nombre_autor VARCHAR(40),
    apellido_autor VARCHAR(40),
    nacimiento DATE,
    muerte DATE,
    id_libro SERIAL,
    PRIMARY KEY (codigo_autor),
    FOREIGN KEY (id_libro) REFERENCES libros(isbn)
)

CREATE TABLE tipo_autor(
    producto_editorial SERIAL,
    principal BIT NOT NULL,
    coautor BIT,
    FOREIGN KEY (producto_editorial) REFERENCES libros(isbn),
    FOREIGN KEY (codigo_autor)
)

CREATE TABLE prestamo(
    id_prestamo SERIAL,
    id_isbn SERIAL,
    id_socio VARCHAR,
    fecha_inicio DATETIME,
    fecha_devolucion DATETIME, 
    PRIMARY KEY (id_prestamo),
    FOREIGN KEY (id_isbn) REFERENCES libros(isbn),
    FOREIGN KEY (id_socio) REFERENCES socios(rut)
)
