from airflow.decorators import dag
from airflow.providers.ssh.operators.ssh import SSHOperator
def create_dag():

    @dag(dag_id="stop_bento", schedule=None)
    def def_dag():
        stop_bento = SSHOperator(
            task_id="stop_bento_serving",
            ssh_conn_id="connect-to-host-ssh",
            command="/home/ubuntu/mlops/bento-ml/stop.sh "
        )
        stop_bento

    return def_dag()

dag = create_dag()
