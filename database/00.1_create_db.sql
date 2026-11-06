/*
============================================================
ARCHIVO: 00_create_db.sql
============================================================

FUNCIÓN:
Crear la base de datos del proyecto en PostgreSQL.

IMPORTANCIA:
Este archivo representa el primer paso de implementación.
Prepara el espacio lógico donde posteriormente crearemos
tablas, relaciones, restricciones, índices y datos.

ORDEN DE EJECUCIÓN:

1. Ejecutar este archivo desde una conexión a otra base de datos,
   por ejemplo, postgres.
2. Conectarse a la base de datos recién creada.
3. Ejecutar 01_schema.sql.
4. Ejecutar 02_seed.sql.
5. Ejecutar 03_queries.sql.

IMPORTANTE:
PostgreSQL no permite ejecutar CREATE DATABASE dentro
de un bloque de transacción.

Por lo tanto, no debemos envolver esta instrucción
en BEGIN y COMMIT.

Además, CREATE DATABASE no admite IF NOT EXISTS.
Si la base de datos ya existe, PostgreSQL devolverá un error.

============================================================
*/

/*
------------------------------------------------------------
1. CREACIÓN DE LA BASE DE DATOS
------------------------------------------------------------

CREATE DATABASE:
Instrucción SQL que crea una nueva base de datos.

SINTAXIS GENERAL:

CREATE DATABASE nombre_base_datos;

El nombre debe ser único dentro de la instancia de PostgreSQL.

Convención recomendada:
Utilizar nombres en minúsculas, sin espacios y separados
por guiones bajos cuando sea necesario.

EJEMPLO:
funval_academia
*/

CREATE DATABASE nombre_base_datos;


/*
------------------------------------------------------------
2. CONFIGURACIÓN DEL PROPIETARIO
------------------------------------------------------------

OWNER:
Define el rol de PostgreSQL que será propietario
de la base de datos.

El propietario tendrá facultades administrativas
sobre los objetos que le pertenecen, sujeto a las
reglas de privilegios de PostgreSQL.

EJEMPLO:

CREATE DATABASE academia
    OWNER usuario_admin;

IMPORTANTE:
El rol indicado debe existir y el usuario que ejecuta
la instrucción debe tener los privilegios necesarios.
*/

/*
------------------------------------------------------------
3. CONFIGURACIÓN DE CODIFICACIÓN
------------------------------------------------------------

ENCODING:
Define cómo se representan los caracteres almacenados.

UTF8:
Es una codificación ampliamente utilizada y recomendada
para aplicaciones modernas porque permite almacenar
caracteres de diferentes idiomas.

Ejemplos:
- Español: á, é, í, ó, ú, ñ.
- Inglés: English.
- Otros alfabetos y símbolos Unicode.

EJEMPLO:

CREATE DATABASE academia
    ENCODING 'UTF8';

IMPORTANTE:
La codificación debe ser compatible con la plantilla
utilizada para crear la base de datos.
*/

/*
------------------------------------------------------------
4. CONFIGURACIÓN DE ORDENAMIENTO Y CLASIFICACIÓN
------------------------------------------------------------

LC_COLLATE:
Define los criterios de comparación y ordenamiento
de cadenas de caracteres.

LC_CTYPE:
Define las reglas de clasificación de caracteres,
como letras, números y conversiones de mayúsculas.

Estos parámetros pueden afectar operaciones como ORDER BY
y algunas comparaciones de texto.

IMPORTANTE:
Los valores disponibles dependen del sistema operativo
y de las configuraciones regionales instaladas.

No debemos copiar valores de otro equipo sin comprobar
que estén disponibles en el entorno actual.
*/

/*
------------------------------------------------------------
5. CONFIGURACIÓN DE LA PLANTILLA
------------------------------------------------------------

TEMPLATE:
Especifica la base de datos que PostgreSQL utilizará
como origen para crear la nueva base de datos.

template0:
Plantilla limpia que permite establecer configuraciones
de codificación y localización diferentes de las
de la plantilla predeterminada.

template1:
Plantilla predeterminada de PostgreSQL.

IMPORTANTE:
En proyectos comunes podemos utilizar el valor
predeterminado sin especificar TEMPLATE.
*/

/*
------------------------------------------------------------
6. COMENTARIO DESCRIPTIVO DE LA BASE DE DATOS
------------------------------------------------------------

COMMENT ON DATABASE:
Permite agregar una descripción a la base de datos.

Esto facilita identificar su propósito cuando existen
varias bases de datos dentro de una misma instancia.

SINTAXIS:

COMMENT ON DATABASE nombre_base_datos
IS 'Descripción de la base de datos';

Esta instrucción se ejecuta después de crear la base
de datos y desde una conexión que tenga acceso a ella.
*/

/*
------------------------------------------------------------
7. EJEMPLO DE CONFIGURACIÓN COMPLETA
------------------------------------------------------------

El siguiente ejemplo es ilustrativo.
Debemos adaptar el nombre de la base de datos y el propietario
a las condiciones de cada proyecto.

Para configuraciones regionales, primero verificar
los valores disponibles en el entorno.
*/

/*
CREATE DATABASE academia
    WITH
    OWNER = usuario_admin
    ENCODING = 'UTF8'
    TEMPLATE = template0;

COMMENT ON DATABASE academia
IS 'Base de datos para administrar una academia';
*/

/*
============================================================
FIN DEL ARCHIVO
============================================================

RESULTADO ESPERADO:

- La base de datos ha sido creada.
- El propietario ha sido definido, si corresponde.
- La codificación es compatible con el proyecto.
- La descripción permite identificar su propósito.

SIGUIENTE ARCHIVO:

01_schema.sql

En ese archivo construiremos las tablas, columnas,
claves primarias, claves foráneas y restricciones.
============================================================
*/