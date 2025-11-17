USE gestion_tarea;
GO

--  Muestra un listado detallado de las tareas de un proyecto específico.
CREATE FUNCTION fn_ObtenerDetalleTareasPorProyecto (
    @id_proyecto INT  -- El parámetro seguido del tipo de dato
)
RETURNS TABLE -- El tipo de valor que retorna
AS
RETURN
(
    SELECT
        t.id_tarea,
        t.titulo AS 'Titulo de la Tarea',
        u.nombre AS 'Nombre del Responsable',
        e.tipo_estado AS 'Estado'
    FROM
        tarea AS t
    INNER JOIN
        usuario AS u ON (t.id_responsable = u.id_usuario)
    INNER JOIN
        estado AS e ON (t.id_estado = e.id_estado)
    WHERE
        t.id_proyecto = @id_proyecto
);
GO