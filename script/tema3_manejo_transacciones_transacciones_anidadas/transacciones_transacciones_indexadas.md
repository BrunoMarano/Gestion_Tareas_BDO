# Manejo de transacciones y transacciones anidadas

## 1.1 Definición de transacción

Una **transacción** es una unidad lógica de trabajo que agrupa una o varias operaciones SQL (como `INSERT`, `UPDATE` o `DELETE`) que deben ejecutarse de forma **completa o no ejecutarse en absoluto**.  
Su finalidad es mantener la **integridad** y **consistencia** de los datos dentro de la base de datos.  

Las transacciones se rigen por las propiedades **ACID**:

- **A (Atomicidad):** La transacción se ejecuta toda o no se ejecuta nada.  
- **C (Consistencia):** Garantiza que la base de datos pase de un estado válido a otro.  
- **I (Aislamiento):** Las transacciones concurrentes no interfieren entre sí.  
- **D (Durabilidad):** Los cambios confirmados se conservan incluso si el sistema falla.

---

## 1.2 Definición de transacción anidada

Una **transacción anidada** es aquella que se ejecuta dentro de otra transacción principal.  
Permite dividir una operación compleja en subtransacciones, manejando errores o validaciones específicas sin afectar el resto del proceso, siempre que la transacción principal no falle.

SQL Server soporta parcialmente este tipo de transacciones, utilizando **SAVE TRANSACTION** para crear puntos de guardado intermedios.

---

## 1.3 Diferencia entre transacción y transacción anidada

| Concepto | Transacción | Transacción anidada |
|-----------|--------------|---------------------|
| **Definición** | Conjunto de operaciones que deben completarse todas o ninguna. | Subtransacción dentro de otra transacción principal. |
| **Dependencia** | Independiente. | Depende de la transacción principal. |
| **Rollback** | Revierte toda la transacción. | Puede revertir una parte mediante `SAVE TRANSACTION`. |
| **Uso** | Operaciones completas que deben ser atómicas. | Control parcial de errores dentro de procesos complejos. |

---

## 1.4 Características

- Aseguran **consistencia y fiabilidad** en las operaciones de base de datos.  
- Pueden **confirmarse** (`COMMIT`) o **revertirse** (`ROLLBACK`) según el resultado.  
- Permiten **manejar errores** y garantizar que los datos solo se actualicen si todo el proceso tiene éxito.  
- Las transacciones anidadas pueden usar **puntos de guardado** (`SAVE TRANSACTION`) para controlar reversiones parciales.  

---

## 1.5 Crear una transacción

A continuación se muestra un ejemplo de **transacción simple** aplicada a la base de datos `gestion_proyecto`.  
En esta transacción se realizan tres operaciones consecutivas:  
1. Se inserta un nuevo usuario.  
2. Se inserta un nuevo proyecto.  
3. Se actualiza el nombre de ese proyecto.  

Si las tres operaciones se ejecutan correctamente, la transacción se confirma con `COMMIT`.  
Si ocurre un error en cualquiera de los pasos, toda la transacción se revierte con `ROLLBACK`, asegurando que **no quede ningún dato inconsistente**.

```sql
USE gestion_proyecto;
GO

BEGIN TRY;
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
```

## 1.6 Crear una transacción anidada

Ahora se muestra una transacción anidada, también sobre la base `gestion_proyecto`.
En este caso, se realiza un `INSERT` inicial de un usuario válido y luego se ejecuta una segunda operación que generará un error (la inserción de un email duplicado).  
Antes de esta operación problemática, se define un **SAVEPOINT**, lo que permite controlar qué parte de la transacción se puede revertir.

Si ocurre el error (como está diseñado), la transacción completa vuelve a su estado inicial gracias al `ROLLBACK`, garantizando que **ninguno de los inserts quede grabado**.

Este ejemplo muestra cómo una transacción anidada permite manejar fallos parciales de forma más fina utilizando puntos de guardado.
```sql
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
```
