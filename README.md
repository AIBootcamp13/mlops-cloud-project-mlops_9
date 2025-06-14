# 질병예측 모델 MLOps 팀 프로젝트

<br>

## 💻 프로젝트 소개
### <프로젝트 소개>
- 이번 MLops 9조의 프로젝트는 증상 데이터를 기반으로 한 질병 예측 모델을 개발하고, 이를 MLOps 환경 위에서 자동화 및 서빙까지 일관되게 구성하는 것을 목표로 하였습니다

### <작품 소개>
- 팀원들이 협업하여 데이터 처리부터 모델 서빙까지 전 과정을 Ec2 서버 배포 후 Docker 기반의 파이프라인으로 구성하였고, MLflow를 통한 실험 추적과 BentoML을 활용한 서빙 기능 및 배포 후 모니터링 과정을 포함하여 구성하였습니다

<br>

## 👨‍👩‍👦‍👦 팀 구성원

| ![멤버1](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버2](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버3](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버4](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버5](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버6](https://avatars.githubusercontent.com/u/156163982?v=4) |
| :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: |
|   [이정민](https://github.com/yourprofile1)   |   [염창환](https://github.com/yourprofile2)   |   [안진혁](https://github.com/yourprofile3)   |   [이상원](https://github.com/yourprofile4)   |   [정재훈](https://github.com/yourprofile5)   |   [진정](https://github.com/yourprofile6)   |
| 팀장 | 팀원 | 팀원 | 팀원 | 팀원 | 팀원 |

<br>

## 🔨 개발 환경 및 기술 스택
- 주 언어 : Python / shell
- 버전 및 이슈관리 : GitHub / Linear / Slack
- 협업 툴 : GitHub / Linear
<details>
  <summary>linear 더 보기</summary>
  <img src="https://github.com/user-attachments/assets/82a832d7-e051-4cda-9205-153d929710b7" \>
  <img src="https://github.com/user-attachments/assets/44123190-1624-47fc-9031-293303d66c8f" \>
</details>

<br>

## 📁 프로젝트 구조
```
├── airflow
│   ├── Dockerfile.airflow    # airflow custom 이미지 (호스트 도커 그룹 등록과 airflow worekr에 기본 파이썬 requirements 추가)
│   ├── Dockerfile.trainer    # 모델 훈련이 이루어질 도커 이미지 (모델 훈련을 위한 별도 이미지 활용 docker-operator로 호스트 도커 데몬 연결)
│   ├── config
│   │   └── config.yaml       # 대부분의 파이프라인 설정 (hydra config)
│   ├── dags
│   │   ├── pipeline
│   │   │   └── template.py   # 일반적 tabular 데이터 기반 모델 훈련 플로우 추상화 
│   │   ├── run_bento.py      # 주어진 model_uri로 bentoml api 서빙 시작
│   │   ├── run_webapp.py     # streamlit으로 모델 데모 웹앱 시작
│   │   ├── ssh-op-test.py    # 간단한 ssh-operation 테스트 
│   │   ├── stop_bento.py     # 서빙되고 있는 bento-ml api 서비스 내리기
│   │   ├── tasks
│   │   │   ├── config.py     # 설정 로더
│   │   │   ├── git.py        # git cloner
│   │   │   └── s3.py         # s3 다운로더
│   │   ├── train_disease.py  # 질병 예측 모델 
│   │   └── train_imdb.py
│   ├── docker-compose.trainer.yaml    # 트레이너 이미지에 환경 변수 좀 편하게 빌드하기 위함
│   ├── docker-compose.yaml            # airflow 컴포즈 파일 
│   ├── env.template                   # uid, gid 등 
│   ├── guide.md                       # airflow 관련 명령어 + 노트
│   ├── plugins                   
│   ├── requirements.airflow.txt       # airflow 이미지에 사용할 기본 파이썬 패키지들
│   ├── requirements.trainer.txt       # 모델 훈련 트레이너 이미지에 사용할 기본 파이썬 패키지들
│   └── tmp_run                        # 모델 훈련 파이프라인이 수행될 때 사용되는 임시 공간 (최초 빈 디렉토리, 컨테이너와 볼륨 마운트)
├── bento-ml                          
│   ├── bentos                          
│   │   ├── args.py                    # 
│   │   ├── configs.py                 # 설정 로더
│   │   ├── predictor.py               # 일반적인 모델 API 정의
│   │   └── register.py                # MLFLow에서 모델 가져와서 BentoML 모델로 등록
│   ├── guide.md                       # bento-ml 서빙 명령어 노트
│   ├── main.py                        # MLFlow 모델 가져오기 테스트 
│   ├── models                         # 지원하는 모델들
│   │   └── disease_classifier         # 질병 예측 분류를 위한 패키지
│   │       ├── config.yaml            # 기본 model_uri와 모델 가져올 MLFlow 엔드포인트 및 서빙 resource 설정
│   │       └── make_bento.py          # 패키지 config에 정의된 모델 기준으로 bento service 정의
│   ├── requirements.txt               # bento_ml 구동을 위한 기본 파이썬 패키지 정의
│   ├── run                            # 모델 서빙 시 추적을 위한 run 폴더
│   │   └── run.id                     # bento 파이썬 모듈 경로 (stop.sh에서 run.id로 서비스 다운)
│   ├── run.sh                         # bento_ml 서빙 시작 스크립트
│   └── stop.sh                        # bento_ml 서빙 중지 스크립트
├── ec2                  
│   ├── setup.sh                     # ec2 최초 생성 시 설치 및 도커 실행 스크립트
│   └── setup_old.sh
├── mlflow                           
│   ├── Dockerfile.mlflow            # mlflow 도커 이미지 정의
│   ├── docker-compose.yaml          # mlflow 도커 컴포즈 정의
│   ├── env.template                 # mlflow 계정 정보 등
│   ├── guide.md                     # 
│   └── requirements.mlflow.txt      # mlflow 요구 파이썬 패키지들
├── monitor                          
│   ├── docker-compose.yaml          # 웹앱 트래픽 모니터링 (프로메테우스 + 그라파나)
│   └── prometheus.yml               
└── webapps                          # 모델 API 활용한 웹앱들
├── disease-classifier               # 질병 예측 데모 streamlit
│   ├── requirements.txt             # 질병 예측 데모에 필요한 파이썬 패키지들
│   ├── run.sh                       # 실행 스크립트
│   ├── st_demo.py                   # streamlit 데모 
│   ├── symptoms.json                # 병리 증상
└── guide.md
```

## 수동 절차 (airflow ssh-connection 설정)
- 요약: 접속할 대상 머신의 pem키를 airflow worker 컨테이너 내부로 복사하고 해당 위치를 airflow 웹 UI에서 설정
- ssh authorized key 등록 처리 (아래 이미지들은 삭제될 인스턴스들의 키)
  - 이 프로젝트는 ec2 비용상 자신에 접속하므로 자신의 pub키를 authorized_keys에 기록
- airflow dag 태스크에서 사용하려면 위 UI 설정에서 사용한 ssh_conn_id를 ssh-operator에서 지정
<details>
  <summary>ssh 설정 과정 보기 </summary>
  <img src="https://github.com/user-attachments/assets/05d720fc-f8fc-4194-a182-54e467e93711" \>
  <img src="https://github.com/user-attachments/assets/163eba9c-8867-45a9-81b5-dc68ed345053" \>
  <img src="https://github.com/user-attachments/assets/e96f9153-81f1-454b-b3c0-13ce3e57fcf9" \>
  <img src="https://github.com/user-attachments/assets/c1968972-5e18-4219-b7a6-9a1d4833b5f0" \>
  <img src="https://github.com/user-attachments/assets/97bac0de-7c2d-4392-997d-38f9c7af6e1b" \>
  <img src="https://github.com/user-attachments/assets/5c55330d-a94e-41a6-8369-72720d5006f4" \>
  <img src="https://github.com/user-attachments/assets/5b3f8a05-0410-4875-b554-cef676e8ef04" \>
</details>

<br />

## 수동 절차 (ec2: git clone)
- 클론을 수행할 머신에서 생성한 ssh키를 repo 설정 deploy key를 통해 read 권한과 함께 설정

<br>

## Airflow 파이프라인 설정
- 덱으로 정의된 모델 학습 파이프라인에서 사용될 환경 설정
  - 모델 훈련 코드는 별도의 GIT에서 클론하여 호스트의 도커 데몬을 통해 훈련되는 방식
  - 덱 실행시 PAT 토큰을 입력하여 클론 권한 획득
![Image](https://github.com/user-attachments/assets/5d3fc3e2-6ad8-4504-b88a-51d84c33b0e7)

## 💻​ 구현 기능
### 기능1
- AWS Ec2 서버 (팀원 접속)
- 사용자 증상 입력 기반 질병 예측 기능 (데이터셋 csv 활용)

### 기능2
- MLflow를 통한 실험 기록 및 버전 관리 & Airflow Dag관리
- miniIO 버켓 관리 & BentoML을 통한 모델 서빙

### 기능3
- Streamlit(UI배포) -> 웹페이지에서 병명 & 개인별 증상 확인 가능
- Grafana & Prometheus(모니터링 툴 활용)

<br>

## 🛠️ 작품 아키텍처
![Image](https://github.com/user-attachments/assets/9e8e5694-c325-4f2b-8da0-edc782931eb1)

<br>

## 🚨​ 트러블 슈팅
### 1) 접근 에러 관련
#### 상황
- 초기 Docker 내부 MLflow 호스트명이 잘못 설정되어 API 연결 오류 발생 & 윈도우 ssh 접속 .pem 파일 권한
- EC2 instance의 스냅샵 이미지(AMI)를 만들어 놓았으나 로컬 컴퓨터로 다운로드 받을 수가 없었음
#### 해결
- Docker Compose 내부 네트워크 설정 및 `.env` 수정으로 해결 / cmd 문법으로(powershell & cmd 문법 다름) 인한 권한 변경 성공
- Docker 컨테이너 이미지와 AWS의 VM 이미지는 본질적인 차이가 있어서 호환이 안됨 -> Docker Image는 컨테이너화된 애플리케이션을 위한 파일 시스템 스냅샷으로, 컨테이너 환경에서 실행되지만, AMI는 가상 머신(VM)을 위한 완전한 운영 체제 이미지로, 가상 머신 환경에서 실행됨

### 2) Airflow Web UI 접속 실패
#### 상황
- localhost:8080에서 Airflow 접속이 되지 않고, 컨테이너 상태가 계속 Exited (1)로 표시됨
- 로그 확인 결과 airflow db init이 정상적으로 실행되지 않았고, FERNET_KEY 환경변수 누락으로 인해 기동 실패
#### 해결
- .env 파일에 AIRFLOW__CORE__FERNET_KEY를 base64로 생성하여 추가하고, docker-compose.yml에서 해당 환경변수를 인식하도록 설정
- 이후 docker compose down -v로 초기화 후 up --build로 정상 기동됨

### 3) BentoML 모델 로드 실패
#### 설명
- bentoml serve bento_service:svc 실행 시 no Models with name 'disease_model' exist in BentoML store 에러 발생
- 모델 학습은 Airflow 컨테이너 내부에서 진행되었으나, BentoML 서비스가 참조하는 모델 저장소(/root/bentoml/models)와 분리되어 있었음
#### 해결
- 로컬에서 train.py를 수동 실행하여 BentoML 모델 저장소에 disease_model을 생성 -> 이후 bentoml build 및 containerize를 통해 새 이미지 생성 후 API 서비스 정상 기동

### 4) Airflow ssh-operator에서 sh 스크립트 호출 이슈
- airflow ssh operator의 경우 command 명령문이 "...some...script.sh" 처럼 sh로 끝나면 에러 발생 (템플릿으로 인식)
  - sh 뒤에 공백을 추가해주어야 정상 동작    
![Image](https://github.com/user-attachments/assets/8f256495-2cf1-4b04-8df2-e3c84ff03b88)
![Image](https://github.com/user-attachments/assets/ced9ccd1-f104-4f2f-9542-7adb32be27c5)

### 5) Airflow docker-operator host docker daemon 설정 이슈
- docker-operator의 경우 호스트의 도커 데몬을 사용하기 때문에 적절한 설정이 필요
- 이를 위해 호스트 머신의 도커 그룹 아이디를 컨테이너 설정에 반영해야 했음
  - airflow docker compose 설정, Dockerfile, env 참고

<br>

## 📌 프로젝트 회고
### 인프라 구축 관련
- Airflow, MLflow, BentoML을 도커로 연동하면서 MLOps 전체 흐름을 실습한 게 정말 큰 도움이 되었습니다. 처음엔 설정 충돌과 버전 이슈 때문에 많이 막혔지만, 하나씩 해결하면서 실무에 가까운 경험을 할 수 있었습니다.
### 모델링 관련
- 모델 자체는 간단한 RandomForest였지만, 이를 실험 관리(Mlflow), 서빙(BentoML)까지 연결해보니 모델링만으로 끝나는 게 아니라는 걸 체감했습니다. 실험 추적과 버전 관리가 생각보다 중요한 부분이라는 걸 느꼈고, 재현 가능한 실험 환경을 만드는 게 핵심이었음!
### BentoML API 관련
- BentoML로 API를 만드는 과정에서 추론 서비스가 어떻게 제품화되는지 구체적으로 이해하게 되었습니다. Swagger UI를 통해 입력-출력 구조를 확인하고, 실제 요청을 테스트하는 과정이 인상 깊었음.
### GitHub 협업/CI 흐름 관련
- 모든 팀원이 로컬에서 작업 후 GitHub에 통합하는 과정에서 커밋 전략이나 브랜치 관리의 중요성을 실감했습니다. 단순히 코드를 공유하는 게 아니라, 팀 전체가 같은 흐름으로 협업하려면 문서화와 디렉토리 구조가 정말 중요하다는 걸 느꼈음.
### 데이터 파이프라인 흐름 관련
- Airflow로 train.py를 실행하는 DAG을 구성하면서 워크플로 자동화의 기본을 익혔습니다. 단순히 스크립트를 실행하는 게 아니라, 다양한 Task 간 의존성과 실행 주기를 설정하는 구조 자체가 매우 실무적으로 느껴졌음.



<br>

## 📰​ 참고자료
- https://www.kaggle.com/datasets/kaushil268/disease-prediction-using-machine-learning
