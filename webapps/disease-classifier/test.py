import json
from pathlib import Path

import bentoml
import numpy as np

if __name__ == "__main__":

    def load_symptoms():
        arr = []
        curr_dir = Path(__file__).resolve().parent
        with open(f"{curr_dir}/symptoms.json", "r", encoding="utf-8") as f:
            data = json.load(f)
            arr.extend(data["symptoms"])
        return arr

    def predict_disease(data):
        try:
            with bentoml.SyncHTTPClient("http://localhost:3000/predict") as client:
                return client.predict(data)
        except Exception as e:
            pass
        return None

    symptoms = load_symptoms()

    def to_model_input(checked_symptoms: list):
        arr = [0] * len(symptoms)
        for s in checked_symptoms:
            arr[symptoms.index(s)] = 1
        return np.array([arr])

    # fmt: off
    checked = [
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0,
    ]
    # fmt: on

    ins = np.array([checked])
    predict_disease(ins)
