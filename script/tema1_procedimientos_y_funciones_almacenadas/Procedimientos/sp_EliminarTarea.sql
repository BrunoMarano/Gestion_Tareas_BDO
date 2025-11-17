USE gestion_tarea;
GO

--	BORRAR tarea
CREATE PROCEDURE sp_EliminarTarea
    @id_tarea INT 
AS
BEGIN   --  Manejo de transacciones
    SET NOCOUNT ON;

    --	Operacion CRUD
    DELETE FROM tarea
    WHERE
        id_tarea = @id_tarea; 
END;
GO