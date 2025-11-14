USE gestion_proyecto;
GO

CREATE FUNCTION fn_ObtenerTareasPorResponsable (
    @id_responsable INT 
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        id_tarea,
        titulo,
        descripcion,
        fecha_creacion,
        fecha_vencimiento,
        id_proyecto,
        id_estado
    FROM 
        tarea
    WHERE 
        id_responsable = @id_responsable
);
GO