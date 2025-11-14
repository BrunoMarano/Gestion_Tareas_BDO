USE gestion_proyecto;
GO

CREATE FUNCTION fn_ContarComentariosPorTarea (
    @id_tarea INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Conteo INT;

    SELECT @Conteo = COUNT(*)
    FROM comentario
    WHERE id_tarea = @id_tarea;

    RETURN @Conteo;
END;
GO