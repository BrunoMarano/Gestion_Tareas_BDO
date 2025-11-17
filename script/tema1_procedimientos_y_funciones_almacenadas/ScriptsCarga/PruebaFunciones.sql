USE gestion_proyecto;
GO

--  Prueba de consultas de Funciones Almacenadas

--	Mediante un select seguido del nombre de la funcion con el parametro
--  Cuenta el número total de comentarios que se han hecho en una tarea específica. 
SELECT dbo.fn_ContarComentariosPorTarea(1) AS 'Total_Comentarios_Tarea_1';
SELECT dbo.fn_ContarComentariosPorTarea(2) AS 'Total_Comentarios_Tarea_2';
SELECT dbo.fn_ContarComentariosPorTarea(4) AS 'Total_Comentarios_Tarea_4';

--  Muestra un listado detallado de las tareas de un proyecto específico.
SELECT * FROM dbo.fn_ObtenerDetalleTareasPorProyecto(1);
SELECT * FROM dbo.fn_ObtenerDetalleTareasPorProyecto(2);

-- --  Calcula los días restantes para la fecha de vencimiento de una tarea.
SELECT 
    titulo,
    fecha_vencimiento,
    dbo.fn_DiasParaVencimiento(fecha_vencimiento) AS 'Dias_Restantes'
FROM 
    tarea;