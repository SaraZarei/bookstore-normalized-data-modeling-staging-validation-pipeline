## 🗃️ Project Overview: Design a Normalized Data Modeling with Staging and Validation phases for a Bookstore

This project demonstrates a **normalized relational data model** built from raw input data using a **staging-to-production pipeline**. The main goal was to design a clean, relational schema that ensures **data integrity**, supports **referential consistency**, and rejects invalid or duplicate records during the data ingestion process.
In this project for **DDL(structure)** I used **sql editor** and for **DML(data load)** I used **python** code

---

### ✅ Key Features

- **Primary Key Detection**: Each table was analyzed to identify appropriate primary key fields based on uniqueness, absence of nulls, and duplicates. This process was automated using a Python script [`checking_PK.py`](./scripts/checking_PK.py).

- **Foreign Key Relationships**: Referential integrity was established by setting foreign key constraints across tables such as `Book`, `Author`, `Publisher`, `Edition`,  `Ratings`,`Sales`, `Checkouts`, `Award`, and `Info`.

- **Normalized Schema**: The data model follows standard normalization principles (up to 3NF), ensuring separation of concerns between entities (e.g., `Author`, `Book`, `Publisher`, `Edition`).

- **Staging Layer**: A dedicated `staging` schema was created to load raw data without constraints. This allows initial exploration and cleaning before enforcing rules.

- **Validation Logic**: Python scripts were developed to validate data before inserting into the `production` schema. Any rows violating constraints (e.g., missing foreign keys or duplicate primary keys) were redirected to logging tables for further inspection.

- **Composite Keys**: Used appropriately in tables like `Checkouts` (`BookID`, `CheckoutMonth`) and `Sales` (`ItemID`, `OrderID`) to reflect real-world uniqueness.

- **Entity Relationship Diagram (ERD)**: A visual representation of the table relationships is included to highlight how foreign keys connect the schema.

- **Data Loading to Staging**: Python scripts were developed to connect to the database and inserts data into the appropriate staging tables.



### 🔍 Technologies Used

- PostgreSQL 
- Python 
- VSCode


### 🔍 Primary Key Evaluation and Assignment

Each table was evaluated to determine a suitable **Primary Key (PK)**. I checked the following criteria using a Python script [`checking_PK.py`](./scripts/checking_PK.py):

- Uniqueness
- Not null
- No duplicate values

#### ✅ Primary Keys Identified

- `Book` → `BookID`
- `Author` → `AuthID`
- `Series` → `SeriesID`
- `Publisher` → `PubID`
- `Edition` → `ISBN`

#### 🛠️ Primary Keys Created

- `Checkouts` → Composite key: `BookID`, `CheckoutMonth`
- `Rating` → New column: `RatingID` (`IDENTITY AS ALWAYS`, `NOT NULL`)
- `Info` → New column: `BookID` generated from `BookID1 || BookID2`
- `Award` → New column: `BookID` from `Book` table where `Title` matches.
    - I used natural keys (`Title`) to connect `Book` and `Award` tables. Then I removed `Title` from `Award` table, because It’s now accessible via JOIN with the `Book` table and It prevents 2NF violations and redundancy.
- `Sales` → Composite key: `ItemID`, `OrderID`
    - I removed  `ISBN` because is only dependent on `ItemID`, not on `OrderID`. So `ISBN` is partially dependent on the composite key,so Keeping `ISBN` in `Sales` introduces redundancy and breaks 2NF.
    - To fix the violation and normalize the model, I createe an `Item` table to store the link between `ItemID` and `ISBN`.
    - In `Item` table, `ItemID` is PK and `ISBN` is FK that refrences to `Edition` table
    - I populated  `Item` table with extracting unique `ItemID`s and their associated `ISBN` from `Sales` table.



### 🧩 Normalization Strategy

The data model was designed following the principles of **relational normalization** to reduce redundancy and ensure data integrity. Here's how each **normal form (NF)** was applied:

