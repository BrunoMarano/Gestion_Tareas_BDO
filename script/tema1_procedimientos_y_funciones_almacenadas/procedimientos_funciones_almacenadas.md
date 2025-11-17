# Investigación: Procedimientos y Funciones Almacenadas

**Asignatura:** Bases de Datos I
**Proyecto:** Gestor de Tareas

## 1. Procedimientos Almacenados (Stored Procedures)

### 1.1. Definición

Son conjuntos de instrucciones T-SQL predefinidos que se almacenan y ejecutan en el servidor de base de datos. Están diseñados para realizar una serie de operaciones, como consultas, modificaciones o manipulaciones de datos, sin necesidad de que la aplicación cliente envíe las consultas completas, sino solo la orden de ejecución.

### 1.2. Gestión de Procedimientos

- **Crear Procedimiento (`CREATE PROCEDURE`):** Define un nuevo procedimiento. Puede aceptar parámetros de entrada (INPUT) y devolver parámetros de salida (OUTPUT).
- **Modificar Procedimiento (`ALTER PROCEDURE`):** Se utiliza para modificar la lógica de un procedimiento existente sin afectar los permisos.
- **Eliminar Procedimiento (`DROP PROCEDURE`):** Elimina un procedimiento almacenado de la base de datos.

### 1.3. Características Clave

- **Operaciones CRUD:** Pueden ejecutar instrucciones `INSERT`, `UPDATE`, `DELETE` y `SELECT` sobre las tablas. Son la herramienta principal para encapsular la lógica de negocio.
- **Manejo de Transacciones:** Pueden (y deben) incluir transacciones explícitas (`BEGIN TRANSACTION`, `COMMIT`, `ROLLBACK`) para garantizar la atomicidad de las operaciones.
- **Modularidad:** Pueden invocar otros procedimientos, permitiendo reutilizar código y mantener una lógica limpia.
- **Valor de Estado:** Devuelven siempre un código de estado (un entero) para indicar el éxito o fallo (por defecto `0` es éxito).

### 1.4. Tipos de Procedimientos Almacenados

- **Definidos por el Usuario:** Creaciones personalizadas para la lógica de la aplicación (ej. `sp_InsertarTarea`).
- **Temporales:** Existen solo durante la sesión. Se almacenan en `tempdb`.
- **Del Sistema:** Procedimientos predefinidos en SQL Server (prefijo `sp_`) para tareas administrativas.

### 1.5. Ventajas Clave

- **Mejor Rendimiento (Planes de Ejecución Cacheados):** Esta es la ventaja principal. La _primera vez_ que se ejecuta un SP, el motor de SQL lo analiza, optimiza y crea un **plan de ejecución** que guarda en caché. Las siguientes ejecuciones **reutilizan ese plan optimizado** en lugar de recalcularlo, resultando en una ejecución mucho más rápida.
- **Seguridad Mejorada:** Se puede conceder permiso `EXECUTE` sobre un procedimiento sin dar permisos directos `DELETE` o `UPDATE` sobre la tabla. Esto previene ataques de inyección SQL y errores de manipulación directa.
- **Reducción del Tráfico de Red:** En lugar de enviar una consulta de 100 líneas, la aplicación solo envía `EXEC sp_MiProcedimiento @Param1 = 5`. Esto reduce drásticamente la cantidad de datos que viajan por la red.

---

## 2. Funciones Almacenadas (Stored Functions)

### 2.1. Definición

Son bloques de código T-SQL que realizan un cálculo o una evaluación y **obligatoriamente devuelven un valor**. Su objetivo no es _hacer_ algo, sino _calcular_ algo.

### 2.2. Características Clave

- **Valor de Retorno Obligatorio:** Siempre devuelven un valor, ya sea un valor único (escalar) o una tabla.
- **No Modifican Datos:** Por diseño, las funciones no pueden realizar operaciones `INSERT`, `UPDATE` ni `DELETE` sobre tablas de la base de datos. Están diseñadas para ser "seguras" en operaciones de solo lectura.
- **Uso en Consultas:** Son la única forma de encapsular lógica que se puede invocar _dentro_ de un `SELECT` o una cláusula `WHERE`.

### 2.3. Tipos de Funciones Almacenadas

- **Funciones Escalares (UDF):** Devuelven un solo valor (ej. `INT`, `VARCHAR`, `DATE`).
  - _Uso:_ `SELECT dbo.fn_CalcularEdad(FechaNac) FROM Usuarios;`
- **Funciones de Tabla (TVF):** Devuelven un conjunto de filas (un `TABLE`). Actúan como vistas parametrizadas y son extremadamente útiles.
  - _Uso:_ `SELECT * FROM dbo.fn_ObtenerTareasPorEstado(1);`

---

## 3. Comparativa: Procedimiento vs. Función

| Característica              | Procedimiento (SP)                    | Función (FN)                                       |
| :-------------------------- | :------------------------------------ | :------------------------------------------------- |
| **Propósito Principal**     | Ejecutar acciones (Lógica CRUD)       | Calcular y retornar un valor                       |
| **Valor de Retorno**        | Opcional (un código de estado `INT`)  | **Obligatorio** (escalar o tabla)                  |
| **Uso en `SELECT`**         | **No se puede**                       | **Sí** (en `SELECT`, `WHERE`, `JOIN`)              |
| **Modificación de Datos**   | **Sí** (`INSERT`, `UPDATE`, `DELETE`) | **No** (solo lectura)                              |
| **Manejo de Transacciones** | **Sí**                                | **No**                                             |
| **Invocación**              | `EXEC [NombreSP]`                     | `dbo.[NombreFN]()` (dentro de un `SELECT` o `SET`) |
