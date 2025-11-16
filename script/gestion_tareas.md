# Proyecto de Estudio

# Gestión de Tareas

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:

- Barrios, Enzo Tomas
- Bongiovanni, Iara Aylen
- Diaz, Franco Benjamin
- Marano, Bruno Joel

**Año**: 2025

## CAPÍTULO I: INTRODUCCIÓN

### Caso de estudio

El presente trabajo práctico tiene como finalidad el diseño y modelado de una base de datos para la gestión de cadetes dentro de una empresa. El sistema busca organizar de manera eficiente las tareas y proyectos que los cadetes deben realizar, asegurando un mejor seguimiento de sus responsabilidades, roles y estados de avance.

### Definición o planteamiento del problema

En muchas empresas, los cadetes cumplen un rol esencial para realizar tareas externas (trámites, entregas, correspondencia, compras, etc.), pero a menudo la asignación y control de esas tareas se realiza de manera manual o informal, lo que genera varios inconvenientes:
● Pérdida de información sobre las tareas realizadas.

● Dificultad para hacer un seguimiento del estado de cada trámite.

● Problemas en la asignación de responsabilidades entre los cadetes.

● Falta de un registro histórico que permita evaluar eficiencia y desempeño.

Ante esta situación, surge la necesidad de un sistema de base de datos que permita centralizar la información de los proyectos y tareas de los cadetes, mejorando el control, la organización y el análisis de la información.

Objetivo General:
Desarrollar una base de datos que permita gestionar las tareas y proyectos de los cadetes de una empresa, garantizando la asignación eficiente de actividades, el control de estados y la trazabilidad de la información.
Objetivos Específicos:
● Diseñar un modelo de datos que contemple usuarios (cadetes), proyectos, tareas, estados, categorías y roles.
● Implementar una estructura que permita asignar tareas a cadetes de manera clara y controlada.

● Registrar los estados de cada tarea (pendiente, en proceso, finalizada, cancelada).

● Clasificar las tareas por categorías para un mejor análisis (ejemplo: trámites bancarios, mensajería, compras).

● Incorporar comentarios como mecanismo de seguimiento de cada actividad.

● Generar un sistema de registros que facilite la obtención de reportes históricos y de desempeño.

## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

En la actualidad, las empresas buscan optimizar la gestión de tareas internas y externas para mejorar su productividad. Los cadetes cumplen un rol fundamental, ya que son responsables de trámites, entregas, correspondencia y diversas actividades que requieren organización y control.
El diseño de una base de datos relacional permite centralizar y estructurar la información relacionada con estas tareas, garantizando integridad, trazabilidad y eficiencia en la administración.
Los conceptos fundamentales que sustentan el proyecto son:
● Base de datos relacional: modelo que organiza la información en tablas relacionadas entre sí mediante claves primarias y foráneas, garantizando la integridad de los datos.

● Gestión de tareas: práctica que permite organizar, asignar y controlar actividades específicas de una organización, mejorando la productividad y evitando pérdidas de información.

● Roles y usuarios: cada participante del sistema tiene un rol definido (ejemplo: cadete, supervisor), lo que permite controlar permisos y responsabilidades.

● Estados de tareas: permiten conocer en qué situación se encuentra cada actividad (pendiente, en curso, finalizada, cancelada).

● Categorías de tareas: posibilitan clasificar los distintos tipos de actividades (ejemplo: trámites bancarios, compras, mensajería).

● TICs (Tecnologías de la Información y la Comunicación): proporcionan herramientas que permiten digitalizar procesos que tradicionalmente se realizaban de forma manual.

De este modo, el sistema se fundamenta en innovaciones tecnológicas aplicadas a la gestión organizacional, contribuyendo a un mayor control, análisis y planificación de las actividades de los cadetes dentro de una empresa.

<<<<<<< HEAD:script/gestion_tareas.md
**TEMA 1 " ---- "**
Ut sed imperdiet risus. Maecenas vestibulum arcu vitae orci pretium pharetra. Suspendisse potenti. Fusce massa libero, fermentum eget elit in, tincidunt fermentum nunc. Cras imperdiet nisl elit, elementum gravida enim accumsan vel. Sed in sapien quis ante consectetur commodo id non nulla. Aenean lacinia, dolor convallis semper mattis, ante orci elementum nunc, eget feugiat risus neque in urna. Ut ut quam nec risus mollis convallis ornare ac odio. Phasellus efficitur posuere nibh, eget tempor augue pellentesque ac. Ut enim sem, imperdiet non est ut, blandit posuere dui. Curabitur at purus orci. Interdum et malesuada fames ac ante ipsum primis in faucibus.

