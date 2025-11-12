-- SCRIPT "nombre del proyecto"
-- INSERCIÓN DEL LOTE DE DATOS

USE gestion_proyecto;
GO

-- 1. Definimos cuántos usuarios queremos crear
DECLARE @CantidadUsuarios INT = 1000;

-- 2. Usamos una CTE (Common Table Expression) recursiva.
-- Esto genera una "tabla virtual" de números del 1 al 1000.
WITH GeneradorNumeros (N) AS
(
    -- (Anchor) Empezamos en el número 1
    SELECT 1
    UNION ALL
    -- (Recursive) Seguimos sumando 1 hasta llegar a @CantidadUsuarios
    SELECT N + 1
    FROM GeneradorNumeros
    WHERE N < @CantidadUsuarios
)
-- 3. Hacemos UN solo INSERT que lee de nuestra tabla virtual de números
INSERT INTO usuario (nombre, email, contrasena)
SELECT
    'Usuario ' + CAST(N AS VARCHAR(10)),
    'usuario' + CAST(N AS VARCHAR(10)) + '@proyecto.com',
    -- Generamos un hash SHA2_256 (como texto) para simular una contraseña segura.
    -- (Ej: 'Password' + 1, 'Password' + 2, etc.)
    CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'PasswordGen' + CAST(N AS VARCHAR(10))), 2)
FROM GeneradorNumeros
-- (Opcional pero recomendado) Permite que la recursión supere el límite de 100
OPTION (MAXRECURSION 0);
GO

-- 4. Verificación
PRINT '¡Carga completada!';
SELECT COUNT(*) AS TotalUsuariosCargados FROM usuario;
SELECT TOP 10 * FROM usuario ORDER BY id_usuario DESC; -- Muestra los últimos 10
GO


-- 1. Carga de 5 Roles
SET IDENTITY_INSERT rol ON;
INSERT INTO rol (id_rol, tipo_rol) VALUES
(1, 'Administrador de Proyecto'),
(2, 'Líder de Equipo'),
(3, 'Miembro'),
(4, 'Cliente'),
(5, 'Observador');
SET IDENTITY_INSERT rol OFF;
GO

-- 2. Carga de 6 Estados (Columnas tipo Trello)
SET IDENTITY_INSERT estado ON;
INSERT INTO estado (id_estado, tipo_estado) VALUES
(1, 'Backlog'),
(2, 'Por Hacer'),
(3, 'En Progreso'),
(4, 'En Revisión'),
(5, 'Bloqueado'),
(6, 'Hecho');
SET IDENTITY_INSERT estado OFF;
GO

-- 3. Carga de 10 Categorías (Etiquetas)
SET IDENTITY_INSERT categoria ON;
INSERT INTO categoria (id_categoria, tipo_categoria) VALUES
(1, 'Bug'),
(2, 'Feature (Nueva Funcionalidad)'),
(3, 'Mejora'),
(4, 'Backend'),
(5, 'Frontend'),
(6, 'Diseño UX/UI'),
(7, 'Documentación'),
(8, 'Testing'),
(9, 'DevOps'),
(10, 'Urgente');
SET IDENTITY_INSERT categoria OFF;
GO

-- Verificamos que todo se haya cargado
PRINT 'Carga completada.';
SELECT * FROM rol;
SELECT * FROM estado;
SELECT * FROM categoria;
GO

----------------------------------
--- LOTE DE DATOS DE PROYECTOS ---
----------------------------------

-- Habilitamos la inserción manual de IDs para controlar
-- cuál es el proyecto principal y simular fechas pasadas.
SET IDENTITY_INSERT proyecto ON;
GO

INSERT INTO proyecto (id_proyecto, nombre, descripcion, fecha_creacion, fecha_fin) 
VALUES
-- 1. Proyecto Principal (Pruebas de Estrés)
(1, 'Migración ERP a Cloud (Proyecto Fénix)', 'Migración masiva de toda la infraestructura y base de datos de la empresa. Todas las demás tareas dependen de esto.', '2024-01-15', '2026-06-30'),

