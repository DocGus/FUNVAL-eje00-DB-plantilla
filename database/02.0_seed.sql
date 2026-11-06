# 02_seed.sql — Inserción de datos iniciales y de prueba

```sql
/*
============================================================
ARCHIVO: 02_seed.sql

FUNCIÓN:
Insertar datos iniciales y datos de prueba en las tablas.

IMPORTANCIA:
Permite comprobar que las tablas aceptan información,
que las relaciones funcionan y que las restricciones
de integridad se cumplen.

TIPOS DE DATOS:

SEED DATA:
Información necesaria para iniciar el sistema.
Ejemplos: roles, categorías, estados y tipos de documentos.

TEST DATA:
Información ficticia para probar el sistema.
Ejemplos: estudiantes, productos y pedidos simulados.

ORDEN DE EJECUCIÓN:
1. 00_create_db.sql
2. 01_schema.sql
3. 02_seed.sql
4. 03_queries.sql

IMPORTANTE:
Las tablas deben existir y los datos deben respetar
sus tipos, restricciones y relaciones.
============================================================
*/

/*
------------------------------------------------------------
1. INSERT INTO
------------------------------------------------------------

Inserta nuevos registros en una tabla.

SINTAXIS:
INSERT INTO nombre_tabla (columna1, columna2)
VALUES (valor1, valor2);

RECOMENDACIÓN:
Especificar siempre los nombres de las columnas.
Así evitamos depender del orden físico de la tabla.

EJEMPLO:
*/
INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com');

/*
------------------------------------------------------------
2. INSERCIÓN DE MÚLTIPLES REGISTROS
------------------------------------------------------------

Permite insertar varios registros en una instrucción.

EJEMPLO:
*/
INSERT INTO students (first_name, last_name, email)
VALUES
    ('Ana', 'García', 'ana@example.com'),
    ('Luis', 'Pérez', 'luis@example.com'),
    ('María', 'López', 'maria@example.com');

/*
VENTAJAS:
- Reduce instrucciones SQL.
- Facilita la carga de datos de prueba.
- Permite insertar varios registros en una operación.
*/

/*
------------------------------------------------------------
3. ORDEN DE INSERCIÓN Y CLAVES FORÁNEAS
------------------------------------------------------------

Debemos respetar las dependencias establecidas mediante
FOREIGN KEY.

EJEMPLO:
students ──┐
           ├── enrollments
courses ───┘

ORDEN:
1. Insertar en students.
2. Insertar en courses.
3. Insertar en enrollments.

IMPORTANTE:
No podemos insertar una clave foránea que haga referencia
a un registro inexistente.
*/

/*
------------------------------------------------------------
4. VALORES Y TIPOS DE DATOS
------------------------------------------------------------

Los valores deben corresponder con los tipos definidos
en el esquema.

EJEMPLOS:
- Texto: 'Gustavo'
- Entero: 25
- Decimal: 150.75
- Boolean: TRUE / FALSE
- Fecha: '2026-11-06'
- Fecha y hora: '2026-11-06 10:30:00'
- Ausencia de valor: NULL

IMPORTANTE:
NULL no equivale a una cadena vacía ('') ni al número 0.
Utilizar formatos de fecha compatibles con PostgreSQL.
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
Con GENERATED ALWAYS AS IDENTITY normalmente se omite
el identificador manual. OVERRIDING SYSTEM VALUE permite
una asignación explícita en los casos correspondientes.
*/

/*
------------------------------------------------------------
6. INSERT ... RETURNING
------------------------------------------------------------

Permite recuperar información de los registros insertados.

Es útil para obtener identificadores generados automáticamente.

EJEMPLO:
*/
INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com')
RETURNING id;

/*
También podemos recuperar varias columnas:
RETURNING id, first_name, email;
*/

/*
------------------------------------------------------------
7. ON CONFLICT
------------------------------------------------------------

Define qué hacer cuando una inserción entra en conflicto
con una restricción UNIQUE o PRIMARY KEY.

DO NOTHING:
Ignora la inserción cuando ocurre el conflicto.

DO UPDATE:
Actualiza el registro que produjo el conflicto.

EJEMPLO:
*/
INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com')
ON CONFLICT (email) DO NOTHING;

/*
IMPORTANTE:
Útil para cargar ciertos datos iniciales más de una vez.
Elegir cuidadosamente cómo resolver conflictos para
no ocultar errores o inconsistencias.
*/

/*
------------------------------------------------------------
8. TRANSACCIONES
------------------------------------------------------------

Agrupan varias operaciones como una unidad lógica.

- BEGIN: inicia la transacción.
- COMMIT: confirma los cambios.
- ROLLBACK: revierte los cambios.

EJEMPLO:
*/
BEGIN;

INSERT INTO students (first_name, last_name, email)
VALUES ('Ana', 'García', 'ana@example.com');

INSERT INTO courses (name)
VALUES ('Bases de datos');

COMMIT;

/*
Si ocurre un error y queremos cancelar las operaciones,
utilizamos ROLLBACK en lugar de COMMIT.

Las transacciones ayudan a mantener la consistencia
cuando varias inserciones dependen unas de otras.
*/

/*
------------------------------------------------------------
9. DATOS DE PRUEBA
------------------------------------------------------------

Los siguientes registros son ilustrativos.
Reemplazarlos por información ficticia adaptada
a las tablas reales del proyecto.

EJEMPLO:
*/
INSERT INTO students (first_name, last_name, email)
VALUES
    ('Ana', 'García', 'ana@example.com'),
    ('Luis', 'Pérez', 'luis@example.com'),
    ('María', 'López', 'maria@example.com');

INSERT INTO courses (name, description)
VALUES
    ('Bases de datos', 'Fundamentos de SQL y modelado'),
    ('Programación', 'Introducción a la programación');

/*
IMPORTANTE:
Evitar utilizar información personal real
en bases de datos de prueba.
*/

/*
------------------------------------------------------------
10. VALIDACIÓN DE LOS REGISTROS
------------------------------------------------------------

Comprobar que los registros se almacenaron correctamente.

CONSULTAR TODOS LOS REGISTROS:
*/
SELECT * FROM students;

/*
CONSULTAR UN NÚMERO LIMITADO:
*/
SELECT * FROM students LIMIT 10;

/*
CONTAR REGISTROS:
*/
SELECT COUNT(*) FROM students;

/*
COMPROBAR RELACIONES:
*/
SELECT
    students.first_name,
    courses.name AS course_name
FROM enrollments
INNER JOIN students
    ON enrollments.student_id = students.id
INNER JOIN courses
    ON enrollments.course_id = courses.id;

/*
Las consultas de validación también pueden documentarse
en 03_queries.sql para separar los datos de prueba
de las consultas del proyecto.
*/

/*
------------------------------------------------------------
11. LIMPIEZA DE DATOS DE PRUEBA
------------------------------------------------------------

DELETE:
Elimina registros de una tabla.

TRUNCATE:
Elimina todos los registros de una tabla eficientemente.

RESTART IDENTITY:
Reinicia las secuencias asociadas a las columnas
de identidad o serial de las tablas truncadas.

CASCADE:
Puede incluir tablas relacionadas con dependencias
por claves foráneas.

EJEMPLO:
*/
TRUNCATE TABLE enrollments, students, courses
RESTART IDENTITY;

/*
IMPORTANTE:
Estas operaciones pueden eliminar información.
No ejecutarlas indiscriminadamente en producción.
Respetar dependencias y verificar el entorno de trabajo.
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
- Nunca almacenar contraseñas en texto plano.
- Respetar las restricciones del esquema.
- Separar datos iniciales de datos exclusivamente de prueba.
- Evitar datos sensibles reales en repositorios públicos.

============================================================
RESULTADO ESPERADO:
- Tablas con datos iniciales o de prueba.
- Relaciones que mantienen su integridad.
- Valores que respetan las restricciones.
- Información disponible para ejecutar consultas.
- Entorno preparado para validar la base de datos.

SIGUIENTE ARCHIVO:
03_queries.sql

Aquí documentaremos consultas para recuperar, filtrar,
relacionar, agrupar y analizar información.
============================================================
*/
```
