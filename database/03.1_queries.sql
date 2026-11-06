/*
============================================================
ARCHIVO: 03_queries.sql
============================================================

FUNCIÓN:
Documentar y ejecutar consultas SQL para recuperar,
filtrar, relacionar, agrupar, analizar y modificar
información de la base de datos.

IMPORTANCIA:
Una base de datos no solamente almacena información.
También debe permitir recuperarla y utilizarla
de acuerdo con las necesidades del sistema.

Este archivo reúne consultas que permiten:

- Consultar registros.
- Filtrar información.
- Ordenar resultados.
- Relacionar tablas.
- Agrupar y resumir información.
- Realizar operaciones de agregación.
- Utilizar subconsultas.
- Consultar información mediante CTE.
- Insertar, actualizar y eliminar registros.
- Analizar el rendimiento de las consultas.

ORDEN DE EJECUCIÓN:

1. 00_create_db.sql
2. 01_schema.sql
3. 02_seed.sql
4. 03_queries.sql

IMPORTANTE:
Las consultas de este archivo deben adaptarse a las tablas,
columnas y relaciones reales del proyecto.

Los ejemplos incluidos son ilustrativos y utilizan
una estructura académica con las tablas:

- students
- courses
- enrollments

============================================================
*/


/*
------------------------------------------------------------
1. SELECT
------------------------------------------------------------

SELECT:
Permite recuperar información almacenada en una o varias
columnas de una tabla.

SINTAXIS:

SELECT columna1, columna2
FROM nombre_tabla;

ASTERISCO (*):

SELECT * FROM students;

El asterisco permite recuperar todas las columnas.

RECOMENDACIÓN:
En consultas de aplicaciones reales es preferible indicar
las columnas necesarias en lugar de utilizar SELECT *.

Esto facilita la lectura, evita recuperar información
innecesaria y permite controlar mejor los datos expuestos.
*/


/*
------------------------------------------------------------
2. WHERE
------------------------------------------------------------

WHERE:
Permite establecer condiciones para filtrar registros.

OPERADORES DE COMPARACIÓN:

=    Igual.
<>   Diferente.
!=   Diferente.
>    Mayor que.
<    Menor que.
>=   Mayor o igual.
<=   Menor o igual.

EJEMPLO:

SELECT *
FROM students
WHERE id = 1;

OPERADORES LÓGICOS:

AND:
Todas las condiciones deben cumplirse.

OR:
Al menos una condición debe cumplirse.

NOT:
Niega una condición.

EJEMPLO:

SELECT *
FROM students
WHERE first_name = 'Ana'
AND last_name = 'García';

IMPORTANTE:
WHERE filtra registros antes de que se realicen
las operaciones de agrupación.
*/


/*
------------------------------------------------------------
3. ORDER BY
------------------------------------------------------------

ORDER BY:
Permite ordenar los resultados de una consulta.

ASC:
Orden ascendente. Es el comportamiento predeterminado.

DESC:
Orden descendente.

EJEMPLOS:

SELECT *
FROM students
ORDER BY first_name ASC;

SELECT *
FROM students
ORDER BY id DESC;

Podemos ordenar utilizando varias columnas:

SELECT *
FROM students
ORDER BY last_name ASC, first_name ASC;

IMPORTANTE:
El orden debe ser explícito cuando el resultado
deba presentarse de manera predecible.
*/


/*
------------------------------------------------------------
4. LIMIT Y OFFSET
------------------------------------------------------------

LIMIT:
Establece el número máximo de registros que devolverá
una consulta.

OFFSET:
Indica cuántos registros deben omitirse antes
de comenzar a devolver resultados.

EJEMPLO:

SELECT *
FROM students
ORDER BY id
LIMIT 10;

PAGINACIÓN:

SELECT *
FROM students
ORDER BY id
LIMIT 10 OFFSET 20;

Esta consulta omite los primeros 20 registros
y devuelve hasta 10 registros siguientes.

FÓRMULA HABITUAL:

OFFSET = (pagina - 1) * tamaño_pagina

IMPORTANTE:
Para obtener resultados consistentes, utiliza ORDER BY.
En grandes volúmenes de información puede ser conveniente
evaluar la paginación por cursor (keyset pagination).
*/


