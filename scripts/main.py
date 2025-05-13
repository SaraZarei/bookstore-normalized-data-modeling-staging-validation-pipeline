# %%
import pandas as pd
from pathlib import Path
from convert_spaces_to_underline_for_column_name import convert_spaces_to_underline_for_column_name
from  loadData_to_Table_in_Database import load_data_into_tableDataset
import logging

# %%
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
# %%
base_path = Path('E:/Git/Data Engineering/de-python-sql-data-modeling-bookshop-pipeline/data/Bookshop.xlsx')

tables = [
    'Author',
    'Book',
    'Ratings',
    'Publisher',
    'Sales_Q1',
    'Sales_Q2',
    'Sales_Q3',
    'Sales_Q4',
    'Edition',
    'Series',
    'Info',
    'Award',
    'Checkouts'    
]
schema_name= 'staging'
try:
    for item in tables:
        df = pd.read_excel(base_path, sheet_name= item)
        new_df = convert_spaces_to_underline_for_column_name(df)
        load_data_into_tableDataset(new_df, item, schema_name )
        logging.info(f'data {item} successfully loaded')

except Exception as e:
    logging.error(f'failed: {e}')
# %%
