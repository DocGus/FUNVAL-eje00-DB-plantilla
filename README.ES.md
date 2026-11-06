# FUNVAL — Plantilla de Proyecto de Base de Datos

## 1. Descripción

Esta plantilla proporciona una estructura estandarizada y una metodología de trabajo para analizar, diseñar, implementar, documentar y validar bases de datos relacionales.

Está diseñada para utilizarse como punto de partida en los ejercicios y proyectos académicos de bases de datos desarrollados durante la formación Full Stack en FUNVAL.

La metodología organiza el desarrollo en dos grandes áreas:

- **Diseño y documentación:** análisis del problema, requerimientos, reglas de negocio, modelado y arquitectura.
- **Implementación y validación:** creación de la base de datos, construcción del esquema, inserción de datos y consultas SQL.

El propósito es trabajar de manera progresiva, documentada y reproducible, evitando comenzar directamente con la creación de tablas sin comprender primero el problema que se desea resolver.

## 2. Tecnologías y herramientas

- **PostgreSQL:** sistema gestor de bases de datos relacionales.
- **SQL:** lenguaje para definir estructuras, manipular datos y realizar consultas.
- **DBML:** lenguaje para representar modelos relacionales.
- **Visual Studio Code:** entorno de desarrollo.
- **Git:** sistema de control de versiones.
- **GitHub:** alojamiento y colaboración de proyectos.

## 3. Estructura del proyecto

```text
database-project/
│
├── database/
│   ├── 00_create_db.sql
│   ├── 01_schema.sql
│   ├── 02_seed.sql
│   └── 03_queries.sql
│
├── docs/
│   ├── 00_requirements.md
│   ├── 01_business-rules.md
│   ├── 02_entities-and-attributes.md
│   ├── 03_diagram-er.md
│   ├── 04_relation-model.dbml
│   ├── 05_normalization.md
│   ├── 06_architecture.md
│   └── 07_diagram-er.png
│
├── .gitignore
├── README.ES.md
└── README.EN.md
```

## 4. Metodología de desarrollo

El desarrollo se divide en cuatro etapas generales:

1. Análisis: comprender el problema y determinar qué información necesita administrar el sistema.
2. Diseño: transformar los requerimientos en un modelo de datos estructurado.
3. Implementación: construir la base de datos utilizando PostgreSQL y SQL.
4. Validación: comprobar la integridad de los datos y verificar que las consultas respondan a las necesidades del sistema.

### Fase 1. Análisis de requerimientos

Archivo: docs/00_requirements.md

Objetivo: comprender la idea del cliente, analizar su viabilidad desde la lógica del negocio y construir, mediante un proceso de consulta y validación, una especificación clara de lo que el sistema debe resolver.

Etapas y actividades:

1. Consulta inicial con el cliente

Obtener y documentar la idea original del cliente sin asumir ni completar información por cuenta propia.

Comprender el problema o necesidad que desea resolver.

Conocer el contexto en el que surge la necesidad.

Identificar los objetivos que espera alcanzar.

Conocer cómo se realizan actualmente las actividades del negocio.

Identificar a las personas involucradas y sus responsabilidades.

Registrar las funcionalidades que imagina para el sistema.

Documentar el enunciado original y las expectativas del cliente.

2. Análisis de la idea y detección de vacíos

Examinar la información obtenida para determinar si la propuesta tiene suficiente coherencia y detalle para convertirse en un sistema funcional.

Analizar los procesos desde la lógica del negocio.

Identificar información faltante o ambigua.

Detectar contradicciones entre las necesidades planteadas.

Identificar actores, responsabilidades y permisos no especificados.

Examinar los flujos de trabajo y sus posibles excepciones.

Identificar reglas de negocio implícitas o no contempladas.

Detectar escenarios que podrían afectar el funcionamiento del sistema.

Formular preguntas y proponer alternativas para resolver los vacíos identificados.

3. Consulta complementaria y validación con el cliente

Regresar con el cliente para aclarar los puntos detectados y construir una definición compartida de cómo debe funcionar el negocio y el sistema.

Presentar las dudas, ambigüedades y contradicciones encontradas.

Plantear preguntas específicas sobre los procesos y sus excepciones.

Consultar las reglas de negocio necesarias para cada operación.

Proponer alternativas cuando existan diferentes formas de resolver una necesidad.

Acordar responsabilidades, permisos y flujos de trabajo.

Confirmar qué necesidades forman parte del alcance del proyecto.

Registrar las respuestas, decisiones y acuerdos alcanzados.

Diferenciar los requerimientos confirmados de las suposiciones y cuestiones pendientes.

4. Consolidación de la especificación de requerimientos

Integrar el enunciado original con las aclaraciones y acuerdos obtenidos para producir una descripción completa y coherente del sistema.

Definir el propósito y alcance del sistema.

