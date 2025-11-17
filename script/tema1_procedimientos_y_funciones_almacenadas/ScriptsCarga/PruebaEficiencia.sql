USE gestion_proyecto;
GO

--  Comparacion de eficiencia

--  Activacion de las estadísticas de tiempo y E/S 
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

--  OPERACIÓN DIRECTA al insertar una tarea
INSERT INTO tarea (
    titulo, 
    descripcion, 
    fecha_vencimiento, 
    id_proyecto, 
    id_responsable, 
    id_estado
) 
VALUES (
    'Tarea de Prueba Directa', 
    'Test de eficiencia INSERT', 
    '2026-01-01', 
    1,
    1,
    1  
);

-- PROCEDIMIENTO ALMACENADO al insertar una tarea 
EXEC sp_InsertarTarea
    @titulo = 'Tarea de Prueba con SP',
    @descripcion = 'Test de eficiencia EXEC',
    @fecha_vencimiento = '2026-01-01',
    @id_proyecto = 1,
    @id_responsable = 1,
    @id_estado = 1;     

-- Desactivacion de las estadísticas de tiempo y E/S
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

/*
 *  CONSULTA DIRECTA (INSERT)
 *  Análisis: La consulta directa tuvo que "pagar" un costo de parse and compile time 
 *            (tiempo de análisis y compilación) de 18 ms.
 *  
 *  Evidencia:
 *   SQL Server parse and compile time: 
 *     CPU time = 0 ms, elapsed time = 18 ms.
 *  
 *  --------------------------------------------
 *  PROCEDIMIENTO ALMACENADO (EXEC)
 *  Análisis: El Procedimiento Almacenado tardó solo 1 ms en ejecutarse porque 
 *            ya tenía un plan cacheado y se saltó el paso de compilación.
 *  
 *  Evidencia:
 *   SQL Server Execution Times:
 *     CPU time = 0 ms,  elapsed time = 1 ms.
 *  
 *  --------------------------------------------
 *  CONCLUSIÓN:
 *  El SP es más eficiente en ejecuciones repetidas al reutilizar 
 *  su plan de ejecución (evitando el costo de "parse and compile").
*/