/*
------------------------------------------------------------
5. DISTINCT
------------------------------------------------------------

DISTINCT:
Elimina duplicados del conjunto de resultados.

EJEMPLO:

SELECT DISTINCT last_name
FROM students;

También podemos utilizar varias columnas:

SELECT DISTINCT first_name, last_name
FROM students;

IMPORTANTE:
DISTINCT no modifica los registros almacenados.
Solamente elimina duplicados del resultado de la consulta.
*/


/*
------------------------------------------------------------
6. OPERADORES DE BÚSQUEDA
------------------------------------------------------------

IN:
Comprueba si un valor pertenece a una lista.

BETWEEN:
Comprueba si un valor está dentro de un intervalo,
incluyendo sus extremos.

LIKE:
Busca coincidencias utilizando patrones de texto.

ILIKE:
Similar a LIKE, pero sin distinguir entre mayúsculas
y minúsculas en PostgreSQL.

IS NULL:
Comprueba si una columna no contiene valor.

IS NOT NULL:
Comprueba si una columna contiene algún valor.

EJEMPLOS:

SELECT *
FROM students
WHERE id IN (1, 2, 3);

SELECT *
FROM students
WHERE id BETWEEN 1 AND 10;

SELECT *
FROM students
WHERE first_name LIKE 'A%';

SELECT *
FROM students
WHERE first_name ILIKE 'a%';

SELECT *
FROM students
WHERE email IS NOT NULL;

CARACTERES COMODÍN:

%:
Representa cualquier cantidad de caracteres.

_:
Representa exactamente un carácter.

IMPORTANTE:
NULL no se compara utilizando = o <>.
Debemos utilizar IS NULL o IS NOT NULL.
*/


/*
------------------------------------------------------------
7. FUNCIONES DE TEXTO Y FECHA
------------------------------------------------------------

PostgreSQL proporciona funciones para transformar
y trabajar con valores.

FUNCIONES DE TEXTO:

UPPER():
Convierte texto a mayúsculas.

LOWER():
Convierte texto a minúsculas.

LENGTH():
Devuelve la longitud del texto.

TRIM():
Elimina espacios al inicio y al final.

CONCAT():
Concatena cadenas de texto.

EJEMPLOS:

SELECT UPPER(first_name)
FROM students;

SELECT LENGTH(first_name)
FROM students;

SELECT CONCAT(first_name, ' ', last_name)
FROM students;

FUNCIONES DE FECHA:

CURRENT_DATE:
Devuelve la fecha actual.

CURRENT_TIMESTAMP:
Devuelve la fecha y hora actuales.

EXTRACT():
Extrae una parte de una fecha o marca temporal.

EJEMPLO:

SELECT EXTRACT(YEAR FROM CURRENT_DATE);

IMPORTANTE:
Las funciones disponibles y sus comportamientos dependen
del motor de base de datos.
*/


/*
------------------------------------------------------------
8. JOIN
------------------------------------------------------------

JOIN:
Permite combinar información de dos o más tablas
utilizando condiciones de relación.

INNER JOIN:
Devuelve los registros que tienen coincidencias
en ambas tablas.

LEFT JOIN:
Devuelve todos los registros de la tabla izquierda
y las coincidencias de la tabla derecha.
Cuando no existe coincidencia, las columnas derechas
contienen NULL.

RIGHT JOIN:
Devuelve todos los registros de la tabla derecha
y las coincidencias de la izquierda.

FULL OUTER JOIN:
Devuelve todos los registros de ambas tablas,
incluyendo los que no tienen coincidencia.

CROSS JOIN:
Genera todas las combinaciones posibles entre
los registros de ambas tablas.

EJEMPLO INNER JOIN:

SELECT
    students.first_name,
    students.last_name,
    enrollments.enrolled_at
FROM students
INNER JOIN enrollments
    ON students.id = enrollments.student_id;

EJEMPLO LEFT JOIN:

SELECT
    students.first_name,
    enrollments.course_id
FROM students
LEFT JOIN enrollments
    ON students.id = enrollments.student_id;

IMPORTANTE:
La condición ON determina cómo se relacionan
los registros de las tablas.
*/


