USE gestion_proyecto;
GO

--	Cuenta el número total de comentarios que se han hecho en una tarea específica.
CREATE FUNCTION fn_ContarComentariosPorTarea (
    @id_tarea INT --	El parametro seguido del tipo de dato
)
RETURNS INT --  El tipo de valor que retorna
AS
BEGIN
    DECLARE @Conteo INT;  --	Realiza cálculos

    SELECT @Conteo = COUNT(*)
    FROM comentario
    WHERE id_tarea = @id_tarea;

    RETURN @Conteo;
END;
GO