# %%
import pandas as pd 
import logging
# %%
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
# %%
def convert_spaces_to_underline_for_column_name(df):
        try:
                # Replace spaces in column names with underscores (_) for database compatibility
                df.columns = [col.replace(" ", "_") for col in df.columns]
                logging.info('convert spaces to underline for colum names done and df returned')
                return df
                
        except Exception as e:
                logging.error(f'convert spaces to underline for colum names failed: {e}')
# %%
