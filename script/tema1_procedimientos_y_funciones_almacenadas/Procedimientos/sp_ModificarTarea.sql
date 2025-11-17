USE gestion_proyecto;
GO

--	MODIFICAR tarea
CREATE PROCEDURE sp_ModificarTarea
    --	El/los parametro/s seguido del tipo de dato
    @id_tarea INT, 
    @titulo VARCHAR(150),
    @descripcion VARCHAR(200),
    @fecha_vencimiento DATE,
    @id_proyecto INT,
    @id_responsable INT,
    @id_estado INT
AS
BEGIN   --	Manejo de transacciones
    SET NOCOUNT ON;

    --	Operacion CRUD
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