-- 2. Proyectos Medianos (5)
(2, 'Lanzamiento App Móvil V2', 'Desarrollo de la segunda versión de la app nativa para iOS y Android.', '2024-11-10', '2025-12-20'),
(3, 'Campaña de Marketing Digital Q4', 'Campaña de fin de año, incluye Black Friday y Navidad.', '2025-09-01', '2025-12-31'),
(4, 'Implementación CRM (Salesforce)', 'Implementación completa para el equipo de ventas. (Proyecto completado).', '2024-07-01', '2025-05-30'),
(5, 'Optimización SEO Sitio Web', 'Mejora continua de SEO y performance web. (Proyecto permanente).', '2025-01-10', NULL),
(6, 'Dashboard de BI (PowerBI)', 'Creación de dashboards de gestión para C-level.', '2025-03-15', '2025-10-15'),

-- 3. Proyectos Pequeños (17 - Uso Normal)
(7, 'Actualización WordPress Plugins', 'Mantenimiento de seguridad mensual.', '2025-01-01', NULL),
(8, 'Diseño Banners Black Friday', 'Diseño de creatividades para la campaña Q4.', '2025-10-20', '2025-11-15'),
(9, 'Fix: Bug en Pasarela de Pago', 'Corrección de bug crítico reportado por soporte.', '2025-11-01', '2025-11-05'),
(10, 'Investigación Nuevos Proveedores', 'Análisis de proveedores de hosting alternativos.', '2025-06-05', '2025-08-01'),
(11, 'Onboarding Nuevo Diseñador', 'Plan de tareas de onboarding para RRHH.', '2025-11-10', '2025-12-15'),
(12, 'Configurar CI/CD (Proyecto App Móvil)', 'Automatización de despliegues.', '2025-08-01', '2025-08-15'),
(13, 'Redacción Blog Post (Noviembre)', 'Escribir 4 artículos para el blog.', '2025-11-02', '2025-11-28'),
(14, 'Migración Email a Google Workspace', 'Migración de 10 cuentas de correo de MKT.', '2025-04-01', '2025-04-05'),
(15, 'Test de A/B Landing Page', 'Prueba de dos versiones del formulario de contacto.', '2025-11-12', '2025-12-12'),
(16, 'Revisión Contratos Legales', 'Revisión legal de 3 contratos pendientes.', '2025-11-01', '2025-11-20'),
(17, 'Refactor: Módulo de Autenticación', 'Limpieza de código técnico del login.', '2025-07-10', '2025-09-10'),
(18, 'Organización Fiesta Fin de Año', 'Logística, catering y lugar.', '2025-10-01', '2025-12-20'),
(19, 'Actualización Política de Privacidad', 'Adaptación a nueva normativa legal.', '2025-05-15', '2025-06-01'),
(20, 'Diseño de Merchandising', 'Nuevas camisetas y tazas para empleados.', '2025-09-10', '2025-10-30'),
(21, 'Mantenimiento Servidores (Fin de Semana)', 'Parche de seguridad programado.', '2025-11-08', '2025-11-09'),
(22, 'Planificación Sprint Enero 2026', 'Definición de Q1 2026.', '2025-11-10', '2025-11-17'),
(23, 'Documentación API V3', 'Escribir la documentación pública de la nueva API.', '2025-09-01', '2025-12-01'),

-- 4. Proyectos Vacíos (2 - Casos Borde)
(24, 'Prueba de Concepto (IA)', 'Proyecto de prueba que fue abandonado.', '2025-02-01', '2025-02-15'),
(25, 'Nuevo Proyecto (Sin Definir)', 'Creado por error, actualmente activo y vacío.', '2025-11-01', NULL);
GO

-- Deshabilitamos la inserción manual de IDs
SET IDENTITY_INSERT proyecto OFF;
GO

PRINT 'Carga de 25 proyectos representativos completada.';
SELECT * FROM proyecto ORDER BY id_proyecto;
GO

USE gestion_proyecto;
GO

-------------------------------
--- LOTE DE DATOS DE TAREAS ---
-------------------------------

-- 1. Definimos el total de tareas a generar
DECLARE @TotalTareas INT = 6000;

PRINT 'Iniciando carga masiva de ' + CAST(@TotalTareas AS VARCHAR) + ' tareas...';

