USE gestion_proyecto;
GO

CREATE PROCEDURE sp_EliminarTarea
    @id_tarea INT 
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM tarea
    WHERE
        id_tarea = @id_tarea; 
END;
GO