Identificar actores y sus responsabilidades.

Describir los procesos y funcionalidades esperadas.

Establecer los requerimientos funcionales y no funcionales.

Documentar las reglas y restricciones generales.

Establecer los resultados esperados y criterios de aceptación.

Verificar que la especificación represente lo acordado con el cliente.

Resultado esperado: un documento de requerimientos que represente una visión compartida y validada entre el cliente y el equipo de desarrollo, con suficiente claridad sobre la lógica del negocio, los procesos, las reglas y las necesidades que deberá resolver el sistema.

### Fase 2. Reglas de negocio

**Archivo:** `docs/01_business-rules.md`

**Objetivo:** establecer las condiciones que regulan el funcionamiento del sistema.

Actividades:

- Identificar las restricciones del negocio.
- Definir las condiciones para registrar información.
- Establecer las relaciones permitidas entre los elementos del sistema.
- Determinar las reglas de participación.
- Identificar restricciones de unicidad y obligatoriedad.
- Definir condiciones que deben respetarse para mantener la consistencia de los datos.

**Resultado esperado:** un conjunto de reglas claras que posteriormente puedan traducirse en relaciones, restricciones y validaciones dentro de la base de datos.

### Fase 3. Entidades y atributos

**Archivo:** `docs/02_entities-and-attributes.md`

**Objetivo:** identificar los elementos del sistema que necesitan representarse mediante datos.

Actividades:

- Identificar las entidades principales.
- Diferenciar entidades independientes y dependientes.
- Identificar los atributos de cada entidad.
- Definir el significado de cada atributo.
- Proponer claves primarias.
- Identificar posibles claves candidatas.
- Determinar atributos obligatorios, opcionales y únicos.

**Resultado esperado:** un catálogo de entidades y atributos que sirva como base para construir el modelo entidad-relación.

### Fase 4. Modelo entidad-relación

**Archivos:**
- `docs/03_diagram-er.md`
- `docs/07_diagram-er.png`

**Objetivo:** representar gráficamente la estructura conceptual de los datos y sus relaciones.

Actividades:

- Establecer las relaciones entre entidades.
- Definir las cardinalidades: uno a uno, uno a muchos y muchos a muchos.
- Identificar entidades asociativas cuando sean necesarias.
- Determinar la participación obligatoria u opcional.
- Documentar las relaciones y sus justificaciones.
- Construir el diagrama entidad-relación.
- Revisar que el diagrama represente las reglas de negocio.

**Resultado esperado:** un modelo conceptual coherente con los requerimientos y las reglas de negocio.

### Fase 5. Modelo relacional

**Archivo:** `docs/04_relation-model.dbml`

**Objetivo:** transformar el modelo conceptual en una estructura relacional.

Actividades:

- Convertir las entidades en tablas.
- Definir las columnas.
- Asignar tipos de datos.
- Establecer claves primarias (PK).
- Establecer claves foráneas (FK).
- Resolver relaciones muchos a muchos mediante tablas asociativas.
- Definir restricciones de integridad.
- Representar el modelo mediante DBML.
- Generar una visualización del esquema.

**Resultado esperado:** un modelo relacional que describa las tablas, columnas, claves y relaciones de la base de datos.

### Fase 6. Normalización

**Archivo:** `docs/05_normalization.md`

**Objetivo:** evaluar la estructura de las tablas para reducir redundancias y prevenir anomalías en las operaciones de datos.

Actividades:

- Identificar dependencias funcionales.
- Revisar la Primera Forma Normal (1FN).
- Revisar la Segunda Forma Normal (2FN).
- Revisar la Tercera Forma Normal (3FN).
- Identificar posibles redundancias.
- Evaluar anomalías de inserción, actualización y eliminación.
- Documentar las decisiones de normalización.

**Resultado esperado:** una estructura relacional consistente y justificada desde el punto de vista de la normalización.

### Fase 7. Arquitectura de la base de datos

**Archivo:** `docs/06_architecture.md`

**Objetivo:** documentar la organización general de la solución y las decisiones de diseño.

Actividades:

- Describir la organización de la base de datos.
- Explicar cómo se relacionan sus componentes.
- Documentar las decisiones arquitectónicas.
- Describir las responsabilidades de las entidades principales.
- Explicar cómo el modelo responde a los requerimientos.
- Identificar aspectos relevantes para su mantenimiento y evolución.

**Resultado esperado:** una descripción técnica y estructural de la solución diseñada.

## 5. Implementación de la base de datos

Una vez finalizado el análisis y el diseño, comienza la implementación utilizando PostgreSQL.

### Fase 8. Creación de la base de datos

**Archivo:** `database/00_create_db.sql`

**Objetivo:** crear la base de datos que alojará el esquema relacional.

Actividades:

