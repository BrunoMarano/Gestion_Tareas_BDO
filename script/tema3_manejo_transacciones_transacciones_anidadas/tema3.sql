USE gestion_tareas;

/*Escribir el código Transact SQL que permita definir una transacción consistente en:
Insertar un registro en alguna tabla, luego otro registro en otra tabla 
y por último la actualización de uno o más registros en otra tabla. 
Actualizar los datos solamente si toda la operación es completada con éxito.*/

BEGIN TRY
	BEGIN TRANSACTION -- Inicia la transaccion principal

	-- Insertar un nuevo usuario
	INSERT INTO  usuario (id_usuario, nombre, email, contrasena)
	VALUES (1, 'Franco Diaz', 'francobdz@gmail.com', '1234');

	-- Insertar un nuevo proyecto
	INSERT INTO proyecto (id_proyecto, nombre, descripcion, fecha_creacion, fecha_fin)
	VALUES (1, 'Sistema de gestión', 'Proyecto para la gestion de tareas', GETDATE(), NULL);

	-- Actualizar el nombre del proyecto (solo se confirma si todo lo anterior salió bien)
	UPDATE proyecto
	SET nombre = 'Sistema de Gestión de Proyectos'
	WHERE id_proyecto = 1;

	COMMIT TRANSACTION; --Confirma todo si hubo errores
	PRINT 'Transacción completada correctamente.';
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION; --Revierte todo si ocurre un error
	PRINT 'Error detectado. Se revierte la transacción.';
	PRINT ERROR_MESSAGE();
END CATCH;

/*Sobre el código escrito anteriormente provocar intencionalmente un error luego del insert 
y verificar que los datos queden consistentes (No se debería realizar ningún insert).*/


/* Transacción principal con SAVEPOINT (transacción anidada) */
BEGIN TRY
	BEGIN TRANSACTION;   -- Inicia la transacción principal

    -- Insertar un nuevo usuario (válido)
	INSERT INTO usuario (id_usuario, nombre, email, contrasena)
    VALUES (101, 'Enzo Barrios', 'enzobarrios@gmail.com', 'abcd');

	PRINT 'Usuario insertado correctamente';

	-- Crear un SAVEPOINT antes de una posible falla
	SAVE TRANSACTION transaccion_anidada;
	PRINT 'SAVEPOINT creado correctamente';

	-- Insertar otro usuario con email repetido → provocará un error
	INSERT INTO usuario (id_usuario, nombre, email, contrasena)
	VALUES (102, 'Bruno Marano', 'enzobarrios@gmail.com', '1234');

	PRINT 'Segundo usuario insertado correctamente';

	-- Esta actualización no debería ejecutarse si se produjo error antes
	UPDATE proyecto
	SET descripcion = 'Actualización despues del error'
	WHERE id_proyecto = 100;

	COMMIT TRANSACTION;
	PRINT 'TRANSACCIÓN COMPLETADA (no debería verse si hay error).';
END TRY

BEGIN CATCH
	PRINT 'Error detectado.';

	-- Volvemos al SAVEPOINT (transacción hija)
	ROLLBACK TRANSACTION transaccion_anidada;
	PRINT 'Se realizó rollback SOLO al SAVEPOINT, no a la transacción completa.';

	-- Finalmente revertimos toda la transacción principal
	ROLLBACK TRANSACTION;
	PRINT 'Se revirtió también la transacción principal.';

	PRINT ERROR_MESSAGE();
END CATCH;
GO
