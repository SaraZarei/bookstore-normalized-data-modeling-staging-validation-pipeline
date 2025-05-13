# Importing the pandas library to work with dataframes
import pandas as pd

# Define a function to check for uniqueness, nulls, and duplicates in a specific column of a dataframe
def uniqness_nulls_duplicates(df, column):
    # Check if all values in the column are unique
    if df[column].is_unique:
        print(f'{column} column is Unique')
    else:
        print(f'{column} column is not Unique')
    
    # Check if there are any null values in the column
    if df[column].isnull().sum() == 0:
        print(f'not null for {column}')
    else:
        print(f'there is null in {column} column')

# Dictionary mapping each table (sheet name) to the column to be checked
tables = {
    'Author': 'AuthID',
    'Book': 'BookID',
    'Series': 'SeriesID',
    'Publisher': 'PubID',
    'Edition': 'ISBN',
}

# Iterate through each table and column in the dictionary
for table_name, column in tables.items():
    # Read the specific sheet (table) from the Excel file into a DataFrame
    df = pd.read_excel(
        'E:/Git/Data Engineering/de-python-sql-data-modeling-bookshop-pipeline/data/Bookshop.xlsx',
        sheet_name=table_name
    )
    
    # Call the function to check uniqueness and null values for the specified column
    uniqness_nulls_duplicates(df, column)

    
    
    



 