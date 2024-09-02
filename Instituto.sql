IF DB_ID('instituto') IS NOT NULL
PRINT 'La base de datos ya existe'
ELSE
CREATE DATABASE instituto

ON(
NAME = 'instituto_data', 
FILENAME = 'C:\SQL\instituto\instituto.mdf', 
SIZE = 10MB, 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 5MB
)
LOG ON(
NAME = 'instituto_log', 
FILENAME = 'C:\SQL\instituto\instituto_log.ldf', 
SIZE = 5MB, 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 1MB
)
GO
--se modifica la BD se crea .ndf para distribuir carga o aumentar capacidad
ALTER DATABASE instituto
ADD FILE (
    NAME = 'instituto_data2', 
    FILENAME = 'C:\SQL\instituto\instituto_data2.ndf', 
    SIZE = 5MB, 
    MAXSIZE = 50MB, 
    FILEGROWTH = 5MB
);

USE instituto
GO

SP_HELPDB 'instituto'
GO


IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'profesor' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE profesor (
  id_profesor CHAR(10) NOT NULL PRIMARY KEY,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL
);
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'alumno' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE alumno (
  id_alumno CHAR(10) NOT NULL PRIMARY KEY,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  edad INT NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_registro DATE NOT NULL
);
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'carrera' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE carrera (
  id_carrera CHAR(10) NOT NULL PRIMARY KEY,
  nombre VARCHAR(40) NOT NULL
);
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'curso' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE curso (
  id_curso CHAR(10) NOT NULL PRIMARY KEY,
  nombre_curso VARCHAR(40) NOT NULL,
  precio INT NOT NULL
);
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'inscripcion' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE inscripcion (
  id_inscripcion CHAR(10) NOT NULL PRIMARY KEY,
  id_alumno CHAR(10) NOT NULL,
  id_carrera CHAR(10) NOT NULL,
  fecha_inscripcion DATE NOT NULL,
  FOREIGN KEY (id_alumno) REFERENCES alumno (id_alumno),
  FOREIGN KEY (id_carrera) REFERENCES carrera (id_carrera)
);
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'pension' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE pension (
  id_cotizacion CHAR(10) NOT NULL PRIMARY KEY,
  imp_compra INT NOT NULL,
  id_carrera CHAR(10) NOT NULL,
  fecha_pago DATE NOT NULL,
  id_inscripcion CHAR(10) NOT NULL,
  FOREIGN KEY (id_carrera) REFERENCES carrera (id_carrera),
  FOREIGN KEY (id_inscripcion) REFERENCES inscripcion (id_inscripcion)
);
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'carrera_curso' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE carrera_curso (
  id_carrera_curso CHAR(10) NOT NULL PRIMARY KEY,
  id_carrera CHAR(10) NOT NULL,
  id_curso CHAR(10) NOT NULL,
  FOREIGN KEY (id_carrera) REFERENCES carrera (id_carrera),
  FOREIGN KEY (id_curso) REFERENCES curso (id_curso)
);
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'catedra' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
CREATE TABLE catedra (
  id_catedra CHAR(10) NOT NULL PRIMARY KEY,
  id_profesor CHAR(10) NOT NULL,
  id_curso CHAR(10) NOT NULL,
  FOREIGN KEY (id_profesor) REFERENCES profesor (id_profesor),
  FOREIGN KEY (id_curso) REFERENCES curso (id_curso)
);
END
GO

INSERT INTO profesor (id_profesor, nombre, apellido) VALUES
('P001', 'Karen', 'Lamar'),
('P002', 'Ana Maria', 'Lee'),
('P003', 'Juan', 'Paredes'),
('P004', 'Francis', 'Martínez')
GO

