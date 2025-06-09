from typing import Dict, Any

import bentoml
import numpy as np
from omegaconf import OmegaConf, DictConfig

from bentos.args import BentoArgs


class BentoMLBasePredictor:
    def __init__(self, model, cfg: DictConfig, args: BentoArgs):
        self.cfg = cfg
        self.args = args
        self.model = model

    @bentoml.api
    def predict(self, input_data: list) -> Dict[str, Any]:
        ins = np.array([input_data])
        ins.reshape((-1, 132))
        pred = self.model.predict(ins)

        return {
            "prediction": pred.tolist(),
            "status": "success",
        }

    @bentoml.api
    def health(self) -> Dict[str, Any]:
        return {"status": "healthy", "metadata": self.model.metadata.to_json()}

    @bentoml.api
    def model_info(self) -> Dict[str, Any]:
        return {
            "model_uri": self.args.model_uri,
            "config": OmegaConf.to_container(self.cfg, resolve=True),
        }

    @bentoml.on_shutdown
    def shutdown(self):
        print("cleanup actions on Service shutdown")

    @bentoml.on_shutdown
    async def async_shutdown(self):
        print("async cleanup actions on Service shutdown")
