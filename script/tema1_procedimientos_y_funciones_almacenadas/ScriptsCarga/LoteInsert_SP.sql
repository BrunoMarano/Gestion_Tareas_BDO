USE gestion_proyecto;
GO

--  Invocacion de los procedimientos
--	Para invocar los procedimientos usamos EXEC/EXECUTE

EXEC sp_InsertarTarea
    @titulo = 'Desarrollar API de Usuarios',
    @descripcion = 'Crear endpoints GET y POST para usuarios',
    @fecha_vencimiento = '2025-12-05',
    @id_proyecto = 2,
    @id_responsable = 2,
    @id_estado = 1;

EXEC sp_InsertarTarea
    @titulo = 'Testear Login',
    @descripcion = 'Pruebas unitarias para el login',
    @fecha_vencimiento = '2025-11-30',
    @id_proyecto = 2,
    @id_responsable = 1,
    @id_estado = 1;