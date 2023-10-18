# oracle-postgres-migration

## Documentation of the current state

I. Introduction
- Purpose of this document
- Scope of the migration

II. Database Schema
- Tables (list of tables, incl. columns, their relationships and purpose within the application)
- Indexes (might be different across different environments)
- Custom Data Types

III. Stored Procedures and Functions
- List and Descriptions (name, purpose, and any special considerations e.g., called by a certain application function)
- Parameters and Return Types (expected parameters and the return types for each procedure and function)
- Code Snippets (optionally, include snippets or complete code for complex procedures)

IV. Triggers (automatically executed procedures, 2 types: row-level and statement-level)
- List and Descriptions
- Trigger Events
- Code Snippets

V. Views
- List Name and Purpose
- View Definitions (SQL statement that defines the view)

VI. ER Diagrams
- Can be generated automatically with Oracle SQL Developer and exported to image

VII. Data Flow Diagrams
- (Optional) How data moves through the system

VIII. Sample Queries
- Any complex queries that are important for the application

IX. Change Log

## Planning

1. Impact Analysis: Based on the documentation evaluate the scope and complexity of the migration. Identify the parts of your application that will be affected.

2. Dependency Analysis: Identify all dependent systems, services, and applications that interact with the Oracle database.

    Q: Are there any other systems besides NCAP to use the db?

3. Resource Allocation: Ensure the necessary hardware and software resources for migration, including backup systems.

    Q: More information on the current environments needed.

    Q: Will the new db system be installed on a separate machine or next to the current system on the existing one?

4. Backup Plan: A rollback plan to restore the original state in case of failure.

    Q: Will backups be needed?

    A: Potentially no as the existing db system should not be affected during the process.

5. Timeline: Detailed migration timeline with milestones.

## Preparation

1. Test Environment: Should mimick the production environment as closely as possible.

2. Install PostgreSQL: Install the PostgreSQL server and any other needed components.

## Execution

1. Schema Extraction: Generate the schema creation script from Oracle and adapt it for PostgreSQL. This might include data type changes, syntax differences, etc. This has to be done before loading the data to the new database.

    Q: What tools can be used to help with this?

    A: Some of the open-source tools to consider are:

    ** Ora2Pg: One of the most popular tools for migrating from Oracle to PostgreSQL, Ora2Pg can handle a wide variety of objects and data types and can be customized to fit specific needs.

    ** pgloader: While not solely designed for Oracle to PostgreSQL migrations, pgloader is a powerful ETL tool that can also perform schema migrations.
    
    ** Foreign Data Wrappers (FDW): PostgreSQL's Foreign Data Wrappers can be used to create foreign tables in PostgreSQL that map to tables in Oracle. This can be a useful step in a migration process.

    Q: As an alternative, what can be done manually and how?

    A: Oracle schema can be exported to SQL scripts then the scripts manually converted to be compatible with PostgreSQL. This method is labor-intensive but allows for full control over the migration process.

    Q: What are some other important considerations?

    A:

    ** Data Types: Oracle and PostgreSQL have different native data types. Tools like Ora2Pg can automatically map Oracle data types to corresponding PostgreSQL data types, but manual adjustments may be needed.

    ** Indexes and Constraints: While primary keys and simple indexes can usually be migrated automatically, more complex constraints might need to be manually migrated.

    ** Sequences and Auto-increment: Oracle uses sequences, while PostgreSQL has both sequences and an auto-incrementing SERIAL type.

    ** Character Sets: Ensure that the character sets used in both databases are compatible or convert as necessary.

2. Data Extraction: Decide on the data migration tools or methods. Common options include SQL scripts, ETL (Extract, Transform, Load) tools, or a combination. This has to be done before loading the data to the new database.

3. Recreate extracted schemas on the new system.

4. Import extracted data to the new system.

5. Code Adaptation: Any changes within database related code in the application codebase.

    Q: What needs to be done here?

    A:

    ** Update the Java codebase to use the PostgreSQL JDBC driver instead of the Oracle JDBC driver.
    
    ** Make necessary SQL changes in database queries.
         
    ** Update Stored Procedure and Function Creation Scripts

    ** Update Trigger Creation Scripts

    ** Update Trigger Creation Scripts

    Q: Can this be automated?

    A: Yes. Tools like ora2pg can convert PL/SQL code (procedures, functions, triggers, etc.) into PostgreSQL-compatible PL/pgSQL.

6. Application Testing: Run extensive tests on the updated JEE application in the test environment.

7. Performance Tuning: Optimize database queries, indexes, and configuration settings if needed.

6. Repeat steps 1 - 7 (except for 5 which can be reapplied) in the production environment.

## Post-Migration

1. Monitoring: Monitor the system for any issues.

2. Optimization: Monitor and tune the performance of the PostgreSQL database.

3. Documentation: Document the migration process.