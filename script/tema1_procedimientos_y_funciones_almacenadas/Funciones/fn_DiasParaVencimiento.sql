USE gestion_proyecto;
GO

CREATE FUNCTION fn_DiasParaVencimiento (
    @fecha_vencimiento DATE
)
RETURNS INT
AS
BEGIN
    IF @fecha_vencimiento IS NULL
        RETURN NULL;

    RETURN DATEDIFF(DAY, GETDATE(), @fecha_vencimiento);
END;
GO;