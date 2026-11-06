# 03_queries.sql — Consultas SQL

```sql
/*
============================================================
ARCHIVO: 03_queries.sql

FUNCIÓN:
Documentar consultas para recuperar, filtrar, relacionar,
agrupar, analizar y modificar información.

IMPORTANCIA:
Permite utilizar la información almacenada según
las necesidades del sistema.

CONSULTAS PRINCIPALES:
- Recuperar y filtrar registros.
- Ordenar y paginar resultados.
- Relacionar tablas.
- Agrupar y resumir información.
- Utilizar subconsultas y CTE.
- Insertar, actualizar y eliminar registros.
- Analizar el rendimiento.

ORDEN DE EJECUCIÓN:
1. 00_create_db.sql
2. 01_schema.sql
3. 02_seed.sql
4. 03_queries.sql

Los ejemplos utilizan las tablas:
students, courses y enrollments.

Adaptar las consultas a la estructura real del proyecto.
============================================================
*/

/*
------------------------------------------------------------
1. SELECT
------------------------------------------------------------

Recupera información de una o varias columnas.

SINTAXIS:
SELECT columna1, columna2
FROM nombre_tabla;

SELECT * FROM students;

El asterisco (*) devuelve todas las columnas.

RECOMENDACIÓN:
Seleccionar únicamente las columnas necesarias para
evitar recuperar información innecesaria.
*/

/*
------------------------------------------------------------
2. WHERE
------------------------------------------------------------

Filtra registros mediante condiciones.

OPERADORES:
=  Igual       <> o !=  Diferente
>  Mayor       <        Menor
>= Mayor o igual
<= Menor o igual

OPERADORES LÓGICOS:
AND: todas las condiciones deben cumplirse.
OR: al menos una condición debe cumplirse.
NOT: niega una condición.

EJEMPLO:
*/
SELECT *
FROM students
WHERE first_name = 'Ana'
AND last_name = 'García';

/*
WHERE filtra registros antes de realizar agrupaciones.
*/

/*
------------------------------------------------------------
3. ORDER BY
------------------------------------------------------------

Ordena los resultados.

ASC: ascendente (predeterminado).
DESC: descendente.

EJEMPLOS:
*/
SELECT *
FROM students
ORDER BY first_name ASC;

SELECT *
FROM students
ORDER BY id DESC;

SELECT *
FROM students
ORDER BY last_name ASC, first_name ASC;

/*
Utilizar un orden explícito cuando se necesiten
resultados predecibles.
*/

/*
------------------------------------------------------------
4. LIMIT Y OFFSET
------------------------------------------------------------

LIMIT:
Establece el máximo de registros devueltos.

OFFSET:
Indica cuántos registros omitir.

EJEMPLO:
*/
SELECT *
FROM students
ORDER BY id
LIMIT 10 OFFSET 20;

/*
PAGINACIÓN:
OFFSET = (pagina - 1) * tamaño_pagina

Utilizar ORDER BY para resultados consistentes.
En grandes volúmenes puede evaluarse keyset pagination.
*/

/*
------------------------------------------------------------
5. DISTINCT
------------------------------------------------------------

Elimina duplicados del resultado, sin modificar
los registros almacenados.

EJEMPLO:
*/
SELECT DISTINCT last_name
FROM students;

SELECT DISTINCT first_name, last_name
FROM students;

/*
------------------------------------------------------------
6. OPERADORES DE BÚSQUEDA
------------------------------------------------------------

IN: comprueba si un valor pertenece a una lista.
BETWEEN: comprueba si está dentro de un intervalo.
LIKE: busca patrones de texto.
ILIKE: busca patrones sin distinguir mayúsculas
       y minúsculas en PostgreSQL.
IS NULL: comprueba ausencia de valor.
IS NOT NULL: comprueba presencia de valor.

EJEMPLOS:
*/
SELECT * FROM students WHERE id IN (1, 2, 3);
SELECT * FROM students WHERE id BETWEEN 1 AND 10;
SELECT * FROM students WHERE first_name LIKE 'A%';
SELECT * FROM students WHERE first_name ILIKE 'a%';
SELECT * FROM students WHERE email IS NOT NULL;

/*
COMODINES:
%: cualquier cantidad de caracteres.
_: exactamente un carácter.

IMPORTANTE:
NULL se comprueba con IS NULL o IS NOT NULL,
no utilizando = o <>.
*/

/*
------------------------------------------------------------
7. FUNCIONES DE TEXTO Y FECHA
------------------------------------------------------------

TEXTO:
UPPER(): convierte a mayúsculas.
LOWER(): convierte a minúsculas.
LENGTH(): devuelve la longitud.
TRIM(): elimina espacios al inicio y al final.
CONCAT(): concatena cadenas.

EJEMPLOS:
*/
SELECT UPPER(first_name) FROM students;
SELECT LENGTH(first_name) FROM students;
SELECT CONCAT(first_name, ' ', last_name) FROM students;

/*
FECHA:
CURRENT_DATE: fecha actual.
CURRENT_TIMESTAMP: fecha y hora actuales.
EXTRACT(): extrae una parte de una fecha.

EJEMPLO:
*/
SELECT EXTRACT(YEAR FROM CURRENT_DATE);

/*
------------------------------------------------------------
8. JOIN
------------------------------------------------------------

Combina información de varias tablas mediante relaciones.

TIPOS:
- INNER JOIN: devuelve coincidencias de ambas tablas.
- LEFT JOIN: todos los registros de la izquierda
  y las coincidencias de la derecha.
- RIGHT JOIN: todos los registros de la derecha
  y las coincidencias de la izquierda.
- FULL OUTER JOIN: todos los registros de ambas tablas.
- CROSS JOIN: todas las combinaciones posibles.

EJEMPLOS:
*/
SELECT s.first_name, e.enrolled_at
FROM students AS s
INNER JOIN enrollments AS e
    ON s.id = e.student_id;

SELECT s.first_name, e.course_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.id = e.student_id;

/*
ON define la condición que relaciona los registros.
*/

/*
------------------------------------------------------------
9. ALIAS
------------------------------------------------------------

AS:
Asigna nombres temporales a columnas o tablas.

ALIAS DE COLUMNA:
*/
SELECT
    first_name AS nombre,
    last_name AS apellido
FROM students;

/*
ALIAS DE TABLA:
*/
SELECT s.first_name, e.course_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.id = e.student_id;

/*
Facilitan la lectura, especialmente en consultas
con varias tablas.
*/

/*
------------------------------------------------------------
10. FUNCIONES DE AGREGACIÓN
------------------------------------------------------------

COUNT(): cuenta registros o valores no NULL.
SUM(): suma valores numéricos.
AVG(): calcula el promedio.
MIN(): devuelve el mínimo.
MAX(): devuelve el máximo.

EJEMPLOS:
*/
SELECT COUNT(*) FROM students;
SELECT MIN(id), MAX(id) FROM students;

/*
COUNT(*) cuenta todas las filas.
COUNT(columna) cuenta los valores no NULL.
*/

/*
------------------------------------------------------------
11. GROUP BY
------------------------------------------------------------

Agrupa registros que comparten valores en columnas.
Se utiliza frecuentemente con funciones de agregación.

EJEMPLO:
*/
SELECT
    course_id,
    COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id;

/*
Las columnas del SELECT deben cumplir las reglas
de agrupación de PostgreSQL.
*/

/*
------------------------------------------------------------
12. HAVING
------------------------------------------------------------

Filtra grupos después de aplicar GROUP BY.

DIFERENCIA:
WHERE: filtra registros antes de agrupar.
HAVING: filtra grupos después de agrupar.

EJEMPLO:
*/
SELECT course_id, COUNT(*) AS total_students
FROM enrollments
GROUP BY course_id
HAVING COUNT(*) >= 5;

/*
------------------------------------------------------------
13. SUBCONSULTAS
------------------------------------------------------------

Consulta SQL incluida dentro de otra consulta.

Puede utilizarse en SELECT, FROM, WHERE y HAVING.

EJEMPLO:
*/
SELECT *
FROM students
WHERE id IN (
    SELECT student_id
    FROM enrollments
);

/*
Devuelve estudiantes que tienen al menos una inscripción.

Puede ser independiente o correlacionada con la consulta
externa.
*/

/*
------------------------------------------------------------
14. CTE (COMMON TABLE EXPRESSION)
------------------------------------------------------------

WITH:
Define una expresión de tabla común que puede utilizarse
dentro de una consulta.

VENTAJAS:
- Organiza consultas complejas.
- Separa pasos lógicos.
- Mejora la legibilidad y el mantenimiento.

EJEMPLO:
*/
WITH course_totals AS (
    SELECT course_id, COUNT(*) AS total_students
    FROM enrollments
    GROUP BY course_id
)
SELECT *
FROM course_totals
WHERE total_students >= 5;

/*
Una CTE no garantiza mayor rendimiento.
Su principal ventaja es organizar la consulta.
*/

/*
------------------------------------------------------------
15. INSERT, UPDATE Y DELETE
------------------------------------------------------------

INSERT: inserta registros.
UPDATE: modifica registros.
DELETE: elimina registros.

EJEMPLOS:
*/
INSERT INTO students (first_name, last_name, email)
VALUES ('Carlos', 'Ramírez', 'carlos@example.com');

UPDATE students
SET last_name = 'Hernández'
WHERE id = 1;

DELETE FROM students
WHERE id = 1;

/*
IMPORTANTE:
UPDATE y DELETE sin WHERE pueden afectar todas las filas.
Antes de operaciones destructivas, comprobar los registros
mediante SELECT.
*/

/*
------------------------------------------------------------
16. CASE
------------------------------------------------------------

Permite devolver diferentes valores según condiciones.

SINTAXIS:
CASE
    WHEN condicion THEN resultado
    ELSE resultado
END

EJEMPLO:
*/
SELECT
    id,
    CASE
        WHEN id <= 10 THEN 'Primer grupo'
        ELSE 'Segundo grupo'
    END AS grupo
FROM students;

/*
CASE calcula un valor para el resultado;
no modifica los registros almacenados.
*/

/*
------------------------------------------------------------
17. UNION Y UNION ALL
------------------------------------------------------------

UNION:
Combina resultados y elimina duplicados.

UNION ALL:
Combina resultados sin eliminar duplicados.

EJEMPLO:
*/
SELECT first_name AS name FROM students
UNION
SELECT name FROM courses;

/*
Las consultas deben devolver la misma cantidad
de columnas y tipos compatibles en posiciones
correspondientes.
*/

/*
------------------------------------------------------------
18. VISTAS (CREATE VIEW)
------------------------------------------------------------

CREATE VIEW:
Define una consulta almacenada como una vista virtual.

EJEMPLO:
*/
CREATE VIEW student_enrollments AS
SELECT
    s.id AS student_id,
    s.first_name,
    e.course_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.id = e.student_id;

/*
CONSULTAR:
*/
SELECT * FROM student_enrollments;

/*
Una vista normal no almacena los resultados por separado.
Para ello existen las vistas materializadas.
*/

/*
------------------------------------------------------------
19. EXPLAIN Y EXPLAIN ANALYZE
------------------------------------------------------------

EXPLAIN:
Muestra el plan de ejecución estimado por PostgreSQL.

EXPLAIN ANALYZE:
Ejecuta la consulta y muestra información real
de su ejecución.

EJEMPLOS:
*/
EXPLAIN
SELECT * FROM students WHERE id = 1;

EXPLAIN ANALYZE
SELECT * FROM students WHERE id = 1;

/*
IMPORTANTE:
EXPLAIN ANALYZE ejecuta realmente la consulta.
Con INSERT, UPDATE o DELETE puede modificar datos.
Tomar precauciones y utilizar transacciones cuando
corresponda.
*/

/*
------------------------------------------------------------
20. CONSULTAS PARAMETRIZADAS
------------------------------------------------------------

Separan la instrucción SQL de los valores proporcionados
por la aplicación.

EJEMPLO EN POSTGRESQL:
*/
SELECT *
FROM students
WHERE email = $1;

/*
$1 representa el primer parámetro recibido.

IMPORTANCIA:
- Ayudan a prevenir inyecciones SQL.
- Separan instrucciones y datos.
- Facilitan la reutilización.

En Node.js, el valor se proporciona por separado
mediante el cliente PostgreSQL.

IMPORTANTE:
No concatenar directamente valores del usuario.
Los parámetros representan valores, no nombres
dinámicos de tablas o columnas.
*/

/*
------------------------------------------------------------
21. TRANSACCIONES EN CONSULTAS
------------------------------------------------------------

BEGIN: inicia una transacción.
COMMIT: confirma los cambios.
ROLLBACK: revierte los cambios.

EJEMPLO:
*/
BEGIN;

UPDATE students
SET last_name = 'Hernández'
WHERE id = 1;

COMMIT;

/*
Si necesitamos cancelar los cambios, utilizamos ROLLBACK.
También podemos ejecutar consultas SELECT dentro
de una transacción.
*/

/*
------------------------------------------------------------
22. CONSULTAS DE VALIDACIÓN
------------------------------------------------------------

Contienen consultas específicas para comprobar
los requerimientos y reglas del negocio.

VALIDACIONES:
- Cantidad de registros.
- Valores duplicados.
- Registros sin relaciones.
- Estados de operaciones.
- Fechas y rangos.
- Consistencia entre tablas.

EJEMPLO:
*/
SELECT COUNT(*) FROM students;

/*
ESTUDIANTES SIN INSCRIPCIONES:
*/
SELECT s.*
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.id = e.student_id
WHERE e.id IS NULL;

/*
Las validaciones deben responder a necesidades reales
del proyecto.
*/

/*
------------------------------------------------------------
23. RECOMENDACIONES GENERALES
------------------------------------------------------------

- Seleccionar únicamente las columnas necesarias.
- Utilizar WHERE para limitar registros.
- Utilizar JOIN para combinar información.
- Diferenciar WHERE de HAVING.
- Utilizar alias para mejorar la legibilidad.
- Evitar consultas innecesariamente complejas.
- Utilizar parámetros en aplicaciones.
- Analizar consultas lentas con EXPLAIN.
- Crear índices con justificación.
- Revisar cuidadosamente UPDATE y DELETE.
- No asumir que una consulta es eficiente solo
  porque devuelve el resultado esperado.

============================================================
RESULTADO ESPERADO:
- Consultas que recuperan y filtran información.
- JOIN que relacionan correctamente las tablas.
- Agregaciones que resumen información.
- Subconsultas y CTE que organizan operaciones.
- Modificaciones que respetan las restricciones.
- Consultas que validan el funcionamiento de la base.

FIN DE LA PLANTILLA SQL.

PRÓXIMA ETAPA:
Utilizar la plantilla en un proyecto real, desde
el análisis de requerimientos hasta la validación
de las consultas SQL.
============================================================
*/
```
