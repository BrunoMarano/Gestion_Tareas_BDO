
--Crear una vista sobre alguna tabla que solo muestre algunos campos de la misma.
CREATE VIEW vista_usuario AS 
SELECT 
	id_usuario,
	nombre,
	email
FROM usuario;
GO

--Realizar insert de un lote de datos sobre la vista reci�n creada. 
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
SET nombre = 'Franco Benjam�n D�az'
WHERE email = 'francobdz@gmail.com';
GO

--Volver a verificar el resultado en la tabla.
SELECT * FROM usuario;
GO

--Borrar todos los registros insertados a trav�s de la vista.
DELETE FROM vista_usuario
WHERE id_usuario > 0;
GO

SELECT * FROM vista_usuario;
GO

--Crear un �ndice sobre alguna de las columnas sobre la vista reci�n creada.

CREATE VIEW vista_usuario_indexada WITH SCHEMABINDING 
AS
SELECT id_usuario, nombre, email
FROM dbo.usuario;
GO

--Ver si la vista está creada:
SELECT *
FROM sys.views
WHERE name = 'vista_usuario_indexada';

--Un índice clustered en la vista significa que SQL Server guarda los datos físicamente, acelerando consultas.
CREATE UNIQUE CLUSTERED INDEX IX_vista_usuario_indexada_id ON vista_usuario_indexada (id_usuario);
GO

--Ver si tiene un índice único cluster creado:
SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('vista_usuario_indexada');


--Ver si está “materializada”
SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('vista_usuario_indexada');


SELECT * FROM vista_usuario_indexada;  --Debe devolver los datos normales.

-----------------------------------------------------------------

