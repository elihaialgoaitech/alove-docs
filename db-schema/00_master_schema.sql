--
-- Master Schema File
-- This file includes all schema files in the correct dependency order
--

-- 1. Schemas and Core Tables (must be first)
\i 01_schemas_and_core.sql

-- 2. Profile Tables (depends on core tables)
\i 02_profile_tables.sql

-- 3. Backoffice Tables (depends on core tables)
\i 03_backoffice_tables.sql

-- 4. Content Tables (depends on core tables)
\i 04_content_tables.sql

-- 5. Events Tables (depends on schemas)
\i 05_events_tables.sql

-- 6. Matchmakers Tables (depends on schemas)
\i 06_matchmakers_tables.sql

-- 7. Questions Tables (depends on core tables)
\i 07_questions_tables.sql

-- 8. Introductions Tables (depends on core tables)
\i 08_introductions_tables.sql

-- 9. Views (depends on all tables)
\i 09_views.sql 