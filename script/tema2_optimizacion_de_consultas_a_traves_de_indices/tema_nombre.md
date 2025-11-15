## TEMA 2: OPTIMIZACIÓN DE CONSULTAS A TRAVÉS DE ÍNDICES

La optimización de consultas a través de índices es otra característica vital en un sistema de gestión de base de datos. Los índices permiten acelerar las búsquedas y el acceso a datos específicos, mejorando considerablemente el rendimiento del sistema. Esto es particularmente importante en negocios que manejan grandes volúmenes de información, donde el tiempo de respuesta puede afectar directamente la satisfacción del cliente y la eficiencia operativa.

### ¿Que son los indices?

Los índices son objetos que permiten el ordenamiento de los datos de las tablas según diversos criterios. Se dice que son objetos ya que poseen componentes independientes de una tabla, tienen su propia estructura y administración. Esto significa que los índices pueden ser creados, modificados o eliminados de forma independiente de la tabla principal. Además pueden tener propiedades, como el tipo de índice (agrupado o no agrupado), columnas incluidas, y opciones de almacenamiento.

Ocupan espacio físico en el disco menor a lo que una tabla. La particularidad que tienen los índices es que crean una copia parcial de los datos de una tabla, es decir, realizan una copia solo de las columnas con las que fue creado el índice. Por ejemplo, si se crea un índice en la columna fecha_reservada, este índice almacenará los valores de fecha_reservada. 

Esta "copia parcial" mejora el rendimiento de las consultas al permitir el acceso a los datos relevantes sin necesidad de leer toda la tabla, lo cual es particularmente útil en tablas de gran tamaño. Por ejemplo, si queremos consultar las reservas realizadas en el año 2022, el motor de base de datos utilizará el índice en la columna fecha_reservada para localizar rápidamente los registros de ese año. Al estar los datos ordenados dentro del índice, el motor puede acceder a los registros de 2022 de manera mucho más eficiente, evitando una búsqueda completa y acelerando así el tiempo de respuesta de la consulta.

### "Degrada performance en los INSERT, UPDATE y DELETE"
Cuando se crean índices en una tabla, cualquier operación que cambie los datos de esa tabla (como INSERT, UPDATE o DELETE) también tiene que actualizar el índice correspondiente. Esto es lo que provoca una disminución en el rendimiento para estas operaciones. 

### "Aumenta performance en SELECT"
Uno de los principales beneficios de los índices es que mejoran significativamente el rendimiento de las consultas de selección (SELECT). Esto se debe a que los índices permiten al motor de la base de datos acceder a los datos de forma mucho más eficiente que si tuviera que leer todas las filas en una tabla.

**Acceso más rápido a los datos:** Cuando se ejecuta una consulta SELECT que filtra o busca valores específicos, el índice ayuda a la base de datos a localizar rápidamente las filas que cumplen con los criterios de búsqueda, sin tener que revisar cada fila de la tabla. 

**Reducción de lecturas:** Los índices son particularmente útiles en tablas grandes porque evitan la necesidad de realizar un “escaneo completo de la tabla” table scan (lo cual implicaría leer cada fila de la tabla). Esto reduce drásticamente el número de lecturas necesarias y, en consecuencia, mejora el tiempo de respuesta.
Índices compuestos y consultas complejas: En consultas que filtran por múltiples columnas, un índice compuesto (un índice que incluye varias columnas) puede acelerar aún más la consulta. 

En SQL Server, los índices se organizan como árboles b.  Las páginas de un árbol b de índice se llaman nodos del índice. El nodo superior del árbol b se llama nodo raíz. El nivel inferior de los nodos del índice se denomina nodos hoja.  Los niveles del índice entre el nodo raíz y los nodos hoja se conocen en conjunto como niveles intermedios.  

### Se dividen en agrupados (Cluster) o no agrupados.
**Índice agrupado:** Los datos de la tabla están organizados según el índice. Solo puedes tener uno por tabla, ya que los datos no pueden almacenarse físicamente en más de un orden.

**Índice no agrupado:** Es como un índice de un libro. Los datos no están organizados físicamente según el índice, sino que el índice contiene punteros a la ubicación de los datos. Por lo tanto, puedes tener múltiples índices no agrupados en una tabla.

### Estructura de un índice agrupado

Un índice agrupado utiliza una estructura jerárquica de árbol, llamada árbol B (B-tree), para organizar los datos. 

**Nodos internos:** Son los nodos que sirven como guías en el árbol. Ayudan al sistema a encontrar rápidamente los datos que estás buscando.
**Nodos hoja:** Son los nodos al final de la estructura del árbol. Aquí es donde están almacenados los datos reales de la tabla subyacente.

En un índice agrupado, los nodos hoja son especiales porque contienen las páginas de datos reales de la tabla. Esto significa que los datos de la tabla se almacenan directamente en la estructura del índice agrupado, en lugar de apuntar a otra ubicación.

### ¿Qué son las páginas de datos?

Las páginas de datos son las unidades en las que los datos de la tabla se almacenan físicamente en el disco. Cada página de datos contiene varias filas de la tabla subyacente. Cuando un índice agrupado está creado en una tabla, los datos se organizan físicamente en las páginas de datos de acuerdo con el orden del índice agrupado.

### Diferencia con un índice no agrupado

En un índice no agrupado, los nodos hoja no contienen las páginas de datos reales. En su lugar, contienen punteros que apuntan a la ubicación de los datos en la tabla subyacente. Por eso, los índices no agrupados son menos eficientes cuando hay que acceder directamente a los datos, ya que necesitan una segunda búsqueda para localizar los datos en la tabla subyacente.

### ¿Qué es el plan de ejecución estimado?
El plan de ejecución estimado es un análisis previo que SQL Server hace para decidir cómo responderá a una consulta, evaluando las diferentes formas de acceder a los datos y calculando cuál es la más eficiente. SQL Server toma en cuenta factores como índices, estadísticas y el diseño de la consulta para elegir la estrategia óptima.