**TEMA 2 " ----- "**
Ut sed imperdiet risus. Maecenas vestibulum arcu vitae orci pretium pharetra. Suspendisse potenti. Fusce massa libero, fermentum eget elit in, tincidunt fermentum nunc. Cras imperdiet nisl elit, elementum gravida enim accumsan vel. Sed in sapien quis ante consectetur commodo id non nulla. Aenean lacinia, dolor convallis semper mattis, ante orci elementum nunc, eget feugiat risus neque in urna. Ut ut quam nec risus mollis convallis ornare ac odio. Phasellus efficitur posuere nibh, eget tempor augue pellentesque ac. Ut enim sem, imperdiet non est ut, blandit posuere dui. Curabitur at purus orci. Interdum et malesuada fames ac ante ipsum primis in faucibus.
=======

**TEMA 1 " Procedimientos y Funciones Almacenadas "** 
Para el Tema 1 investigamos en profundidad sobre los procedimientos y funciones almacenadas, elementos esenciales para estructurar y optimizar la lógica dentro de una base de datos SQL Server. Los procedimientos almacenados permiten ejecutar operaciones complejas, realizar tareas CRUD, manejar transacciones y encapsular la lógica de negocio, logrando mejor rendimiento gracias a los planes de ejecución cacheados y mayor seguridad al otorgar solo permisos de ejecución. Por otro lado, las funciones almacenadas están orientadas exclusivamente al cálculo: siempre devuelven un valor, ya sea escalar o una tabla, y no pueden modificar datos, lo que las hace ideales para usarse dentro de SELECT, WHERE o JOIN. Además, facilitan la reutilización de lógica y la escritura de consultas más limpias. En conclusión, los procedimientos se utilizan principalmente para acciones y manipulación de datos, mientras que las funciones se emplean para cálculos y obtener información de manera controlada.


**TEMA 2 " Optimización de Consultas a Través de Índices "** 
En el Tema 2 investigamos la importancia de los índices como herramienta fundamental para mejorar el rendimiento de las consultas en una base de datos. Los índices funcionan como estructuras ordenadas que almacenan una copia parcial de ciertas columnas, permitiendo que el motor encuentre datos rápidamente sin recorrer toda la tabla. Esto acelera notablemente las consultas SELECT, especialmente en tablas grandes, aunque a la vez degrada el rendimiento de INSERT, UPDATE y DELETE, ya que cada cambio en la tabla también debe reflejarse en el índice. Existen índices agrupados (que organizan físicamente los datos según el índice) y no agrupados (que funcionan como un índice de libro, apuntando a la ubicación real de los datos). Su estructura interna se basa en árboles B, con nodos internos que guían la búsqueda y nodos hoja que contienen ya sea datos reales (agrupado) o punteros (no agrupado). Además, comprendimos que el motor de SQL Server utiliza el plan de ejecución estimado para decidir la forma más eficiente de acceder a los datos, aprovechando los índices disponibles. En conclusión, los índices son esenciales para optimizar tiempos de lectura y mejorar el desempeño general de consultas complejas.
>>>>>>> 527034b (se añaden las descripciones de cada tema en el archivo md del proyecto):script/gestion_tareas_cadetes.md

**TEMA 3 " Manejo de Transacciones y Transacciones Anidadas "** 
En este tema investigamos el funcionamiento de las transacciones, un mecanismo fundamental para garantizar la integridad y consistencia de los datos en una base de datos. Una transacción agrupa varias operaciones SQL que deben ejecutarse como una unidad: o se completan todas correctamente o se revierten por completo, siguiendo las propiedades ACID que aseguran atomicidad, consistencia, aislamiento y durabilidad. También estudiamos las transacciones anidadas, que permiten dividir un proceso complejo en subtransacciones e incorporar puntos de guardado mediante SAVE TRANSACTION, lo que facilita manejar errores parciales sin afectar inmediatamente a toda la transacción principal. Entendimos que, aunque SQL Server no soporta transacciones anidadas de forma total, sí permite controlarlas a través de savepoints, que funcionan como “marcas” para revertir solo una parte del proceso. Mediante ejemplos prácticos, vimos cómo una transacción simple puede confirmar o revertir operaciones completas, mientras que una transacción anidada otorga mayor control ante fallos específicos dentro de un bloque mayor. En resumen, dominar las transacciones y sus variantes es clave para asegurar que los datos permanezcan fiables incluso ante errores en la ejecución.

**TEMA 4: " Vistas y Vistas Indexadas "**
En este tema investigamos el funcionamiento de las vistas, un objeto de base de datos que permite representar el resultado de una consulta SQL sin almacenar datos físicamente. Comprendimos que una vista funciona como una “ventana” a los datos, ya que toma su información directamente de las tablas base, lo cual facilita simplificar consultas complejas, mejorar la seguridad restringiendo columnas sensibles y reutilizar lógica SQL sin duplicar código. Además, estudiamos las vistas indexadas, que se diferencian de las vistas comunes porque almacenan físicamente el resultado mediante un índice clustered único, convirtiéndose en una estructura materializada que acelera muchísimo consultas frecuentes o agregadas. Sin embargo, también analizamos que su mantenimiento es más costoso, ya que cada modificación en las tablas subyacentes debe reflejarse en la vista.