#### ✅ First Normal Form (1NF)

- Ensured that all columns contain **atomic values** (no lists or nested structures).
- Removed repeating groups and ensured each field stores a single value (e.g., one `AuthorID` per `Book` row).
- Detected non-atomic values using a custom Python script that scanned for delimiter patterns (commas) across columns likely to contain multiple entries.
- This helped identify violations in the staging data and informed the design of junction tables to properly normalize many-to-many relationships.

#### ✅ Second Normal Form (2NF)

- To evaluate Second Normal Form (2NF) for your Award table, we need to check whether every non-key attribute is fully dependent on the entire composite primary key and not on a part of it.
- Applied to tables with **composite primary keys** ( `Checkouts`, `Award` and `Sales`).
- IN `Checkouts` table:
    - Ensured that all non-key attributes are **fully dependent on the entire composite key**.
    - `Number_of_Checkouts` is fully dependent on the entire composite key (`BookID`, `CheckoutMonth`). 

- IN `Award` table:
    - I removed  `Title` because it It prevents 2NF violations and make redundancy.
    - the `Title` is not dependent on all three foreign keys (`BookID`, `Award_Name`, `Year_Name`)
    - The title of a book is directly dependent only on `BookID` and It has nothing to do with the specific award name or the year in which the award was given.
    - `Award` table should store only data about awards, and use `BookID` as a foreign key to reference the book (and its title indirectly, if needed via a JOIN).

- IN `Sales` table:
    - I removed  `ISBN` because is only dependent on `ItemID`, not on `OrderID`. So `ISBN` is partially dependent on the composite key,so Keeping `ISBN` in `Sales` introduces redundancy and breaks 2NF.


#### ✅ Third Normal Form (3NF)

- where a non-key column depends on another non-key column, not directly on the primary key.
- In a denormalized `Book` table, columns like `AuthorName`, `PublisherName`, and `SeriesName` do not depend directly on the primary key (`BookID`). Instead, they represent separate entities:
    - `AuthorName` describes the **Author** entity.
    - `PublisherName` describes the **Publisher** entity.
    - `SeriesName` describes the **Series** entity.
This creates **transitive dependencies**, where non-key columns depend on other non-key columns rather than on the primary key itself. This violates the rules of 3NF.


### 🔍 Foriegn Key Assignment

- `Book` → `AuthID`
- `Rating` → `BookID`
- `Edition` → `BookID`, `PubID`
- `Item` → `ISBN`
- `Checkouts` → `BookID`
- `Award` → `BookID`
- `Info` → `BookID`


### 🧩 Entity Relationship Diagram

This diagram shows the foreign key relationships between the tables in the data model.


![Entity Relationship Diagram](./images/erd_diagram.png)

### 📥 Data Loading to Staging

To automate the process of loading data from CSV files into the staging schema of the PostgreSQL database, I wrote a Python script. This script connects to the database and inserts data into the appropriate staging tables.

You can find the automation script here:  
`LoadData_to_Table_in_Database.py` (located in the `scripts` folder).

### 🧩 Explanation of Python Scripts 

- [`main.py`](./scripts/main.py) 

This script uses two custom helper functions stored in separate Python files:

- `convert_spaces_to_underline_for_column_name`:  
  Replaces spaces in column names with underscores to standardize field names before loading.

- `load_data_into_tableDataset`:  
  Handles inserting a DataFrame into the corresponding PostgreSQL table within the specified schema.

These functions are imported and used to streamline the data cleaning and loading process.

- [`checking_PK.py`](./scripts/checking_PK.py) 

- This script checks whether specific columns in selected Excel sheets can be used as primary keys. It verifies that each column is unique and has no null values.

- [`Validation_Insert.sql`](./scripts/Validation_Insert.sql) 

- This SQL script validates and then loads data from the tables in `staging` schema into tables in `Production` schema 

- [`staging.sql`](./scripts/staging.sql) 

- This SQL script loads data from Excel sheets into tables in `staging` schema 