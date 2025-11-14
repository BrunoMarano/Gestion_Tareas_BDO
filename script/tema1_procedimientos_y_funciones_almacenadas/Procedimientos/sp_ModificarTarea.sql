USE gestion_proyecto;
GO

CREATE PROCEDURE sp_ModificarTarea
    @id_tarea INT, 
    @titulo VARCHAR(150),
    @descripcion VARCHAR(200),
    @fecha_vencimiento DATE,
    @id_proyecto INT,
    @id_responsable INT,
    @id_estado INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE tarea
    SET
        titulo = @titulo,
        descripcion = @descripcion,
        fecha_vencimiento = @fecha_vencimiento,
        id_proyecto = @id_proyecto,
        id_responsable = @id_responsable,
        id_estado = @id_estado
    WHERE
        id_tarea = @id_tarea; 
END;
GO