/*
------------------------------------------------------------
9. ALIAS
------------------------------------------------------------

AS:
Permite asignar un nombre temporal a una columna
o a una tabla dentro de una consulta.

ALIAS DE COLUMNA:

SELECT
    first_name AS nombre,
    last_name AS apellido
FROM students;

ALIAS DE TABLA:

SELECT
    s.first_name,
    e.course_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.id = e.student_id;

VENTAJA:
Los alias hacen que las consultas sean más legibles,
especialmente cuando participan varias tablas.
*/


/*
------------------------------------------------------------
10. FUNCIONES DE AGREGACIÓN
------------------------------------------------------------

Las funciones de agregación realizan cálculos
sobre conjuntos de registros.

COUNT():
Cuenta registros o valores no NULL, según la expresión.

SUM():
Calcula la suma de valores numéricos.

AVG():
Calcula el promedio.

MIN():
Devuelve el valor mínimo.

MAX():
Devuelve el valor máximo.

EJEMPLOS:

SELECT COUNT(*)
FROM students;

SELECT MIN(id), MAX(id)
FROM students;

IMPORTANTE:
COUNT(*) cuenta todas las filas.
COUNT(columna) cuenta los valores no NULL
de esa columna.
*/


/*
------------------------------------------------------------
11. GROUP BY
------------------------------------------------------------

GROUP BY:
Agrupa registros que comparten valores en determinadas
columnas.

Se utiliza frecuentemente junto con funciones
de agregación.

EJEMPLO:

SELECT
    course_id,
    COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id;

La consulta agrupa las inscripciones por curso
y cuenta cuántas existen en cada uno.

IMPORTANTE:
Las columnas del SELECT que no estén dentro
de una función de agregación deben cumplir las reglas
de agrupación de PostgreSQL.
*/


/*
------------------------------------------------------------
12. HAVING
------------------------------------------------------------

HAVING:
Permite filtrar grupos después de aplicar GROUP BY.

DIFERENCIA ENTRE WHERE Y HAVING:

WHERE:
Filtra registros individuales antes de agrupar.

HAVING:
Filtra los grupos después de agrupar.

EJEMPLO:

SELECT
    course_id,
    COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id
HAVING COUNT(*) >= 5;

Esta consulta devuelve únicamente los cursos
que tienen cinco o más inscripciones.
*/


/*
------------------------------------------------------------
13. SUBCONSULTAS
------------------------------------------------------------

SUBCONSULTA:
Es una consulta SQL incluida dentro de otra consulta.

Puede utilizarse en:

- SELECT.
- FROM.
- WHERE.
- HAVING.

EJEMPLO:

SELECT *
FROM students
WHERE id IN (
    SELECT student_id
    FROM enrollments
);

Esta consulta devuelve los estudiantes que tienen
al menos una inscripción.

IMPORTANTE:
Una subconsulta puede depender o no de la consulta externa.
Las subconsultas correlacionadas se ejecutan conceptualmente
en función de los registros de la consulta externa.
*/


/*
------------------------------------------------------------
14. CTE (COMMON TABLE EXPRESSION)
------------------------------------------------------------

WITH:
Permite definir una expresión de tabla común (CTE)
que puede utilizarse dentro de una consulta.

VENTAJAS:

- Organizar consultas complejas.
- Separar pasos lógicos.
- Mejorar la legibilidad.
- Facilitar el mantenimiento.

EJEMPLO:

WITH course_totals AS (
    SELECT
        course_id,
        COUNT(*) AS total_students
    FROM enrollments
    GROUP BY course_id
)
SELECT *
FROM course_totals
WHERE total_students >= 5;

IMPORTANTE:
Una CTE no garantiza por sí misma una mejora
de rendimiento. Su principal ventaja es estructurar
y hacer más comprensible una consulta.
*/


