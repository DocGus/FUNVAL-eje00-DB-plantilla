# 00_create_db.sql — Creación de la base de datos

```sql
/*
============================================================
ARCHIVO: 00_create_db.sql

FUNCIÓN:
Crear la base de datos del proyecto en PostgreSQL.

IMPORTANCIA:
Es el primer paso de implementación. Prepara el espacio
donde posteriormente se crearán tablas, relaciones,
restricciones, índices y datos.

ORDEN DE EJECUCIÓN:
1. Ejecutar desde otra base de datos (por ejemplo, postgres).
2. Conectarse a la nueva base de datos.
3. Ejecutar 01_schema.sql.
4. Ejecutar 02_seed.sql.
5. Ejecutar 03_queries.sql.

IMPORTANTE:
- CREATE DATABASE no puede ejecutarse dentro de una transacción.
- No utilizar BEGIN y COMMIT.
- No admite IF NOT EXISTS.
- Si la base de datos ya existe, PostgreSQL genera un error.
============================================================
*/

/*
------------------------------------------------------------
1. CREACIÓN DE LA BASE DE DATOS
------------------------------------------------------------

CREATE DATABASE:
Crea una nueva base de datos.

SINTAXIS:
CREATE DATABASE nombre_base_datos;

CONVENCIÓN:
Usar nombres en minúsculas, sin espacios y con guiones
bajos cuando sea necesario.
*/
CREATE DATABASE nombre_base_datos;

/*
------------------------------------------------------------
2. CONFIGURACIÓN DEL PROPIETARIO
------------------------------------------------------------

OWNER:
Define el rol propietario de la base de datos.

El rol debe existir y quien ejecuta la instrucción
debe contar con los privilegios necesarios.

EJEMPLO:
CREATE DATABASE academia OWNER usuario_admin;
*/

/*
------------------------------------------------------------
3. CONFIGURACIÓN DE CODIFICACIÓN
------------------------------------------------------------

ENCODING:
Define cómo se representan los caracteres almacenados.

UTF8:
Permite almacenar caracteres de distintos idiomas,
incluyendo acentos, ñ y símbolos Unicode.

La codificación debe ser compatible con la plantilla
utilizada para crear la base de datos.

EJEMPLO:
CREATE DATABASE academia ENCODING 'UTF8';
*/

/*
------------------------------------------------------------
4. CONFIGURACIÓN REGIONAL
------------------------------------------------------------

LC_COLLATE:
Define los criterios de comparación y ordenamiento
de cadenas de caracteres.

LC_CTYPE:
Define la clasificación de caracteres, como letras,
números y conversiones entre mayúsculas y minúsculas.

IMPORTANTE:
Los valores disponibles dependen del sistema operativo.
Verificar su disponibilidad antes de utilizarlos.
*/

/*
------------------------------------------------------------
5. CONFIGURACIÓN DE LA PLANTILLA
------------------------------------------------------------

TEMPLATE:
Indica la base de datos utilizada como origen.

template0:
Plantilla limpia que permite establecer configuraciones
de codificación y localización diferentes.

template1:
Plantilla predeterminada de PostgreSQL.

En proyectos comunes puede utilizarse el valor
predeterminado sin especificar TEMPLATE.
*/

/*
------------------------------------------------------------
6. DESCRIPCIÓN DE LA BASE DE DATOS
------------------------------------------------------------

COMMENT ON DATABASE:
Agrega una descripción para identificar el propósito
de la base de datos.

SINTAXIS:
COMMENT ON DATABASE nombre_base_datos
IS 'Descripción';

Se ejecuta después de crear la base de datos y desde
una conexión con acceso a ella.
*/

/*
------------------------------------------------------------
7. EJEMPLO DE CONFIGURACIÓN COMPLETA
------------------------------------------------------------

Adaptar el nombre y propietario a cada proyecto.
Verificar previamente las configuraciones regionales
si se decide utilizarlas.

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
RESULTADO ESPERADO:
- Base de datos creada.
- Propietario definido, si corresponde.
- Codificación compatible con el proyecto.
- Propósito identificado mediante una descripción.

SIGUIENTE ARCHIVO:
01_schema.sql

Aquí construiremos tablas, columnas, claves primarias,
claves foráneas y restricciones.
============================================================
*/
```