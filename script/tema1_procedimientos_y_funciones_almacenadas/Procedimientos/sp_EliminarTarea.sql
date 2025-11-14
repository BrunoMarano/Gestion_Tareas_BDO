USE gestion_proyecto;
GO

CREATE PROCEDURE sp_EliminarTarea
    @ID_Tarea INT 
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Tarea
    WHERE
        ID_Tarea = @ID_Tarea; 
END;
GO