/*
------------------------------------------------------------
15. INSERT, UPDATE Y DELETE
------------------------------------------------------------

Estas instrucciones permiten modificar la información
almacenada en las tablas.

INSERT:
Inserta nuevos registros.

UPDATE:
Modifica registros existentes.

DELETE:
Elimina registros.

EJEMPLO INSERT:

INSERT INTO students (first_name, last_name, email)
VALUES ('Carlos', 'Ramírez', 'carlos@example.com');

EJEMPLO UPDATE:

UPDATE students
SET last_name = 'Hernández'
WHERE id = 1;

EJEMPLO DELETE:

DELETE FROM students
WHERE id = 1;

IMPORTANTE:
UPDATE y DELETE deben utilizar condiciones WHERE
cuando se pretende modificar o eliminar registros
específicos.

Sin WHERE, UPDATE puede modificar todas las filas
y DELETE puede eliminar todos los registros de la tabla.

Antes de ejecutar operaciones destructivas,
es recomendable comprobar los registros afectados
mediante una consulta SELECT.
*/


/*
------------------------------------------------------------
16. CASE
------------------------------------------------------------

CASE:
Permite implementar condiciones dentro de una consulta
y devolver diferentes resultados dependiendo
de las condiciones evaluadas.

SINTAXIS:

CASE
    WHEN condicion THEN resultado
    WHEN condicion THEN resultado
    ELSE resultado
END

EJEMPLO:

SELECT
    id,
    CASE
        WHEN id <= 10 THEN 'Primer grupo'
        ELSE 'Segundo grupo'
    END AS grupo
FROM students;

IMPORTANTE:
CASE devuelve un valor calculado en el resultado.
No modifica los registros almacenados.
*/


/*
------------------------------------------------------------
17. UNION Y UNION ALL
------------------------------------------------------------

UNION:
Combina los resultados de dos consultas y elimina
las filas duplicadas.

UNION ALL:
Combina los resultados sin eliminar duplicados.

EJEMPLO:

SELECT first_name AS name
FROM students

UNION

SELECT name
FROM courses;

IMPORTANTE:
Las consultas deben devolver la misma cantidad
de columnas y tipos compatibles en las posiciones
correspondientes.
*/


/*
------------------------------------------------------------
18. VISTAS (CREATE VIEW)
------------------------------------------------------------

CREATE VIEW:
Permite definir una consulta almacenada como una vista.

Una vista funciona como una tabla virtual basada
en una consulta.

EJEMPLO:

CREATE VIEW student_enrollments AS
SELECT
    s.id AS student_id,
    s.first_name,
    e.course_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.id = e.student_id;

CONSULTAR LA VISTA:

SELECT *
FROM student_enrollments;

IMPORTANTE:
Una vista normal no almacena por separado
los resultados de la consulta.
Para ello existen las vistas materializadas.
*/


/*
------------------------------------------------------------
19. EXPLAIN Y EXPLAIN ANALYZE
------------------------------------------------------------

EXPLAIN:
Muestra el plan de ejecución que PostgreSQL estima
utilizar para ejecutar una consulta.

EXPLAIN ANALYZE:
Ejecuta realmente la consulta y muestra información
sobre su ejecución.

EJEMPLO:

EXPLAIN
SELECT *
FROM students
WHERE id = 1;

EJEMPLO CON ANALYZE:

EXPLAIN ANALYZE
SELECT *
FROM students
WHERE id = 1;

IMPORTANTE:
EXPLAIN ANALYZE ejecuta la consulta.
Si se utiliza con INSERT, UPDATE o DELETE,
la operación puede modificar los datos.

Para analizar operaciones de modificación,
se deben tomar precauciones y utilizar transacciones
cuando corresponda.
*/


