# FUNVAL — Database Project Template

## 1. Overview

This template provides a standardized structure and working methodology for analyzing, designing, implementing, documenting, and validating relational databases.

It is designed to serve as a starting point for database exercises and academic projects developed during the Full Stack training program at FUNVAL.

The methodology organizes development into two main areas:

- **Design and documentation:** problem analysis, requirements, business rules, data modeling, and architecture.
- **Implementation and validation:** database creation, schema construction, data insertion, and SQL queries.

The purpose is to work progressively, with proper documentation and reproducibility, avoiding the practice of jumping directly into table creation without first understanding the problem that needs to be solved.

## 2. Technologies and Tools

- **PostgreSQL:** relational database management system.
- **SQL:** language used to define structures, manipulate data, and perform queries.
- **DBML:** language used to represent relational models.
- **Visual Studio Code:** development environment.
- **Git:** version control system.
- **GitHub:** project hosting and collaboration platform.

## 3. Project Structure

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

## 4. Development Methodology

Development is divided into four general stages:

1. **Analysis:** understand the problem and determine what information the system needs to manage.
2. **Design:** transform the requirements into a structured data model.
3. **Implementation:** build the database using PostgreSQL and SQL.
4. **Validation:** verify data integrity and ensure that queries meet the system's needs.

### Phase 1. Requirements Analysis

**File:** `docs/00_requirements.md`

**Objective:** understand the client's idea, analyze its feasibility from a business logic perspective, and develop a clear specification of what the system must solve through a process of consultation and validation.

**Stages and activities:**

**1. Initial consultation with the client**

Obtain and document the client's original idea without making assumptions or filling in missing information independently.

- Understand the problem or need the client wants to address.
- Learn about the context in which the need arises.
- Identify the objectives the client expects to achieve.
- Understand how business activities are currently performed.
- Identify the people involved and their responsibilities.
- Record the features the client envisions for the system.
- Document the original project statement and the client's expectations.

**2. Analysis of the idea and identification of gaps**

Examine the information gathered to determine whether the proposal has sufficient coherence and detail to become a functional system.

- Analyze processes from a business logic perspective.
- Identify missing or ambiguous information.
- Detect contradictions between the stated needs.
- Identify unspecified actors, responsibilities, and permissions.
- Examine workflows and their possible exceptions.
- Identify implicit or overlooked business rules.
- Detect scenarios that could affect the system's operation.
- Formulate questions and propose alternatives to address the identified gaps.

**3. Follow-up consultation and validation with the client**

Return to the client to clarify the identified points and establish a shared understanding of how the business and the system should work.

- Present the questions, ambiguities, and contradictions identified.
- Ask specific questions about processes and their exceptions.
- Clarify the business rules required for each operation.
- Propose alternatives when different approaches could address a need.
- Agree on responsibilities, permissions, and workflows.
- Confirm which needs are included in the project scope.
- Record the answers, decisions, and agreements reached.
- Distinguish confirmed requirements from assumptions and pending issues.

**4. Consolidation of the requirements specification**

Combine the original project statement with the clarifications and agreements obtained to produce a complete and coherent description of the system.

- Define the system's purpose and scope.
- Identify actors and their responsibilities.
- Describe the expected processes and functionalities.
- Establish functional and non-functional requirements.
- Document general rules and constraints.
- Establish expected outcomes and acceptance criteria.
- Verify that the specification accurately reflects what was agreed upon with the client.

**Expected outcome:** a requirements document that represents a shared and validated understanding between the client and the development team, providing sufficient clarity about the business logic, processes, rules, and needs the system must address.

### Phase 2. Business Rules

**File:** `docs/01_business-rules.md`

**Objective:** establish the conditions that govern how the system operates.

Activities:

- Identify business constraints.
- Define the conditions for registering information.
- Establish the permitted relationships between system elements.
- Determine participation rules.
- Identify uniqueness and mandatory-field constraints.
- Define conditions that must be enforced to maintain data consistency.

**Expected outcome:** a clear set of rules that can later be translated into relationships, constraints, and validations within the database.

### Phase 3. Entities and Attributes

**File:** `docs/02_entities-and-attributes.md`

**Objective:** identify the elements of the system that need to be represented as data.

Activities:

- Identify the main entities.
- Distinguish independent and dependent entities.
- Identify the attributes of each entity.
- Define the meaning of each attribute.
- Propose primary keys.
- Identify possible candidate keys.
- Determine mandatory, optional, and unique attributes.

**Expected outcome:** an entity and attribute catalog that serves as the foundation for building the entity-relationship model.

### Phase 4. Entity-Relationship Model

**Files:**

- `docs/03_diagram-er.md`
- `docs/07_diagram-er.png`

**Objective:** graphically represent the conceptual structure of the data and its relationships.

Activities:

- Establish relationships between entities.
- Define cardinalities: one-to-one, one-to-many, and many-to-many.
- Identify associative entities when necessary.
- Determine mandatory or optional participation.
- Document relationships and their justifications.
- Build the entity-relationship diagram.
- Review whether the diagram accurately represents the business rules.

**Expected outcome:** a conceptual model consistent with the requirements and business rules.

### Phase 5. Relational Model

**File:** `docs/04_relation-model.dbml`

**Objective:** transform the conceptual model into a relational structure.

Activities:

