from airflow import DAG
from datetime import datetime
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.operators.python import BranchPythonOperator
import json
import requests
import pandas as pd


def capturar_contar_dados():
    url = "https://data.cityofnewyork.us/resource/rc75-m7u3.json"
    response = requests.get(url)
    df = pd.DataFrame(json.loads(response.content))
    qtd = len(df.index)
    return qtd
   

def eh_valida(ti):
    qtd = ti.xcom_pull(task_ids = 'capturar_contar_dados')
    if (qtd > 1000):
        return 'valida'
    return 'invalida'



# ********* Instanciação do DAG ***************
with DAG(
    'DAG_Simples',
    description='Sample DAG to concepts example',
    start_date=datetime.now(),
    schedule_interval='30 * * * *',
    catchup=False,
    tags=['Exemplo Simples'],
) as dag:
    
    # ************ TASKS ***************
    capturar_contar_dados = PythonOperator(
        task_id = 'capturar_contar_dados',
        python_callable = capturar_contar_dados
    )
    
    eh_valida = BranchPythonOperator(
        task_id='eh_valida',
        python_callable = eh_valida
    )

    valida = BashOperator(
        task_id='valida',
        bash_command = 'echo "QTDE OK"'
    )

    invalida = BashOperator(
        task_id = 'invalida',
        bash_command = 'echo "QTDE NOT OK"'
    )

capturar_contar_dados >> eh_valida >> [valida, invalida]