- Definir el nombre de la base de datos.
- Configurar los parámetros necesarios para su creación.
- Ejecutar el script desde una conexión administrativa.
- Verificar que la base de datos exista.

**Resultado esperado:** una base de datos creada y disponible para recibir las tablas.

### Fase 9. Implementación del esquema

**Archivo:** `database/01_schema.sql`

**Objetivo:** construir físicamente las tablas y relaciones definidas en el modelo relacional.

Actividades:

- Crear las tablas.
- Definir columnas y tipos de datos.
- Establecer claves primarias.
- Establecer claves foráneas.
- Aplicar restricciones `NOT NULL`, `UNIQUE` y `CHECK` cuando correspondan.
- Definir acciones referenciales cuando sean necesarias.
- Crear índices cuando estén justificados.
- Verificar la integridad estructural del esquema.

**Resultado esperado:** una base de datos con todas sus tablas, relaciones y restricciones correctamente implementadas.

### Fase 10. Inserción de datos de prueba

**Archivo:** `database/02_seed.sql`

**Objetivo:** poblar la base de datos con información que permita comprobar su funcionamiento.

Actividades:

- Preparar registros representativos.
- Respetar el orden de inserción según las dependencias entre tablas.
- Insertar primero los registros requeridos por las claves foráneas.
- Comprobar las restricciones de integridad.
- Verificar que los registros se hayan insertado correctamente.
- Revisar que los datos sean coherentes con las reglas de negocio.

**Resultado esperado:** una base de datos poblada con registros de prueba relacionados correctamente.

### Fase 11. Consultas y validación

**Archivo:** `database/03_queries.sql`

**Objetivo:** consultar y analizar la información almacenada, comprobando que la base de datos responda a las necesidades del sistema.

Actividades:

- Crear consultas `SELECT`.
- Aplicar filtros con `WHERE`.
- Ordenar resultados con `ORDER BY`.
- Combinar tablas mediante `JOIN`.
- Utilizar funciones de agregación.
- Agrupar información con `GROUP BY`.
- Aplicar condiciones sobre agrupaciones con `HAVING`.
- Consultar información relacionada entre distintas entidades.
- Validar escenarios definidos durante el análisis de requerimientos.

**Resultado esperado:** un conjunto organizado de consultas SQL que demuestre que la información puede recuperarse y analizarse correctamente.

## 6. Orden de ejecución de los scripts

Los scripts SQL deben ejecutarse en el siguiente orden:

| Orden | Archivo | Función |
|---|---|---|
| 1 | `00_create_db.sql` | Crear la base de datos. |
| 2 | `01_schema.sql` | Crear tablas, relaciones y restricciones. |
| 3 | `02_seed.sql` | Insertar datos de prueba. |
| 4 | `03_queries.sql` | Consultar y validar la información. |

**Importante:** el primer script se ejecuta desde una conexión administrativa. Los siguientes se ejecutan después de conectarse a la base de datos creada.

El script de datos de prueba no debe ejecutarse repetidamente sobre una base que ya contiene los mismos registros sin revisar previamente sus efectos.

## 7. Validación del proyecto

Antes de considerar terminado el ejercicio, verificar:

- [ ] Los requerimientos están documentados.
- [ ] Las reglas de negocio están definidas.
- [ ] Las entidades y atributos están identificados.
- [ ] El modelo entidad-relación representa el sistema.
- [ ] El modelo relacional coincide con el diseño conceptual.
- [ ] La normalización está documentada.
- [ ] La arquitectura está explicada.
- [ ] La base de datos se crea correctamente.
- [ ] Todas las tablas y restricciones funcionan.
- [ ] Los datos de prueba respetan las relaciones.
- [ ] Las consultas SQL producen resultados esperados.
- [ ] La documentación está actualizada.

## 8. Control de versiones

Utilizar Git para registrar la evolución del proyecto.

Flujo básico de trabajo:

```bash
git status
git add .
git commit -m "type: describe the changes"
git push
```

Ejemplos de mensajes:

- `docs: add database requirements`
- `feat: implement database schema`
- `feat: add seed data`
- `test: validate database queries`
- `docs: update ER diagram`

No incluir credenciales, archivos `.env` ni información sensible en el repositorio.

## 9. Principios de trabajo

- Comprender el problema antes de crear tablas.
- Justificar las decisiones de diseño.
- Mantener coherencia entre requerimientos, reglas de negocio y modelo de datos.
- Documentar cada etapa del proceso.
- Implementar el esquema a partir del modelo relacional.
- Validar las relaciones y restricciones con datos de prueba.
- Mantener los scripts organizados y reproducibles.
- Utilizar control de versiones desde el inicio del proyecto.

## 10. Autor

**Gustavo Andrés Santoyo Benavides**

FUNVAL — Full Stack Development

Database Design and Implementation Practice.