- Convert entities into tables.
- Define columns.
- Assign data types.
- Establish primary keys (PK).
- Establish foreign keys (FK).
- Resolve many-to-many relationships using associative tables.
- Define integrity constraints.
- Represent the model using DBML.
- Generate a visualization of the schema.

**Expected outcome:** a relational model describing the database tables, columns, keys, and relationships.

### Phase 6. Normalization

**File:** `docs/05_normalization.md`

**Objective:** evaluate the table structure to reduce redundancy and prevent anomalies during data operations.

Activities:

- Identify functional dependencies.
- Review First Normal Form (1NF).
- Review Second Normal Form (2NF).
- Review Third Normal Form (3NF).
- Identify possible redundancies.
- Evaluate insertion, update, and deletion anomalies.
- Document normalization decisions.

**Expected outcome:** a consistent relational structure justified from a normalization perspective.

### Phase 7. Database Architecture

**File:** `docs/06_architecture.md`

**Objective:** document the overall organization of the solution and its design decisions.

Activities:

- Describe the database organization.
- Explain how its components relate to one another.
- Document architectural decisions.
- Describe the responsibilities of the main entities.
- Explain how the model addresses the requirements.
- Identify relevant aspects for maintenance and future evolution.

**Expected outcome:** a technical and structural description of the designed solution.

## 5. Database Implementation

Once the analysis and design stages are complete, implementation begins using PostgreSQL.

### Phase 8. Database Creation

**File:** `database/00_create_db.sql`

**Objective:** create the database that will host the relational schema.

Activities:

- Define the database name.
- Configure the parameters required for its creation.
- Execute the script using an administrative connection.
- Verify that the database exists.

**Expected outcome:** a database successfully created and ready to receive its tables.

### Phase 9. Schema Implementation

**File:** `database/01_schema.sql`

**Objective:** physically build the tables and relationships defined in the relational model.

Activities:

- Create the tables.
- Define columns and data types.
- Establish primary keys.
- Establish foreign keys.
- Apply `NOT NULL`, `UNIQUE`, and `CHECK` constraints when appropriate.
- Define referential actions when necessary.
- Create indexes when justified.
- Verify the structural integrity of the schema.

**Expected outcome:** a database with all its tables, relationships, and constraints correctly implemented.

### Phase 10. Test Data Insertion

**File:** `database/02_seed.sql`

**Objective:** populate the database with information that allows its functionality to be tested.

Activities:

- Prepare representative records.
- Respect the insertion order according to table dependencies.
- Insert records required by foreign keys first.
- Check integrity constraints.
- Verify that records have been inserted correctly.
- Ensure that the data is consistent with the business rules.

**Expected outcome:** a database populated with correctly related test records.

### Phase 11. Queries and Validation

**File:** `database/03_queries.sql`

**Objective:** query and analyze the stored information, verifying that the database meets the system's needs.

Activities:

- Create `SELECT` queries.
- Apply filters using `WHERE`.
- Sort results using `ORDER BY`.
- Combine tables using `JOIN`.
- Use aggregate functions.
- Group information using `GROUP BY`.
- Apply conditions to grouped results using `HAVING`.
- Retrieve related information across different entities.
- Validate scenarios defined during requirements analysis.

**Expected outcome:** an organized set of SQL queries demonstrating that information can be retrieved and analyzed correctly.

## 6. SQL Script Execution Order

SQL scripts must be executed in the following order:

| Order | File | Purpose |
|---|---|---|
| 1 | `00_create_db.sql` | Create the database. |
| 2 | `01_schema.sql` | Create tables, relationships, and constraints. |
| 3 | `02_seed.sql` | Insert test data. |
| 4 | `03_queries.sql` | Query and validate the information. |

**Important:** the first script must be executed from an administrative connection. The remaining scripts must be executed after connecting to the newly created database.

The test data script should not be executed repeatedly on a database that already contains the same records without first reviewing the potential effects.

## 7. Project Validation

Before considering the exercise complete, verify that:

- [ ] Requirements are documented.
- [ ] Business rules are defined.
- [ ] Entities and attributes are identified.
- [ ] The entity-relationship model represents the system.
- [ ] The relational model matches the conceptual design.
- [ ] Normalization is documented.
- [ ] The architecture is explained.
- [ ] The database is created successfully.
- [ ] All tables and constraints work correctly.
- [ ] Test data respects the defined relationships.
- [ ] SQL queries produce the expected results.
- [ ] Documentation is up to date.

## 8. Version Control

Use Git to track the evolution of the project.

Basic workflow:

```bash
git status
git add .
git commit -m "type: describe the changes"
git push
```

Commit message examples:

- `docs: add database requirements`
- `feat: implement database schema`
- `feat: add seed data`
- `test: validate database queries`
- `docs: update ER diagram`

Do not include credentials, `.env` files, or sensitive information in the repository.

## 9. Working Principles

- Understand the problem before creating tables.
- Justify design decisions.
- Maintain consistency between requirements, business rules, and the data model.
- Document every stage of the process.
- Implement the schema based on the relational model.
- Validate relationships and constraints using test data.
- Keep scripts organized and reproducible.
- Use version control from the beginning of the project.

## 10. Author

**Gustavo Andrés Santoyo Benavides**

FUNVAL — Full Stack Development

Database Design and Implementation Practice.