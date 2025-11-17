USE gestion_proyecto;
GO

--  Update y delete con procedimientos

--  MODIFICAR tarea
EXEC sp_ModificarTarea
    @id_tarea = 1,
    @titulo = 'Diseñar Mockups UI (Actualizado)', 
    @descripcion = 'Mockups de Home y Contacto terminados',
    @fecha_vencimiento = '2025-11-20', 
    @id_proyecto = 1, 
    @id_responsable = 1, 
    @id_estado = 2; 

-- BORRAR tarea
EXEC sp_EliminarTarea
    @id_tarea = 3;