-- SCRIPT TEMA "nombre del tema"
-- DEFINNICIÓN DEL MODELO DE DATOS
CREATE DATABASE gestion_proyecto;
GO

USE gestion_proyecto;
GO 

CREATE TABLE usuario
(
  id_usuario INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(200) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  CONSTRAINT PK_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT UQ_usuario_email UNIQUE (email)
);
GO

CREATE TABLE proyecto
(
  id_proyecto INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200),
  fecha_creacion DATE NOT NULL,      
  fecha_fin DATE,
  CONSTRAINT PK_proyecto PRIMARY KEY (id_proyecto),
  CONSTRAINT DF_proyecto_fecha_creacion DEFAULT GETDATE(),
  CONSTRAINT CK_proyecto_fechas CHECK (fecha_creacion <= fecha_fin OR fecha_fin IS NULL)
);
GO

CREATE TABLE estado
(
  id_estado INT IDENTITY (1,1) NOT NULL,
  tipo_estado VARCHAR(50) NOT NULL,
  CONSTRAINT PK_estado PRIMARY KEY (id_estado)
);
GO

CREATE TABLE tarea
(
  id_tarea INT IDENTITY(1,1) NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  descripcion VARCHAR(200),
  fecha_creacion DATE NOT NULL, 
  fecha_vencimiento DATE,
  id_proyecto INT NOT NULL,
  id_responsable INT NOT NULL,
  id_estado INT NOT NULL,
  CONSTRAINT PK_tarea PRIMARY KEY (id_tarea),
  CONSTRAINT FK_tarea_proyecto FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
  CONSTRAINT FK_tarea_usuario FOREIGN KEY (id_responsable) REFERENCES usuario(id_usuario),
  CONSTRAINT FK_tarea_estado FOREIGN KEY (id_estado) REFERENCES estado(id_estado),
  CONSTRAINT DF_tarea_fecha_creacion DEFAULT GETDATE(),
  CONSTRAINT CK_tarea_fechas CHECK (fecha_creacion <= fecha_vencimiento OR fecha_vencimiento IS NULL)
);
GO

CREATE TABLE categoria
(
  id_categoria INT IDENTITY(1,1) NOT NULL,
  tipo_categoria VARCHAR(50) NOT NULL,
  CONSTRAINT PK_categoria PRIMARY KEY (id_categoria)
);
GO

CREATE TABLE rol
(
  id_rol INT IDENTITY(1,1) NOT NULL,
  tipo_rol VARCHAR(50) NOT NULL,
  CONSTRAINT PK_rol PRIMARY KEY (id_rol)
);
GO

CREATE TABLE comentario
(
  id_comentario INT IDENTITY(1,1) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  fecha_comentario DATE NOT NULL,		
  id_tarea INT NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT PK_comentario PRIMARY KEY (id_comentario),
  CONSTRAINT FK_comentario_tarea FOREIGN KEY (id_tarea) REFERENCES tarea(id_tarea),
  CONSTRAINT DF_comentario_fecha_comentario DEFAULT GETDATE(),
  CONSTRAINT FK_comentario_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);
GO

CREATE TABLE asignacion
(
  id_usuario INT NOT NULL,
  id_proyecto INT NOT NULL,
  id_rol INT NOT NULL,
  CONSTRAINT PK_asignacion PRIMARY KEY (id_usuario, id_proyecto),
  CONSTRAINT FK_asignacion_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT FK_asignacion_proyecto FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
  CONSTRAINT FK_asignacion_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);
GO

CREATE TABLE tarea_categoria
(
  id_categoria INT NOT NULL,
  id_tarea INT NOT NULL,
  CONSTRAINT PK_tarea_categoria PRIMARY KEY (id_categoria, id_tarea),
  CONSTRAINT FK_tarea_categoria_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
  CONSTRAINT FK_tarea_categoria_tarea FOREIGN KEY (id_tarea) REFERENCES tarea(id_tarea)
);
GO
SELECT name 
FROM sys.tables
ORDER BY name;