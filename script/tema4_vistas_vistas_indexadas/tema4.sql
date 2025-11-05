CREATE DATABASE proyecto_gestion_cadetes;
GO

USE proyecto_gestion_cadetes;
GO

CREATE TABLE usuario
(
  id_usuario INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(200) NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_usuario),
  UNIQUE (email)
);
GO

--Crear una vista sobre alguna tabla que solo muestre algunos campos de la misma.
CREATE VIEW vista_usuario AS 
SELECT 
	id_usuario,
	nombre,
	email
FROM usuario;
GO

--Realizar insert de un lote de datos sobre la vista recién creada. 
ALTER TABLE usuario
ADD CONSTRAINT df_usuario_password DEFAULT 'temporal123' FOR password;
GO

INSERT INTO vista_usuario (id_usuario, nombre, email)
VALUES
	(1, 'Enzo Barrios', 'enzobarrios@gmail.com'),
	(2, 'Iara Bongiovanni', 'iarabongio@gmail.com'),
	(3, 'Franco Diaz', 'francobdz@gmail.com'),
	(4, 'Bruno Marano', 'brunomarano@gmail.com');
GO

--Verificar el resultado en la tabla.
SELECT * FROM usuario;
GO 

--Realizar update sobre algunos de los registros creados 
UPDATE vista_usuario
SET nombre = 'Franco Benjamín Díaz'
WHERE email = 'francobdz@gmail.com';
GO

--Volver a verificar el resultado en la tabla.
SELECT * FROM usuario;
GO

--Borrar todos los registros insertados a través de la vista.
DELETE FROM vista_usuario
WHERE id_usuario > 0;
GO

SELECT * FROM vista_usuario;
GO

--Crear un índice sobre alguna de las columnas sobre la vista  recién creada.

CREATE VIEW vista_usuario_indexada WITH SCHEMABINDING 
AS
SELECT id_usuario, nombre, email
FROM dbo.usuario;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vista_usuario_indexada_id ON vista_usuario_indexada (id_usuario);
GO

-----------------------------------------------------------------

CREATE TABLE proyecto
(
  id_proyecto INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200),
  fecha_creacion DATE NOT NULL,
  fecha_fin DATE,
  PRIMARY KEY (id_proyecto)
);

CREATE TABLE estado
(
  id_estado INT NOT NULL,
  tipo_esatdo VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_estado)
);

CREATE TABLE tarea
(
  id_tarea INT NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  descripcion VARCHAR(200),
  fecha_creacion DATE NOT NULL,
  fecha_vencimiento DATE,
  id_proyecto INT NOT NULL,
  id_responsable INT NOT NULL,
  id_estado INT NOT NULL,
  PRIMARY KEY (id_tarea),
  FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
  FOREIGN KEY (id_responsable) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);

CREATE TABLE categoria
(
  id_categoria INT NOT NULL,
  tipo_categoria VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_categoria)
);

CREATE TABLE rol
(
  id_rol INT NOT NULL,
  tipo_rol VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_rol)
);

CREATE TABLE comentario
(
  descripcion VARCHAR(200) NOT NULL,
  fecha_comentario DATE NOT NULL,
  id_comentario INT NOT NULL,
  id_tarea INT NOT NULL,
  id_usuario INT NOT NULL,
  PRIMARY KEY (id_comentario),
  FOREIGN KEY (id_tarea) REFERENCES tarea(id_tarea),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE asignacion
(
  id_usuario INT NOT NULL,
  id_proyecto INT NOT NULL,
  id_rol INT NOT NULL,
  PRIMARY KEY (id_usuario, id_proyecto),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
  FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

CREATE TABLE tarea_categoria
(
  id_categoria INT NOT NULL,
  id_tarea INT NOT NULL,
  PRIMARY KEY (id_categoria, id_tarea),
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
  FOREIGN KEY (id_tarea) REFERENCES tarea(id_tarea)
);

