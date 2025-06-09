import mlflow
import bentoml

from omegaconf import DictConfig
from bentos.args import BentoArgs


def register_mlflow_to_bentoml(cfg: DictConfig, args: BentoArgs):
    model_name = cfg.serving.model_name
    model_labels = cfg.serving.labels
    mlflow_uri = cfg.mlflow.tracking_uri
    mlflow_model_uri = cfg.mlflow.model_uri

    if args.model_uri:
        mlflow_model_uri = args.model_uri

    print(f"==========================================================")
    print(f">>> mlflow uri: {mlflow_uri}")
    print(f">>> model name: {model_name}")
    print(f">>> model uri: {mlflow_model_uri}")
    print(f"==========================================================")

    mlflow.set_tracking_uri(mlflow_uri)
    bentoml.mlflow.import_model(model_name, mlflow_model_uri, labels=model_labels)

    return bentoml.mlflow.load_model(f"{model_name}:latest")