-- 2. Usamos la CTE recursiva para generar 6000 números
WITH GeneradorNumeros (N) AS
(
    SELECT 1
    UNION ALL
    SELECT N + 1
    FROM GeneradorNumeros
    WHERE N < @TotalTareas
)
-- 3. Hacemos un solo INSERT...SELECT
-- Omitimos 'fecha_creacion' para que use el DEFAULT GETDATE()
INSERT INTO tarea 
(
    titulo, 
    descripcion, 
    fecha_vencimiento, 
    id_proyecto, 
    id_responsable, 
    id_estado
)
SELECT
    -- Título y Descripción genéricos
    'Tarea Genérica ' + CAST(N AS VARCHAR(10)),
    'Descripción detallada de la tarea número ' + CAST(N AS VARCHAR(10)) + '.',

    -- Fecha de Vencimiento: 20% nulas, el resto vencen en los próximos 1-30 días
    CASE 
        WHEN (N % 5) = 0 THEN NULL
        ELSE DATEADD(day, (N % 30) + 1, GETDATE())
    END,

    -- Clave 1: Distribución de PROYECTOS (Tu requisito)
    -- 4000 tareas (N=1 a 4000) van al Proyecto 1
    -- 1000 tareas (N=4001 a 5000) van a Proyectos 2-6
    -- 1000 tareas (N=5001 a 6000) van a Proyectos 7-23
    CASE
        WHEN N <= 4000 THEN 1 -- Proyecto Principal
        WHEN N <= 5000 THEN ((N-4001) % 5) + 2 -- Proyectos Medianos (ID 2 al 6)
        ELSE ((N-5001) % 17) + 7 -- Proyectos Pequeños (ID 7 al 23)
    END,

    -- Clave 2: Distribución de RESPONSABLES (Simulación de "Power User")
    -- Asignamos 33% de las tareas al Usuario 1
    -- El resto se reparte entre los 1000 usuarios
    CASE 
        WHEN (N % 3) = 0 THEN 1 -- Usuario 1 (Power user)
        ELSE ((N-1) % 1000) + 1
    END,

    -- Clave 3: Distribución de ESTADOS (Tu requisito)
    -- 80% "Hecho" (ID 6), 15% "Por Hacer" (ID 2), 5% "En Progreso" (ID 3)
    CASE 
        WHEN (N % 100) < 80 THEN 6  -- 80% (IDs 0-79)
        WHEN (N % 100) < 95 THEN 2  -- 15% (IDs 80-94)
        ELSE 3                      -- 5% (IDs 95-99)
    END

FROM GeneradorNumeros
OPTION (MAXRECURSION 0); -- Permite recursión ilimitada
GO

PRINT '¡Carga de tareas completada!';
GO

--- Verificación de la Distribución

--- Ejecuta estas consultas para verificar que la carga desigual funcionó:

-- 1. Verificación por Proyecto
PRINT 'Conteo de tareas por ID de Proyecto:';
SELECT 
    id_proyecto, 
    COUNT(*) AS TotalTareas
FROM tarea
GROUP BY id_proyecto
ORDER BY TotalTareas DESC;

-- 2. Verificación por Estado
PRINT 'Conteo de tareas por ID de Estado:';
SELECT 
    id_estado, 
    COUNT(*) AS TotalTareas,
    (COUNT(*) * 100.0 / 6000) AS Porcentaje
FROM tarea
GROUP BY id_estado
ORDER BY TotalTareas DESC;

-- 3. Verificación de Responsable (Power User)
PRINT 'Top 5 usuarios con más tareas asignadas:';
SELECT TOP 5
    id_responsable,
    COUNT(*) AS TotalTareas
FROM tarea
GROUP BY id_responsable
ORDER BY TotalTareas DESC;
GO

------------------------------------
--- LOTE DE DATOS DE COMENTARIOS ---
------------------------------------

-- 1. Definimos el total de comentarios a generar
DECLARE @TotalComentarios INT = 20000;

PRINT 'Iniciando carga masiva de ' + CAST(@TotalComentarios AS VARCHAR) + ' comentarios...';

