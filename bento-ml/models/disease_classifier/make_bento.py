import bentoml

from bentos.args import BentoArgs
from bentos.configs import load_bento_config
from bentos.predictor import BentoMLBasePredictor
from bentos.register import register_mlflow_to_bentoml

cfg = load_bento_config(__file__)
args = bentoml.use_arguments(BentoArgs)
model = register_mlflow_to_bentoml(cfg, args)


@bentoml.service(resources=cfg.service.resources, traffic=cfg.service.traffic)
class BentoDiseaseClassifier(BentoMLBasePredictor):
    def __init__(self):
        super().__init__(model, cfg, args)
