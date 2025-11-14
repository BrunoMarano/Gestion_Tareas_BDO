USE gestion_proyecto;
GO

CREATE PROCEDURE sp_InsertarTarea
    @titulo VARCHAR(150),
    @descripcion VARCHAR(200),
    @fecha_vencimiento DATE,
    @id_proyecto INT,
    @id_responsable INT,
    @id_estado INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tarea (
        titulo,
        descripcion,
        fecha_vencimiento,
        id_proyecto,
        id_responsable,
        id_estado
    )
    VALUES (
        @titulo,
        @descripcion,
        @fecha_vencimiento,
        @id_proyecto,
        @id_responsable,
        @id_estado
    );

    SELECT SCOPE_IDENTITY() AS Nuevo_ID_Tarea;
END;
GO