-- 2. Usamos la CTE recursiva para generar 20,000 números
WITH GeneradorNumeros (N) AS
(
    SELECT 1
    UNION ALL
    SELECT N + 1
    FROM GeneradorNumeros
    WHERE N < @TotalComentarios
)
-- 3. Hacemos un solo INSERT...SELECT
-- Omitimos 'fecha_comentario' para que use el DEFAULT GETDATE()
INSERT INTO comentario
(
    descripcion,
    id_tarea,
    id_usuario
)
SELECT
    -- Descripción genérica
    'Este es el comentario número ' + CAST(N AS VARCHAR(10)) + '.',

    -- Clave 1: Distribución de TAREAS (Tu requisito 70/20/10)
    CASE
        -- 10% de comentarios (1-2000) van al 70% de tareas (1-4200)
        WHEN N <= 2000 THEN (N % 4200) + 1 
        
        -- 30% de comentarios (2001-8000) van al 20% de tareas (4201-5400)
        WHEN N <= 8000 THEN ((N - 2001) % 1200) + 4201 
        
        -- 60% de comentarios (8001-20000) van al 10% de tareas (5401-6000)
        ELSE ((N - 8001) % 600) + 5401 
    END,

    -- Clave 2: Distribución de USUARIOS (Simulando Power User)
    -- 33% de los comentarios son del Usuario 1
    CASE 
        WHEN (N % 3) = 0 THEN 1 -- Usuario 1 (Power user)
        ELSE ((N - 1) % 1000) + 1 -- El resto de los 1000 usuarios
    END

FROM GeneradorNumeros
OPTION (MAXRECURSION 0); -- Permite recursión ilimitada
GO

PRINT '¡Carga de comentarios completada!';
GO

---Verificación de la Distribución (¡Importante!)

--- Ejecuta esta consulta para ver si logramos la distribución que querías. Contará cuántos comentarios tiene CADA una de las 6,000 tareas y las agrupará.

PRINT 'Verificando la distribución de comentarios por tarea:';

-- Usamos una CTE para obtener el conteo de comentarios de CADA tarea (incluyendo las de 0)
WITH ConteoPorTarea AS (
    SELECT
        T.id_tarea,
        COUNT(C.id_comentario) AS TotalComentarios
    FROM
        tarea T
    LEFT JOIN -- LEFT JOIN es clave para incluir tareas con 0 comentarios
        comentario C ON T.id_tarea = C.id_tarea
    GROUP BY
        T.id_tarea
)
-- Ahora agrupamos esos conteos en los rangos que definiste
SELECT
    Rango,
    TotalTareas,
    (TotalTareas * 100.0 / 6000) AS Porcentaje
FROM (
    SELECT '0-3 Comentarios' AS Rango, COUNT(*) AS TotalTareas FROM ConteoPorTarea WHERE TotalComentarios BETWEEN 0 AND 3
    UNION ALL
    SELECT '4-10 Comentarios' AS Rango, COUNT(*) AS TotalTareas FROM ConteoPorTarea WHERE TotalComentarios BETWEEN 4 AND 10
    UNION ALL
    SELECT '11-20 Comentarios' AS Rango, COUNT(*) AS TotalTareas FROM ConteoPorTarea WHERE TotalComentarios BETWEEN 11 AND 20
    UNION ALL
    SELECT '21+ Comentarios (Hilos Calientes)' AS Rango, COUNT(*) AS TotalTareas FROM ConteoPorTarea WHERE TotalComentarios >= 21
) AS Rangos
ORDER BY
    CASE 
        WHEN Rango = '0-3 Comentarios' THEN 1
        WHEN Rango = '4-10 Comentarios' THEN 2
        WHEN Rango = '11-20 Comentarios' THEN 3
        ELSE 4
    END;
GO

-----------------------------------
--- LOTE DE DATOS DE ASIGNACION ---
-----------------------------------

PRINT 'Limpiando la tabla [asignacion] para la nueva carga...';
DELETE FROM asignacion;
GO

PRINT 'Iniciando carga de asignaciones (Versión corregida con 5 roles)...';

DECLARE @TotalIntentos INT = 2500;

