# streamlit web demo

```shell
# 직접 실행 (webapps 경로에서)
PYTHON_PATH=. streamlit run ./disease-classifier/st_demo.py
```

```shell
# 스크립트로 실행 (run.sh)
.../webapps/disease-classifier/run.sh 
```

```shell
# PM2로 관리 실행
pm2 start ./webapps/disease-classifier/run.sh 
```