/*
------------------------------------------------------------
20. CONSULTAS PARAMETRIZADAS
------------------------------------------------------------

Las consultas parametrizadas permiten separar
la instrucción SQL de los valores proporcionados
por la aplicación.

EJEMPLO EN POSTGRESQL:

SELECT *
FROM students
WHERE email = $1;

$1 representa el primer parámetro recibido.

En una aplicación Node.js con PostgreSQL,
el valor se proporciona por separado mediante
el cliente o controlador utilizado.

IMPORTANCIA:

- Ayudan a prevenir inyecciones SQL.
- Separan instrucciones y datos.
- Facilitan la reutilización de consultas.

IMPORTANTE:
No debemos concatenar directamente valores proporcionados
por los usuarios dentro de las instrucciones SQL.

Los parámetros representan valores, no nombres dinámicos
de tablas o columnas.
*/


/*
------------------------------------------------------------
21. TRANSACCIONES EN CONSULTAS
------------------------------------------------------------

Las transacciones permiten ejecutar varias operaciones
como una unidad lógica.

BEGIN:
Inicia una transacción.

COMMIT:
Confirma los cambios.

ROLLBACK:
Revierte los cambios.

EJEMPLO:

BEGIN;

UPDATE students
SET last_name = 'Hernández'
WHERE id = 1;

COMMIT;

IMPORTANTE:
Si una operación falla y necesitamos cancelar
los cambios realizados dentro de la transacción,
utilizamos ROLLBACK.

Las consultas SELECT también pueden ejecutarse
dentro de una transacción.
*/


/*
------------------------------------------------------------
22. CONSULTAS DE VALIDACIÓN DEL PROYECTO
------------------------------------------------------------

Esta sección debe contener consultas específicas
para comprobar que la base de datos cumple
con los requerimientos y reglas del negocio.

EJEMPLOS DE VALIDACIONES:

- Comprobar la cantidad de registros.
- Detectar valores duplicados.
- Identificar registros sin relaciones.
- Verificar estados de las operaciones.
- Comprobar fechas y rangos.
- Revisar consistencia entre tablas.

EJEMPLO:

SELECT COUNT(*)
FROM students;

EJEMPLO PARA IDENTIFICAR ESTUDIANTES SIN INSCRIPCIONES:

SELECT s.*
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.id = e.student_id
WHERE e.id IS NULL;

IMPORTANTE:
Las consultas de esta sección deben responder
a reglas y necesidades reales del proyecto.
*/


/*
------------------------------------------------------------
23. RECOMENDACIONES GENERALES
------------------------------------------------------------

- Seleccionar únicamente las columnas necesarias.
- Utilizar WHERE para limitar los registros consultados.
- Utilizar JOIN cuando sea necesario combinar información.
- Comprender la diferencia entre WHERE y HAVING.
- Utilizar alias para mejorar la legibilidad.
- Evitar consultas innecesariamente complejas.
- Utilizar parámetros en las consultas de aplicaciones.
- Analizar consultas lentas con EXPLAIN.
- Crear índices cuando exista una justificación.
- Revisar cuidadosamente UPDATE y DELETE.
- No asumir que una consulta es eficiente solamente
  porque devuelve el resultado esperado.

============================================================
FIN DEL ARCHIVO
============================================================

RESULTADO ESPERADO:

- Las consultas permiten recuperar información.
- Los filtros seleccionan los registros necesarios.
- Los JOIN relacionan correctamente las tablas.
- Las funciones de agregación resumen información.
- Las subconsultas y CTE permiten organizar operaciones.
- Las operaciones de modificación se realizan
  respetando las restricciones.
- Las consultas de validación comprueban el funcionamiento
  de la base de datos.

============================================================
FIN DE LA PLANTILLA SQL
============================================================

Con este archivo se completa la estructura inicial
de nuestra plantilla de proyectos de bases de datos.

PRÓXIMA ETAPA:
Utilizar la plantilla para desarrollar un proyecto real,
desde el análisis de requerimientos hasta la validación
de consultas SQL.
============================================================
*/