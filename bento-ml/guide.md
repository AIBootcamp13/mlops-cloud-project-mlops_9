# 벤또 서빙 (모듈 방식)
- 실행 인자 model_uri 우선 (없으면 config.yaml 활용)
- bento-ml 위치에서 다음 명령어 실행

```shell
# 스크립트로 백그라운드 실행 시 ./run/run_id 기록 
./start.sh runs:/d5899ca505ee411fa20ecd8f3197cae3/disease_rf_model 3000 --background

# ./run/run_id로 매칭되는 모든 프로세스 중지 
./stop.sh
```

```shell
# 모듈 방식 경로 지정
bentoml serve models.disease_classifier.make_bento:BentoDiseaseClassifier \
  --port 3000 \
  --arg model_uri="runs:/959c17d9a87c47ceb2035807e7cef1fe/disease_rf_model" \
  --working-dir . 
```

- 백그라운드 실행
```shell
nohup bentoml serve models.disease_classifier.make_bento:BentoDiseaseClassifier \
  --port 3000 \
  --arg model_uri="runs:/959c17d9a87c47ceb2035807e7cef1fe/disease_rf_model" \
  --working-dir . > bentoml.log 2>&1 & echo $! > bentoml.pid
```

# BentoML 주의 사항
- 타입 힌트에 Typing 활용
  - def predict(...) -> Dict[str, any]  (X)
  - def predict(...) -> Dict[str, Any]  (O)

- 설정 yaml 문자열 값 주의 (특수 문자 있는 경우 따옴표 처리)
  - "runs:/d5899ca505ee411fa20ecd8f3197cae3/disease_rf_model"  

- bentoml import 사용 시 set_tracking_url은 mlflow 패키지 수행 (bentoml.mlflow X)
```python
import bentoml
import mlflow

mlflow.set_tracking_uri(mlflow_uri)
bentoml.mlflow.import_model(model_name, mlflow_model_uri, labels=model_labels)
```