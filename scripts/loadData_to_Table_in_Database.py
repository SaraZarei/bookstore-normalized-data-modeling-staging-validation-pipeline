# %%
import pandas as pd
from sqlalchemy import create_engine
import logging

# %%
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
# %%

def load_data_into_tableDataset(df, table_name, schema_name):
    try:
        engine = ('postgresql+psycopg2://postgres:@localhost:5432/bookshop_project')
        df.to_sql(table_name, engine, if_exists='append',schema= schema_name, index = False)
        logging.info(f'data in {schema_name}.{table_name} loaded')
    except Exception as e:
        logging.error(f'load data into {schema_name}.{table_name} failed: {e}')



# %%
