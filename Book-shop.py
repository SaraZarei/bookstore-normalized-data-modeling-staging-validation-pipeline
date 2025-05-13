# %%
import pandas as pd
from sqlalchemy import create_engine, text 
# %%
# Connect to PostgreSQL
engine = create_engine("postgresql+psycopg2://postgres:@localhost:5432/bookshop_project")
# %%
excell_file_path = 'E:/Git/Data Engineering/de-python-sql-data-modeling-bookshop-pipeline/data/Bookshop.xlsx'

tables = [
    'Author',
    'Book',
    'Series',
    'Info',
    'Award',
    'Checkouts',
    'Publisher',
    'Edition',
    'Ratings',
    'Sales Q1',
    'Sales Q2',
    'Sales Q3',
    'Sales Q4'
]  
# %%
for item in tables: 

     # After truncating or skipping, now read data from the Excel file
    df = pd.read_excel(excell_file_path, sheet_name=item)

    # Replace spaces in column names with underscores (_) for database compatibility
    df.columns = [col.replace(" ", "_") for col in df.columns]

    # Insert the DataFrame into the corresponding PostgreSQL table
    # if_exists='append' means add rows (assumes table already exists)
    df.to_sql(item, engine, if_exists='append', index=False)

    # Print a success message for this table
    print(f"Data loaded into {item} table successfully!")

# %%