INSERT INTO alumno (id_alumno, nombre, apellido, edad, fecha_nacimiento, fecha_registro) VALUES
('A001', 'Gonzalo', 'Pereyra', 28, '1996-06-22', '2022-06-01'),
('A002', 'Miguel', 'Moreno', 34, '1990-07-15', '2022-04-11'),
('A003', 'Alejandro', 'Loyola', 22, '2002-08-12', '2020-01-15'),
('A004', 'Enzo', 'Renato', 22, '2002-03-15', '2020-09-04'),
('A005', 'Santiago', 'Gucci', 28, '1996-05-29', '2021-10-07'),
('A006', 'Carolina', 'Hermes', 34, '1990-12-12', '2019-09-21'),
('A007', 'Victoria', 'Chan', 28, '1996-04-17', '2022-03-27'),
('A008', 'Vanesa', 'Carati', 22, '2002-06-09', '2019-09-01'),
('A009', 'Antonela', 'Rosas', 22, '2002-04-27', '2021-07-01'),
('A010', 'Gabriela', 'Mendez', 34, '1990-08-08', '2021-09-01')
GO

INSERT INTO carrera (id_carrera, nombre) VALUES
('C001', 'Ingenieria en Sistemas'),
('C002', 'Arquitectura'),
('C003', 'Medicina'),
('C004', 'Derecho'),
('C005', 'Psicologia'),
('C006', 'Administracion'),
('C007', 'Biologia'),
('C008', 'Quimica'),
('C009', 'Fisica'),
('C010', 'Matematicas')
GO

INSERT INTO curso (id_curso, nombre_curso, precio) VALUES
('CR001', 'Introduccion a la Programacion', 150),
('CR002', 'Estructuras 3', 200),
('CR003', 'Anatomia', 180),
('CR004', 'Derechos Humanos', 160),
('CR005', 'Psicologia para Infantes', 220),
('CR006', 'Contabilidad Basica', 190),
('CR007', 'Seguridad en el Ambiente', 170),
('CR008', 'Quimica Avanzada', 210),
('CR009', 'Física General', 250),
('CR010', 'Matrices', 230)
GO

INSERT INTO inscripcion (id_inscripcion, id_alumno, id_carrera, fecha_inscripcion) VALUES
('I001', 'A001', 'C001', '2023-09-01'),
('I002', 'A002', 'C002', '2023-09-02'),
('I003', 'A003', 'C003', '2023-09-03'),
('I004', 'A004', 'C004', '2023-09-04'),
('I005', 'A005', 'C005', '2023-09-05'),
('I006', 'A006', 'C006', '2023-09-06'),
('I007', 'A007', 'C007', '2023-09-07'),
('I008', 'A008', 'C008', '2023-09-08'),
('I009', 'A009', 'C009', '2023-09-09'),
('I010', 'A010', 'C010', '2023-09-10')
GO

INSERT INTO pension (id_cotizacion, imp_compra, id_carrera, fecha_pago, id_inscripcion) VALUES
('PE001', 1000, 'C001', '2023-09-15', 'I001'),
('PE002', 1200, 'C002', '2023-09-16', 'I002'),
('PE003', 1100, 'C003', '2023-09-17', 'I003'),
('PE004', 1300, 'C004', '2023-09-18', 'I004'),
('PE005', 1400, 'C005', '2023-09-19', 'I005'),
('PE006', 1250, 'C006', '2023-09-20', 'I006'),
('PE007', 1350, 'C007', '2023-09-21', 'I007'),
('PE008', 1450, 'C008', '2023-09-22', 'I008'),
('PE009', 1550, 'C009', '2023-09-23', 'I009'),
('PE010', 1650, 'C010', '2023-09-24', 'I010')
GO

INSERT INTO carrera_curso (id_carrera_curso, id_carrera, id_curso) VALUES
('CC001', 'C001', 'CR001'),
('CC002', 'C002', 'CR002'),
('CC003', 'C003', 'CR003'),
('CC004', 'C004', 'CR004'),
('CC005', 'C005', 'CR005'),
('CC006', 'C006', 'CR006'),
('CC007', 'C007', 'CR007'),
('CC008', 'C008', 'CR008'),
('CC009', 'C009', 'CR009'),
('CC010', 'C010', 'CR010')
GO

