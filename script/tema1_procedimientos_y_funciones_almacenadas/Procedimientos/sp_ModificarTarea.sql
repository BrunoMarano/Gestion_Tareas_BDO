USE gestion_proyecto;
GO

CREATE PROCEDURE sp_ModificarTarea
    @ID_Tarea INT, 
    @Titulo VARCHAR(100),
    @Descripcion VARCHAR(500),
    @Fecha_Vencimiento DATE,
    @ID_Estado INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Tarea
    SET
        Titulo = @Titulo,
        Descripcion = @Descripcion,
        Fecha_Vencimiento = @Fecha_Vencimiento,
        ID_Estado = @ID_Estado
    WHERE
        ID_Tarea = @ID_Tarea; 
END;
GO