WITH Generador (N) AS (
    SELECT 1 UNION ALL SELECT N + 1 FROM Generador WHERE N < @TotalIntentos
),
PotencialesAsignaciones AS (
    SELECT
        -- Asignación de USUARIO (Sin cambios)
        CASE 
            WHEN N <= 15 THEN 1 
            ELSE ((N-16) % 1000) + 1 
        END AS id_usuario,

        -- Asignación de PROYECTO (Sin cambios)
        CASE
            WHEN N <= 15 THEN N 
            WHEN (N % 10) < 4 THEN 1 
            WHEN (N % 10) < 7 THEN ((N-1) % 5) + 2
            ELSE ((N-1) % 17) + 7
        END AS id_proyecto,

        -- -----------------------------------------------------------------
        -- CORRECCIÓN DE LÓGICA DE ROL - AQUÍ ESTÁ EL CAMBIO
        -- -----------------------------------------------------------------
        CASE
            -- 1. Power user (N <= 15) es Admin (Rol 1)
            WHEN N <= 15 THEN 1 
            
            -- Distribuimos el resto:
            -- 50% son Miembros (Rol 3)
            WHEN (N % 10) < 5 THEN 3
            -- 15% son Líderes (Rol 2)
            WHEN (N % 10) < 6 THEN 2
            -- 15% son Clientes (Rol 4)
            WHEN (N % 10) < 8 THEN 4
            -- 10% son Observadores (Rol 5)
            WHEN (N % 10) < 9 THEN 5
            -- 10% son Admins (Rol 1)
            ELSE 1
        END AS id_rol
        -- -----------------------------------------------------------------
    FROM Generador
)
-- Insertamos AGRUPANDO (esto garantiza que no haya duplicados de PK)
INSERT INTO asignacion (id_usuario, id_proyecto, id_rol)
SELECT 
    id_usuario,
    id_proyecto,
    MIN(id_rol) AS id_rol -- Si un usuario/proyecto se genera 2 veces,
                         -- tomamos el rol con el ID más bajo (ej: Admin)
FROM PotencialesAsignaciones
GROUP BY 
    id_usuario, id_proyecto 
OPTION (MAXRECURSION 0); 
GO

PRINT '¡Carga de asignaciones completada!';
GO

---Verificación (Ahora sí)

-- Ejecuta esto para ver la nueva distribución de roles:

PRINT '--- Verificación de Distribución de Roles ---';
SELECT 
    R.tipo_rol,
    COUNT(A.id_rol) AS TotalAsignaciones
FROM asignacion A
JOIN rol R ON A.id_rol = R.id_rol
GROUP BY R.tipo_rol
ORDER BY TotalAsignaciones DESC;

PRINT '--- Verificación del Power User (ID 1) ---';
SELECT 
    'Proyectos del Power User (ID 1)' AS Verificacion, 
    COUNT(id_proyecto) AS TotalProyectos
FROM asignacion
WHERE id_usuario = 1;
GO



PRINT 'Iniciando carga de 11,000 asignaciones de categorías...';

-- 1. Usamos una CTE para generar 6000 números (uno por cada tarea)
WITH Generador (N) AS (
    SELECT 1
    UNION ALL
    SELECT N + 1 FROM Generador WHERE N < 6000
),
-- 2. Creamos una tabla virtual con los dos sets de asignaciones
Asignaciones AS (
    -- SET 1: Todas las 6,000 tareas obtienen su *primera* categoría
    -- (Usamos N % 10 + 1 para ciclar entre las 10 categorías)
    SELECT 
        N AS id_tarea, 
        (N % 10) + 1 AS id_categoria
    FROM Generador
    
    UNION ALL -- Combinamos con el segundo set

    -- SET 2: Las primeras 5,000 tareas obtienen una *segunda* categoría
    -- (Usamos (N + 1) % 10 + 1) para que la categoría sea DIFERENTE
    -- a la del Set 1, evitando así errores de Primary Key)
    SELECT 
        N AS id_tarea, 
        ((N + 1) % 10) + 1 AS id_categoria
    FROM Generador
    WHERE N <= 5000
)
-- 3. Insertamos el resultado final (11,000 filas) en la tabla
INSERT INTO tarea_categoria (id_tarea, id_categoria)
SELECT id_tarea, id_categoria
FROM Asignaciones
OPTION (MAXRECURSION 0); -- Permitir recursión alta
GO

PRINT '¡Carga de 11,000 asignaciones de categorías completada!';
GO

---Verificación de la Distribución

PRINT '--- Verificación de Distribución de Categorías ---';

-- 1. Conteo total de registros
SELECT 
    'Total de Registros en tarea_categoria' AS Verificacion, 
    COUNT(*) AS Total
FROM tarea_categoria;

-- 2. Verificación de "1 o 2 categorías por tarea"
WITH ConteoPorTarea AS (
    -- Contamos cuántas categorías tiene CADA tarea
    SELECT id_tarea, COUNT(*) AS TotalCategorias
    FROM tarea_categoria
    GROUP BY id_tarea
)
-- Agrupamos esos conteos
SELECT 
    'Tareas con ' + CAST(TotalCategorias AS VARCHAR) + ' categoría(s)' AS Rango, 
    COUNT(id_tarea) AS TotalTareas
FROM ConteoPorTarea
GROUP BY TotalCategorias
ORDER BY TotalCategorias;
GO