from airflow.decorators import dag
from airflow.providers.ssh.operators.ssh import SSHOperator
def create_dag():

    params = {"confirm": True}
    @dag(dag_id="run_webapp", params=params, schedule=None)
    def def_dag():
        start_web  = SSHOperator(
            task_id="start_webapp",
            ssh_conn_id="connect-to-host-ssh",
            command="source ~/.nvm/nvm.sh && pm2 start /home/ubuntu/mlops/webapps/disease-classifier/run.sh  "
        )
        start_web

    return def_dag()

dag = create_dag()
