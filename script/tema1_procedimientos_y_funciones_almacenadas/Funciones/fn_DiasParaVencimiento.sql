USE gestion_proyecto;
GO

--  Calcula los días restantes para la fecha de vencimiento de una tarea.
CREATE FUNCTION fn_DiasParaVencimiento (
    @fecha_vencimiento DATE  -- El parámetro seguido del tipo de dato
)
RETURNS INT -- El tipo de valor que retorna
AS
BEGIN
    -- Manejo de nulos: si no hay fecha, no se puede calcular
    IF @fecha_vencimiento IS NULL
        RETURN NULL;
        
    RETURN DATEDIFF(DAY, GETDATE(), @fecha_vencimiento);  --  Realiza el cálculo
END;
GO;