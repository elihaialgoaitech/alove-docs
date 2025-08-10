# Database Schema Files

This directory contains the database schema split into logical, manageable files organized by subject matter.

## File Structure

### Master File
- **`00_master_schema.sql`** - Master file that includes all schema files in the correct dependency order

### Individual Schema Files

#### 1. **`01_schemas_and_core.sql`** - Schemas and Core Tables
Contains:
- Schema definitions (events, matchmakers)
- Basic lookup tables (profile_status, unit, asset_status, etc.)
- Core reference tables (brand, role, workflow_status, etc.)
- Question and introduction status tables

#### 2. **`02_profile_tables.sql`** - Profile Tables
Contains all profile-related tables:
- Profile attributes and assets
- Profile cards and payment methods
- Profile deletion requests and external info
- Profile sessions and status history
- Profile tokens and groups
- Asset verification and inspections
- Bio preference relations

#### 3. **`03_backoffice_tables.sql`** - Backoffice (BO) Tables
Contains all backoffice/admin related tables:
- Customer support tables (tickets, SLA settings, topics)
- System users and roles
- Sessions and settings pages
- Audit logging
- User management

#### 4. **`04_content_tables.sql`** - Content Tables
Contains content, translations, and communication tables:
- Contents and communications
- Translations and language settings
- Popup categories and popups
- General codes and settings
- Communication preferences

#### 5. **`05_events_tables.sql`** - Events Tables
Contains all tables from the events schema:
- Communication logs
- Match scores
- Profile events
- Usage events

#### 6. **`06_matchmakers_tables.sql`** - Matchmakers Tables
Contains all tables from the matchmakers schema:
- Matchmakers main table
- Matchmaker logs
- Single types

#### 7. **`07_questions_tables.sql`** - Questions and Responses Tables
Contains question and response related tables:
- Question categories and correlations
- Question responses and automatic responses
- Predictor relations

#### 8. **`08_introductions_tables.sql`** - Introductions and Matching Tables
Contains introduction and matching related tables:
- Introduction history
- Groups and batch management
- Tag rules

#### 9. **`09_views.sql`** - Database Views
Contains all database views:
- Profile responses current view
- Show profile core view
- Show profile introductions view
- Show profile reports view

## Usage

### To create the entire database schema:
```bash
psql -d your_database -f 00_master_schema.sql
```

### To create specific parts of the schema:
```bash
# Create only schemas and core tables
psql -d your_database -f 01_schemas_and_core.sql

# Create only profile tables
psql -d your_database -f 02_profile_tables.sql

# And so on...
```

## Dependencies

The files should be executed in the following order due to dependencies:

1. `01_schemas_and_core.sql` - No dependencies
2. `02_profile_tables.sql` - Depends on core tables
3. `03_backoffice_tables.sql` - Depends on core tables
4. `04_content_tables.sql` - Depends on core tables
5. `05_events_tables.sql` - Depends on schemas
6. `06_matchmakers_tables.sql` - Depends on schemas
7. `07_questions_tables.sql` - Depends on core tables
8. `08_introductions_tables.sql` - Depends on core tables
9. `09_views.sql` - Depends on all tables

## Benefits of This Structure

1. **Modularity**: Each file focuses on a specific domain
2. **Maintainability**: Easier to find and modify specific tables
3. **Reusability**: Can deploy specific parts of the schema
4. **Clarity**: Clear separation of concerns
5. **Version Control**: Better tracking of changes per domain

## Notes

- All ALTER TABLE statements have been removed from the original schema
- The master file (`00_master_schema.sql`) ensures proper execution order
- Each file is self-contained and includes all necessary table definitions
- Comments and constraints are preserved in their respective files 