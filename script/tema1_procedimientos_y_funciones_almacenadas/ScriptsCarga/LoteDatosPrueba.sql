USE gestion_proyecto;
GO

-- Lote de datos

-- Insertar Estados (1 = Pendiente, 2 = En Progreso, 3 = Completado)
INSERT INTO estado (tipo_estado) 
VALUES
    ('Pendiente'),
    ('En Progreso'),
    ('Completado');

-- Insertar Usuarios (1 = Ana, 2 = Luis)
INSERT INTO usuario (nombre, email, contrasena) 
VALUES
    ('Ana López', 'ana@email.com', 'hash_contrasena_123'),
    ('Luis Marín', 'luis@email.com', 'hash_contrasena_456');

-- Insertar Proyectos (1 = Web, 2 = App)
INSERT INTO proyecto (nombre, descripcion, fecha_fin) 
VALUES
    ('Sitio Web Corporativo', 'Desarrollo del nuevo sitio web', '2026-06-01'),
    ('App Móvil Interna', 'App de seguimiento de horas', '2026-08-15');

-- Insertar Tareas (1 = Diseñar Mockups UI, 2 = Definir Arquitectura BD, 3 = Configurar Repositorio Git)
INSERT INTO tarea (titulo, descripcion, fecha_vencimiento, id_proyecto, id_responsable, id_estado) 
VALUES
    ('Diseñar Mockups UI', 'Crear mockups en Figma para el home', '2025-11-20', 1, 1, 1),
    ('Definir Arquitectura BD', 'Modelado de la base de datos inicial', '2025-11-22', 1, 2, 1),
    ('Configurar Repositorio Git', 'Crear el repo en GitHub y ramas', '2025-11-15', 2, 1, 2);