Vimos que para crear una vista indexada deben cumplirse requisitos estrictos, como el uso obligatorio de WITH SCHEMABINDING, que “ata” la vista a sus tablas y evita que estas puedan modificarse sin antes eliminar la vista. También observamos que todas las tablas deben estar referenciadas con su esquema (por ejemplo, dbo.usuarios) y que no se pueden usar otras vistas dentro de la definición. Luego de crear la vista, se debe generar un índice clustered único que materializa efectivamente los datos. Esto permite que SQL Server consulte la vista mucho más rápido sin tener que recalcularla cada vez. Finalmente, comprendimos que aunque las vistas comunes sirven principalmente para organización, seguridad y simplificación, las vistas indexadas se orientan específicamente a la mejora del rendimiento.
...

## CAPÍTULO III: METODOLOGÍA SEGUIDA

a) Descripción de cómo se realizó el Trabajo Práctico
El desarrollo del trabajo se llevó a cabo siguiendo las siguientes etapas:

1. Identificación del caso de estudio: se definió como problemática la falta de organización en la gestión de tareas y proyectos de los cadetes de una empresa.

2. Relevamiento de requerimientos: se analizaron las necesidades de información a gestionar: usuarios, roles, proyectos, tareas, estados, categorías y comentarios.

3. Diseño del modelo entidad-relación (MER): se identificaron las entidades, atributos y relaciones.

4. Normalización: se organizaron las tablas para evitar redundancias y asegurar consistencia de datos.

5. Construcción del diccionario de datos: se definieron formalmente los campos, claves primarias y foráneas.

6. Validación del modelo: se verificó que la base de datos cumpla con los objetivos del proyecto.

b) Herramientas (Instrumentos y procedimientos)
● Revisión bibliográfica y guía de cátedra: se utilizó la guía de elaboración del proyecto como marco de referencia metodológico.

● Diagramación: el modelo entidad-relación fue construido con la herramienta ERDPlus, que permite generar diagramas E/R, esquemas relacionales y exportar el modelo de datos.

● Análisis de requerimientos: se trabajó con ejemplos prácticos de las actividades típicas de los cadetes.

● Lenguaje SQL: se prevé la implementación del modelo en un gestor de base de datos (ejemplo: MySQL o PostgreSQL).

## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS

En este capítulo se presentan los principales resultados obtenidos del análisis y diseño del sistema:

1. Identificación de entidades principales:

○ Usuario (cadetes de la empresa).

○ Proyecto (conjunto de tareas o actividades).

○ Tarea (unidad de trabajo a realizar por un cadete).

○ Estado (situación de cada tarea).

○ Categoría (clasificación de tareas).

○ Rol (función que cumple un usuario dentro de un proyecto).

○ Asignación (relación entre usuario, proyecto y rol).

○ Comentario (seguimiento de tareas).

2. Modelo entidad-relación (MER):

○ El diagrama diseñado muestra cómo se relacionan las entidades de forma clara y estructurada.

○ Se garantiza la integridad de los datos a través de claves primarias y foráneas.

### Diagrama conceptual (opcional)

Ejemplo usando Live Editor https://mermaid.js.org/ (ejemplo opcional)

```mermaid
erDiagram
CUSTOMER  }|..|{  DELIVERY-ADDRESS  : has
CUSTOMER  ||--o{  ORDER  : places
CUSTOMER  ||--o{  INVOICE  : "liable for"
DELIVERY-ADDRESS  ||--o{  ORDER  : receives
INVOICE  ||--|{  ORDER  : covers
ORDER  ||--|{  ORDER-ITEM  : includes
PRODUCT-CATEGORY  ||--|{  PRODUCT  : contains
PRODUCT  ||--o{  ORDER-ITEM  : "ordered in"
```

### Diagrama relacional

![diagrama_relacional](https://github.com/dovillegas/basesdatos_proyecto_estudio/blob/main/doc/image_relational.png)

### Diccionario de datos

Acceso al documento [PDF](doc/diccionario_datos.pdf) del diccionario de datos.

### Desarrollo TEMA 1 "----"

Fusce auctor finibus lectus, in aliquam orci fermentum id. Fusce sagittis lacus ante, et sodales eros porta interdum. Donec sed lacus et eros condimentum posuere.

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_1](script/tema01_nombre_tema)

### Desarrollo TEMA 2 "----"

Proin aliquet mauris id ex venenatis, eget fermentum lectus malesuada. Maecenas a purus arcu. Etiam pellentesque tempor dictum.

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_2](script/tema02_nombre_tema)

...

## CAPÍTULO V: CONCLUSIONES

Nunc sollicitudin purus quis ante sodales luctus. Proin a scelerisque libero, vitae pharetra lacus. Nunc finibus, tellus et dictum semper, nisi sem accumsan ligula, et euismod quam ex a tellus.

## BIBLIOGRAFÍA DE CONSULTA

1.  List item
2.  List item
3.  List item
4.  List item
5.  List item
