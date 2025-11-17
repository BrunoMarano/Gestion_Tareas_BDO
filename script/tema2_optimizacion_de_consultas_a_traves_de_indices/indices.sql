--Insertamos usuario, estado y proyecto para poder cargar tareas
INSERT INTO usuario (nombre, email, contrasena)
VALUES ('Test User', 'test@demo.com', '123');

INSERT INTO proyecto (nombre)
VALUES ('Proyecto test');

INSERT INTO estado (tipo_estado)
VALUES ('Pendiente');

--Tablas cargadas
SELECT * FROM usuario;
SELECT * FROM proyecto;
SELECT * FROM estado;

--|1) Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga 
--un campo fecha (sin índice). Hacerlo con un script para poder automatizarlo.


-- declaramos variables 
DECLARE @idProyecto INT = 1;
DECLARE @idUsuario INT = 1;
DECLARE @idEstado INT = 1;

;WITH N AS (
    SELECT TOP (1000000) -- Número total de registros a insertar
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO tarea (titulo, descripcion, fecha_creacion, fecha_vencimiento, id_proyecto, id_responsable, id_estado)
SELECT 
    CONCAT('Tarea_', n),
    CONCAT('Descripcion automatica ', n),
    DATEADD(DAY, -n % 2000, GETDATE()),             -- fechas distribuidas entre hoy y ~6 años atrás
    DATEADD(DAY, (n % 30), GETDATE()),              -- fecha de vencimiento futura
    @idProyecto,
    @idUsuario,
    @idEstado
FROM N;
GO

--CREO UNA TABLA tarea2 sin indices
SELECT * 
INTO tarea2
FROM tarea --- 1000020 registros

--Procedimiento almacenado para ver la metadata etc
sp_help tarea2

sp_help tarea


-- |2) Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor 
--y los tiempos de respuesta.

----------comparo con la tabla que posee indices y la que no posee indices
--------- TIEMPO DE RESPUESTA ----------------------
-- activo las estadisticas de tiempo de respuesta 
SET STATISTICS TIME ON;
SET STATISTICS IO ON;


-- consulta por periodo tabla sin indice
--TABLE SCAN
SELECT *
FROM tarea2
WHERE fecha_creacion BETWEEN '2022-01-01' AND '2022-12-31';

-- consulta por periodo tabla con indice
--INDEX SCAN
SELECT *
FROM tarea
WHERE fecha_creacion BETWEEN '2022-01-01' AND '2022-12-31';


-- desactivo la estadistica despues de observar los resultados
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;


-- |3) Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. 
-- Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

-- defino indice agrupado para la columna fecha_creacion
-- tardo 00:00:05 en crear el indice ya que debe ordernar todos los 
--registros en relacion al indice asociado a la columna fecha_venta
CREATE CLUSTERED INDEX I_fecha_creacion
ON tarea2 (fecha_creacion)

--INDEX SEEK
--tiempo de respuesta: 00:00:04
SELECT *
FROM tarea2
WHERE fecha_creacion BETWEEN '2022-01-01' AND '2022-12-31'


--INDEX SCAN
SELECT *
FROM tarea
WHERE fecha_creacion BETWEEN '2022-01-01' AND '2022-12-31'



-- |4) Borrar el índice creado
DROP INDEX I_fecha_creacion ON tarea2

-- |5) Definir otro índice agrupado sobre la columna fecha pero que además incluya las 
-- columnas seleccionadas y repetir la consulta anterior. 
-- Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

---OPCION 1 USANDO INDICE AGRUPADO
--Un índice agrupado ordena toda la tabla por las columnas definidas.
CREATE CLUSTERED INDEX I_fecha_creacion
ON tarea2 (fecha_creacion, titulo, descripcion);

--DROP INDEX I_fecha_creacion ON tarea

--OPCION 2 USANDO INDICE NO AGRUPADO CON INCLUDE PARA INCLUIR LAS COLUMNAS
--Un índice no agrupado con INCLUDE permite 
--optimizar consultas sobre columnas específicas sin reordenar la tabla.

CREATE NONCLUSTERED INDEX IX_fecha_creacion
ON tarea (fecha_creacion)
INCLUDE (titulo, descripcion);


--CONSULTA
--tiempo de respuesta 00:00:03
--INDEX SEEK
--COSTO DE BUSQUEDA EN INDEX SEEK 100%
SELECT titulo, descripcion
FROM tarea2
WHERE fecha_creacion BETWEEN '2022-01-01' AND '2022-12-31'


--tiempo de respuesta 00:00:04
--INDEX SCAN
--COSTO DE BUSQUEDA EN INDEX SCAN %100
SELECT titulo, descripcion
FROM tarea
WHERE fecha_creacion BETWEEN '2022-01-01' AND '2022-12-31'