# Vistas y Vistas Indexadas

## 1.1 Definición de vista
Una **vista** es un objeto de base de datos que representa el resultado de una consulta SQL almacenada.  
En lugar de contener datos propios, una vista muestra datos que provienen de una o más tablas, lo que permite simplificar consultas complejas, ocultar detalles de implementación y mejorar la seguridad al limitar el acceso directo a las tablas.

**Ejemplo de uso:**  
Permite mostrar solo ciertas columnas de una tabla o combinar información de varias tablas sin modificar los datos originales.

---

## 1.2 Definición de vista indexada
Una **vista indexada** es una vista especial que **almacena físicamente los resultados de la consulta** en disco mediante la creación de un índice **clustered (agrupado)**.  
Esto mejora el rendimiento de las consultas que acceden con frecuencia a datos agregados o calculados, aunque aumenta el costo de mantenimiento cuando los datos subyacentes cambian.

**En resumen:** una vista indexada es similar a una tabla materializada.

---

## 1.3 Diferencia entre vista y vista indexada
| Característica | Vista común | Vista indexada |
|----------------|--------------|----------------|
| Almacenamiento | No almacena datos, solo la consulta | Almacena los resultados físicamente |
| Rendimiento | Depende de las tablas base | Más rápida en lecturas repetidas |
| Mantenimiento | Sin costo adicional | Requiere actualizarse al cambiar los datos base |
| Uso típico | Simplificar consultas, seguridad | Mejorar rendimiento de consultas agregadas |

---

## 1.4 Características
- Las vistas se crean a partir de sentencias **SELECT**.  
- Pueden incluir **joins, filtros y funciones de agregación**.  
- Las vistas indexadas deben:
  - Crearse con la opción **WITH SCHEMABINDING**.  
  - Contener solo tablas base, sin otras vistas.  
  - Tener un **índice clustered único** para materializar los datos.  
- Una vez creada, la vista indexada se mantiene automáticamente cuando cambian los datos de las tablas base.

---

## 1.5 Crear una vista
```sql
CREATE VIEW vista_empleados AS
SELECT nombre, apellido, salario
FROM empleados
WHERE salario > 50000;
```
## 1.6 Crear una vista indexada
```sql
CREATE VIEW vista_empleados_indexada
WITH SCHEMABINDING
AS
SELECT e.id_empleado, e.salario, e.departamento_id
FROM dbo.empleados AS e;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vista_empleados_indexada_id
ON vista_empleados_indexada (id_empleado);
```

## 1.7 Conclusión
Luego de realizar la actividad, observamos que para crear una vista indexada se deben cumplir ciertas condiciones, como que su creación se realiza con la cláusula "WITH SCHEMABINDING", la cual permite que la vista creada "quede atada" a la tabla y de ese modo no se pueda modificar la tabla base sin antes eliminar la vista. Otra condición es que todos los objetos deben ir con su esquema, por ejemplo con "dbo.nombreTabla" inicialmente.

Para "indexar" la vista, se debe crear un índice clusterizado único y obligatorio:
CREATE UNIQUE CLUSTERED INDEX IX_vista_usuario_indexada_id
ON vista_usuario_indexada (id_usuario);

El índice clusterizado crea una estructura física de almacenamiento para la vista, con los datos ordenados por la columna id_usuario. A partir de ahí, SQL Server puede leer los datos más rápido, sin tener que recalcular la vista cada vez. Si la tabla base cambia (insert, update, delete), el sistema actualiza automáticamente los datos en la vista indexada.