INSERT INTO catedra (id_catedra, id_profesor, id_curso) VALUES
('CT001', 'P001', 'CR001'),
('CT002', 'P002', 'CR002'),
('CT003', 'P003', 'CR003'),
('CT004', 'P004', 'CR004'),
('CT005', 'P001', 'CR005'),
('CT006', 'P002', 'CR006'),
('CT007', 'P003', 'CR007'),
('CT008', 'P002', 'CR008'),
('CT009', 'P004', 'CR009'),
('CT010', 'P004', 'CR010')
GO

--cambia el nombre del curso
UPDATE curso
SET nombre_curso = 'Programacion Avanzada'
WHERE id_curso = 'CR001'
SELECT * FROM curso
GO


--1 Obtener los datos de la tabla profesor con ID especifico
SELECT * FROM profesor
WHERE id_profesor = 'P003' OR id_profesor = 'P001'

--2 Nombre y apellido de alumnos mayores de 28 años
SELECT nombre, apellido, edad FROM alumno WHERE edad >= 28
ORDER BY edad ASC
GO

--3 Cursos con precio mayor o igual a 190
SELECT * FROM curso WHERE precio >= 190
ORDER BY precio desc
GO

--4 Inscripciones realizadas en el mes de septiembre de 2023
SELECT * FROM inscripcion WHERE fecha_inscripcion BETWEEN '2023-09-01' AND '2023-09-30'
GO

--5 Obtener el nombre de la carrera y el nombre del curso correspondiente
SELECT c.nombre AS Carrera, curso.nombre_curso AS Curso
FROM carrera c
JOIN carrera_curso ON c.id_carrera = carrera_curso.id_carrera
JOIN curso ON carrera_curso.id_curso = curso.id_curso
GO

--6 Nombres de alumnos y carrera en la que están inscritos
SELECT a.nombre AS Alumno, carrera.nombre AS Carrera
FROM alumno a
JOIN inscripcion i ON a.id_alumno = i.id_alumno
JOIN carrera ON i.id_carrera = carrera.id_carrera
GO

--7 Obtener los nombres de los profesores que empiecen con la letra J y A
SELECT * FROM profesor
WHERE nombre LIKE 'J%' OR nombre like 'A%'
GO

--8 Obtener los nombres y apellidos de profesores que dictan cursos con precio mayor o igual a 180
SELECT DISTINCT p.nombre AS Nombre, p.apellido AS Apellido, c.precio AS Precio
FROM profesor p
JOIN catedra ON p.id_profesor = catedra.id_profesor
JOIN curso c ON catedra.id_curso = c.id_curso
WHERE c.precio <= 180
ORDER BY precio ASC;
GO

--9 Obtener el nombre y fecha de su inscripción por Alumnos
SELECT a.nombre, i.fecha_inscripcion
FROM alumno a
JOIN inscripcion i ON a.id_alumno = i.id_alumno
ORDER BY nombre ASC;
GO

--10 Selecciona nombre de carrera que empiecen con la letra A 
SELECT * FROM carrera
WHERE nombre LIKE 'A%'
GO

-- Nombre de los alumnos que están en la carrera 'Fisica'
SELECT a.nombre AS Nombre, c.nombre AS Carrera
FROM alumno a
JOIN inscripcion i ON a.id_alumno = i.id_alumno
JOIN carrera c ON i.id_carrera = c.id_carrera
WHERE c.nombre = 'Fisica'
GO

--1 Insertar un nuevo profesor
CREATE PROCEDURE sp_InsertarProfesor
    @id_profesor CHAR(10),
    @nombre VARCHAR(20),
    @apellido VARCHAR(20)
