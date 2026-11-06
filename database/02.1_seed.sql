/*
============================================================
ARCHIVO: 02_seed.sql
============================================================

FUNCIÓN:
Insertar datos iniciales y datos de prueba en las tablas
de nuestra base de datos.

IMPORTANCIA:
Una estructura de tablas vacía no permite comprobar
completamente el funcionamiento de una base de datos.

Este archivo proporciona registros que nos permitirán:

- Comprobar que las tablas aceptan información.
- Verificar las relaciones entre tablas.
- Probar las restricciones de integridad.
- Ejecutar consultas SQL con información realista.
- Simular escenarios del funcionamiento del sistema.

DIFERENCIA ENTRE DATOS INICIALES Y DATOS DE PRUEBA:

DATOS INICIALES (SEED DATA):
Información necesaria para que el sistema pueda comenzar
a funcionar.

Ejemplos:
- Roles de usuario.
- Categorías predeterminadas.
- Estados de operaciones.
- Tipos de documentos.

DATOS DE PRUEBA (TEST DATA):
Información creada para comprobar el funcionamiento
de la base de datos durante el desarrollo.

Ejemplos:
- Estudiantes ficticios.
- Productos de prueba.
- Pedidos simulados.
- Registros de operaciones.

ORDEN DE EJECUCIÓN:

1. 00_create_db.sql
2. 01_schema.sql
3. 02_seed.sql
4. 03_queries.sql

IMPORTANTE:
Las tablas deben existir antes de insertar registros.

Los datos deben respetar los tipos de datos, las restricciones
y las relaciones definidas en 01_schema.sql.

============================================================
*/


/*
------------------------------------------------------------
1. INSERT INTO
------------------------------------------------------------

INSERT INTO:
Instrucción SQL utilizada para insertar nuevos registros
en una tabla.

SINTAXIS GENERAL:

INSERT INTO nombre_tabla (columna1, columna2)
VALUES (valor1, valor2);

RECOMENDACIÓN:
Especificar siempre los nombres de las columnas.

Esto permite identificar claramente dónde se insertará
cada valor y evita depender del orden físico de las columnas.

EJEMPLO:

INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com');
*/


/*
------------------------------------------------------------
2. INSERCIÓN DE MÚLTIPLES REGISTROS
------------------------------------------------------------

Podemos insertar varios registros en una misma instrucción
utilizando VALUES y separando cada conjunto de valores
mediante comas.

SINTAXIS:

INSERT INTO nombre_tabla (columna1, columna2)
VALUES
    (valor1, valor2),
    (valor3, valor4),
    (valor5, valor6);

VENTAJAS:

- Reduce la cantidad de instrucciones SQL.
- Facilita la carga de datos de prueba.
- Permite insertar varios registros en una operación.

EJEMPLO:

INSERT INTO students (first_name, last_name, email)
VALUES
    ('Ana', 'García', 'ana@example.com'),
    ('Luis', 'Pérez', 'luis@example.com'),
    ('María', 'López', 'maria@example.com');
*/


/*
------------------------------------------------------------
3. ORDEN DE INSERCIÓN Y CLAVES FORÁNEAS
------------------------------------------------------------

Cuando existen relaciones entre tablas, debemos respetar
las dependencias establecidas mediante FOREIGN KEY.

EJEMPLO:

students
   |
   v
enrollments
   ^
   |
courses

La tabla enrollments contiene referencias a students
y courses.

Por lo tanto, primero debemos insertar los estudiantes
y los cursos, y después las inscripciones.

ORDEN:

1. Insertar registros en students.
2. Insertar registros en courses.
3. Insertar registros en enrollments.

IMPORTANTE:
No podemos insertar una clave foránea que haga referencia
a un registro inexistente.
*/


/*
------------------------------------------------------------
4. VALORES Y TIPOS DE DATOS
------------------------------------------------------------

Los valores insertados deben corresponder con los tipos
de datos definidos en el esquema.

EJEMPLOS:

TEXTO:
'Gustavo'

NÚMERO ENTERO:
25

NÚMERO DECIMAL:
150.75

BOOLEAN:
TRUE
FALSE

FECHA:
'2026-11-06'

FECHA Y HORA:
'2026-11-06 10:30:00'

NULL:
NULL

IMPORTANTE:
NULL representa ausencia de valor.
No es equivalente a una cadena vacía ('') ni al número 0.

Las fechas deben utilizar formatos compatibles
con PostgreSQL.
*/


/*
------------------------------------------------------------
5. VALORES GENERADOS AUTOMÁTICAMENTE
------------------------------------------------------------

Cuando una columna utiliza SERIAL o IDENTITY,
PostgreSQL genera automáticamente su identificador.

EJEMPLO:

CREATE TABLE students (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO students (name)
VALUES ('Ana');

No necesitamos proporcionar el valor de id.

IMPORTANTE:
Si utilizamos GENERATED ALWAYS AS IDENTITY,
PostgreSQL no acepta normalmente valores explícitos
para esa columna, salvo que se utilice OVERRIDING SYSTEM VALUE.

Por eso, al insertar registros comunes, omitimos
las columnas con generación automática.
*/


/*
------------------------------------------------------------
6. INSERT ... RETURNING
------------------------------------------------------------

RETURNING:
Permite obtener información de los registros que acabamos
de insertar.

Es especialmente útil cuando necesitamos recuperar
un identificador generado automáticamente.

EJEMPLO:

INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com')
RETURNING id;

RESULTADO:
PostgreSQL devuelve el identificador asignado al registro.

También podemos recuperar varias columnas:

RETURNING id, first_name, email;
*/


