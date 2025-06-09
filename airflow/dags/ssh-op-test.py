from airflow.decorators import dag
from airflow.providers.ssh.operators.ssh import SSHOperator


def create_dag():
    params = {"run_id": ""}

    @dag(dag_id="ssh-op-test", params=params, schedule=None)
    def def_dag():
        test_ssh = SSHOperator(
            task_id="ssh-test-task",
            ssh_conn_id="connect-to-host-ssh",
            command="hostname",
            get_pty=True,
        )

        test_ssh

    return def_dag()


dag = create_dag()