AS
BEGIN
    INSERT INTO profesor (id_profesor, nombre, apellido)
    VALUES (@id_profesor, @nombre, @apellido);
END
GO

--2 Procedimiento para actualizar el nombre de un curso
CREATE PROCEDURE sp_ActualizarNombreCurso
    @id_curso CHAR(10),
    @nuevo_nombre VARCHAR(40)
AS
BEGIN
    UPDATE curso
    SET nombre_curso = @nuevo_nombre
    WHERE id_curso = @id_curso;
END
GO

--3 Procedimiento para eliminar un alumno por ID
CREATE PROCEDURE sp_EliminarAlumno
    @id_alumno CHAR(10)
AS
BEGIN
    DELETE FROM alumno WHERE id_alumno = @id_alumno;
END
GO

EXEC sp_EliminarAlumno @id_alumno = 'A001';
GO

--4 Procedimiento para obtener las inscripciones de un alumno por su ID
CREATE PROCEDURE sp_ObtenerInscripcionesAlumno
    @id_alumno CHAR(10)
AS
BEGIN
    SELECT * FROM inscripcion WHERE id_alumno = @id_alumno;
END
GO

--5 Procedimiento para insertar un nuevo curso
CREATE PROCEDURE sp_InsertarCurso
    @id_curso CHAR(10),
    @nombre_curso VARCHAR(40),
    @precio INT
AS
BEGIN
    INSERT INTO curso (id_curso, nombre_curso, precio)
    VALUES (@id_curso, @nombre_curso, @precio);
END
GO

--6 Procedimiento para actualizar el precio de un curso
CREATE PROCEDURE sp_ActualizarPrecioCurso
    @id_curso CHAR(10),
    @nuevo_precio INT
AS
BEGIN
    UPDATE curso
    SET precio = @nuevo_precio
    WHERE id_curso = @id_curso;
END
GO

--7 Procedimiento para insertar una nueva carrera
CREATE PROCEDURE sp_InsertarCarrera
    @id_carrera CHAR(10),
    @nombre VARCHAR(40)
AS
BEGIN
    INSERT INTO carrera (id_carrera, nombre)
    VALUES (@id_carrera, @nombre);
END
GO

--8 Procedimiento para insertar una nueva inscripción
CREATE PROCEDURE sp_InsertarInscripcion
    @id_inscripcion CHAR(10),
    @id_alumno CHAR(10),
    @id_carrera CHAR(10),
    @fecha_inscripcion DATE
AS
BEGIN
    INSERT INTO inscripcion (id_inscripcion, id_alumno, id_carrera, fecha_inscripcion)
    VALUES (@id_inscripcion, @id_alumno, @id_carrera, @fecha_inscripcion);
END
GO

--primera vista 
CREATE VIEW vista_cursos AS
SELECT * FROM curso
WHERE precio >= 200
GO

SELECT * FROM vista_cursos
GO

--segunda vista
CREATE VIEW vista_profesor AS
SELECT * FROM profesor
WHERE apellido = 'Paredes'
GO

SELECT * FROM vista_profesor
GO

--tercera vista
CREATE VIEW vista_inscripciones_sistemas AS
SELECT a.nombre, a.apellido, i.fecha_inscripcion
FROM alumno a
JOIN inscripcion i ON a.id_alumno = i.id_alumno
WHERE i.id_carrera = 'C001'
GO

--cuarta vista
CREATE VIEW vista_alumnos_basica AS
SELECT id_alumno, nombre, apellido, edad
FROM alumno
GO

SELECT * FROM vista_alumnos_basica
GO

--Quinta vista
CREATE VIEW vista_alumnos_inscripciones AS
SELECT a.nombre, i.fecha_inscripcion
FROM alumno a
JOIN inscripcion i ON a.id_alumno = i.id_alumno
GO

SELECT * FROM vista_alumnos_inscripciones
GO

--Eliminar BD
DROP DATABASE instituto
GO