/*
------------------------------------------------------------
7. ON CONFLICT
------------------------------------------------------------

ON CONFLICT:
Permite definir qué hacer cuando una inserción provoca
un conflicto con una restricción UNIQUE o PRIMARY KEY.

DO NOTHING:
Ignora la inserción cuando se produce el conflicto.

DO UPDATE:
Actualiza los valores del registro que produjo el conflicto.

EJEMPLO:

INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com')
ON CONFLICT (email) DO NOTHING;

IMPORTANTE:
Es útil para que ciertos datos iniciales puedan cargarse
más de una vez sin producir errores por duplicados.

Sin embargo, debemos elegir cuidadosamente qué hacer
cuando un registro ya existe.

No debemos ignorar conflictos indiscriminadamente,
porque podríamos ocultar errores en los datos.
*/


/*
------------------------------------------------------------
8. TRANSACCIONES
------------------------------------------------------------

Una transacción permite agrupar varias operaciones
para que se ejecuten como una unidad lógica.

BEGIN:
Inicia una transacción.

COMMIT:
Confirma los cambios realizados.

ROLLBACK:
Revierte los cambios de la transacción.

EJEMPLO:

BEGIN;

INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com');

INSERT INTO courses (name)
VALUES ('Bases de datos');

COMMIT;

IMPORTANTE:
Si ocurre un error y queremos cancelar las operaciones,
podemos utilizar ROLLBACK en lugar de COMMIT.

Las transacciones permiten mantener la consistencia
cuando varias inserciones dependen unas de otras.
*/


/*
------------------------------------------------------------
9. DATOS DE PRUEBA
------------------------------------------------------------

Los siguientes registros son únicamente ilustrativos.

Debemos reemplazarlos por información ficticia que
corresponda con las tablas reales del proyecto.

EJEMPLO:

INSERT INTO students (first_name, last_name, email)
VALUES
    ('Ana', 'García', 'ana@example.com'),
    ('Luis', 'Pérez', 'luis@example.com'),
    ('María', 'López', 'maria@example.com');

INSERT INTO courses (name, description)
VALUES
    ('Bases de datos', 'Fundamentos de SQL y modelado'),
    ('Programación', 'Introducción a la programación');

IMPORTANTE:
No utilizar información personal real en bases de datos
de prueba cuando no sea necesaria.
*/


/*
------------------------------------------------------------
10. VALIDACIÓN DE LOS REGISTROS
------------------------------------------------------------

Después de insertar información debemos comprobar
que los registros se hayan almacenado correctamente.

SELECT:
Permite consultar información de una tabla.

EJEMPLO:

SELECT * FROM students;

CONSULTAR UN NÚMERO LIMITADO DE REGISTROS:

SELECT *
FROM students
LIMIT 10;

CONTAR REGISTROS:

SELECT COUNT(*)
FROM students;

COMPROBAR RELACIONES:

SELECT
    students.first_name,
    courses.name AS course_name
FROM enrollments
INNER JOIN students
    ON enrollments.student_id = students.id
INNER JOIN courses
    ON enrollments.course_id = courses.id;

IMPORTANTE:
Las consultas de validación también pueden documentarse
en 03_queries.sql para mantener separados los datos
de prueba y las consultas del proyecto.
*/


/*
------------------------------------------------------------
11. LIMPIEZA DE DATOS DE PRUEBA
------------------------------------------------------------

Durante el desarrollo puede ser necesario eliminar
los registros de prueba para comenzar nuevamente.

DELETE:
Elimina registros de una tabla.

TRUNCATE:
Elimina todos los registros de una tabla de forma eficiente.

TRUNCATE TABLE students;

RESTART IDENTITY:
Permite reiniciar las secuencias asociadas a columnas
de identidad o serial de las tablas truncadas.

CASCADE:
Puede incluir tablas relacionadas que tengan dependencias
por claves foráneas.

EJEMPLO:

TRUNCATE TABLE enrollments, students, courses
RESTART IDENTITY;

IMPORTANTE:
Estas operaciones pueden eliminar información.
No deben ejecutarse indiscriminadamente en producción.

Debemos respetar las dependencias entre tablas
y asegurarnos de que estamos trabajando en el entorno correcto.
*/


/*
------------------------------------------------------------
12. RECOMENDACIONES PARA LOS DATOS INICIALES
------------------------------------------------------------

- Insertar primero los registros independientes.
- Respetar las claves foráneas.
- Utilizar datos ficticios para pruebas.
- Evitar duplicados innecesarios.
- Utilizar transacciones cuando varias operaciones
  deban completarse juntas.
- No almacenar contraseñas en texto plano.
- Mantener consistencia con las restricciones del esquema.
- Separar los datos necesarios para iniciar el sistema
  de los registros utilizados exclusivamente para pruebas.
- Evitar incluir datos sensibles reales en repositorios públicos.

============================================================
FIN DEL ARCHIVO
============================================================

RESULTADO ESPERADO:

- Las tablas contienen registros iniciales o de prueba.
- Las relaciones mantienen su integridad.
- Los valores respetan las restricciones.
- Las consultas pueden ejecutarse sobre información.
- El entorno está preparado para validar el funcionamiento
  de la base de datos.

SIGUIENTE ARCHIVO:

03_queries.sql

En ese archivo documentaremos consultas SQL para recuperar,
filtrar, relacionar, agrupar y analizar información.
============================================================
*/