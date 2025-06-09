from airflow.decorators import dag
from airflow.providers.ssh.operators.ssh import SSHOperator
def create_dag():

    params = {"model_uri": "", "port": 3000}
    @dag(dag_id="run_bento_with_model_uri", params=params, schedule=None)
    def def_dag():
        start_bento = SSHOperator(
            task_id="start_bento_serving",
            ssh_conn_id="connect-to-host-ssh",
            command="/home/ubuntu/mlops/bento-ml/run.sh {{ params.model_uri }} {{ params.port }} --background"
        )
        start_bento

    return def_dag()

dag = create_dag()
