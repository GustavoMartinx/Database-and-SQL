from __future__ import annotations
from airflow import DAG
from datetime import datetime
from airflow.operators.python import PythonOperator
from airflow.providers.http.sensors.http import HttpSensor
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.models import Variable
import pandas as pd
import json
import os
import glob
from airflow.providers.amazon.aws.hooks.s3 import S3Hook


# Variables
path = Variable.get("path_randomuser")
compression = Variable.get("compression_randomuser")
filename = Variable.get("filename_randomuser")       # filename (randomuser.parquet)
bucket_name = Variable.get("bucket_name_randomuser")


# Argumentos para a DAG
default_args = {
    'owner': 'Gustavo Martins',
    'depends_on_past': False,
    'retries': 1
}


# Função que realiza o processamento dos dados "users"
def transform_user(ti, path, ds, filename, compression):
    users = ti.xcom_pull(task_ids=['get_users'])
    pd.set_option('display.max_columns', None)
    if not len(users) or 'results' not in users[0]:
        raise ValueError('User is empty')
    df = pd.json_normalize(users[0]['results'])
    df.info()

    df2 = pd.DataFrame(df, dtype=str)
    df2.info()
    print("df2.head: ) ", df2.head())
    
    if not os.path.exists(path):
        os.makedirs(path, exist_ok=True)
    
    fullname = os.path.join(path, filename)
    df2.to_parquet(path=fullname, compression=compression, index=False)


# Função que carrega os dados para o S3
def local_to_s3(bucket_name, dir_target, ds, filepath):
    s3 = S3Hook()
    if glob.glob(filepath):
        for f in glob.glob(filepath):
            print("File to move {}".format(f))
            key = dir_target+ds+'/'+f.split('/')[-1]
            s3.load_file(filename=f, bucket_name=bucket_name, replace=True, key=key)
    else:
        raise ValueError('Directory is empty no file to copy')


# Função que remove os arquivos locais 
def remove_local_file(filepath):
    files = glob.glob(filepath)
    for f in files:
        os.remove(f)




# Instanciação do DAG
with DAG(
    'Example_ETL_randomuser',
    default_args=default_args,
    description='DAG to capture data from web and sotarage it in AWS S3',
    schedule_interval='@daily',
    start_date=datetime.now(),
    catchup=False,
    tags=['example', 'ETL', 'Random User'],
) as dag:
    
    # ************ TASKS ***************
    # Verificar se a API está disponível
    api_available = HttpSensor(
        task_id = 'api_available',
        http_conn_id = 'randomuser_api',
        endpoint = '/api'
    )

    get_users = SimpleHttpOperator(
        task_id = 'get_users',
        http_conn_id = 'randomuser_api',
        endpoint = '/api/?results=10',
        method = 'GET',
        response_filter = lambda response: json.loads(response.text),
        log_response = True
    )

    transform_user = PythonOperator(
        task_id = 'transform_user',
        python_callable = transform_user,
        op_kwargs = {'path': path, 'filename': filename, 'compression': compression}
    )
    
    upload_to_s3 = PythonOperator(
        task_id='upload_to_s3',
        python_callable=local_to_s3,
        op_kwargs={
            'bucket_name': bucket_name,
            'dir_target': 'randomuser/',
            'filepath': './data/randomuser/*.parquet'
        },
    )

    remove_df_local = PythonOperator(
        task_id='remove_df_local',
        python_callable=remove_local_file,
        op_kwargs={
            'filepath': './data/randomuser/*.parquet'
        },
    )

api_available >> get_users >> transform_user >> upload_to_s3 >> remove_df_local
