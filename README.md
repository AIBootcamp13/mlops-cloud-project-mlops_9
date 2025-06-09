# 질병예측 모델 MLOps 팀 프로젝트

<br>

## 💻 프로젝트 소개
### <프로젝트 소개>
- 본 프로젝트는 증상 데이터를 기반으로 한 질병 예측 모델을 개발하고, 이를 MLOps 환경 위에서 자동화 및 서빙까지 일관되게 구성하는 것을 목표로 합니다

### <작품 소개>
- 팀원들이 협업하여 데이터 처리부터 모델 서빙까지 전 과정을 Ec2 서버 배포 후 Docker 기반의 파이프라인으로 구성하였고, MLflow를 통한 실험 추적과 BentoML을 활용한 서빙 기능 및 배포 후 모니터링 과정을 포함합니다

<br>

## 👨‍👩‍👦‍👦 팀 구성원

| ![멤버1](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버2](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버3](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버4](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버5](https://avatars.githubusercontent.com/u/156163982?v=4) | ![멤버6](https://avatars.githubusercontent.com/u/156163982?v=4) |
| :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: | :------------------------------------------------------------: |
|   [이정민](https://github.com/yourprofile1)   |   [염창환](https://github.com/yourprofile2)   |   [안진혁](https://github.com/yourprofile3)   |   [이상원](https://github.com/yourprofile4)   |   [정재훈](https://github.com/yourprofile5)   |   [진정](https://github.com/yourprofile6)   |
| 팀장 | 팀원 | 팀원 | 팀원 | 팀원 | 팀원 |

<br>

## 🔨 개발 환경 및 기술 스택
- 주 언어 : Python
- 버전 및 이슈관리 : GitHub / Linear / Slack
- 협업 툴 : GitHub / Linear

<br>

## 📁 프로젝트 구조
```
├── airflow
│   ├── config
│   ├── dags
│   ├── docker-compose.trainer.yaml
│   ├── docker-compose.yaml
│   ├── Dockerfile.airflow
│   ├── Dockerfile.trainer
│   ├── guide.md
│   ├── requirements.airflow.txt
│   └── requirements.trainer.txt
├── bento-ml
│   ├── bentos
│   ├── guide.md
│   ├── main.py
│   ├── models
│   ├── requirements.txt
├── ec2
│   └── ...
├── mlflow
│   ├── docker-compose.yaml
│   ├── Dockerfile.mlflow
│   ├── guide.md
│   └── requirements.mlflow.txt
├── monitor
│   ├── docker-compose.yaml
│   └── prometheus.yml
└── webapps
    ├── disease-classifier
    └── guide.md
```

<br>

## 💻​ 구현 기능
### 기능1
- 사용자 증상 입력 기반 질병 예측 기능 (데이터셋 활용)

### 기능2
- MLflow를 통한 실험 기록 및 버전 관리 & Airflow Dag관리 -> BentoML을 통한 모델 서빙

### 기능3
- Streamlit(UI배포) -> Grafana & Prometheus(모니터링)

<br>

## 🛠️ 작품 아키텍처(필수X)
- #### _아래 이미지는 예시입니다_
![이미지 설명](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*ub_u88a4MB5Uj-9Eb60VNA.jpeg)

<br>

## 🚨​ 트러블 슈팅
### 1. 접근 에러

#### 설명
- 초기 Docker 내부 MLflow 호스트명이 잘못 설정되어 API 연결 오류 발생 & 윈도우 ssh 접속 .pem 파일 권한
#### 해결
- Docker Compose 내부 네트워크 설정 및 `.env` 수정으로 해결 / cmd 문법으로(powershell & cmd 문법 다름) 인한 권한 변경 성공
#### 설명
- EC2 instance의 스냅샵 이미지(AMI)를 만들어 놓았으나 로컬 컴퓨터로 다운로드 받을 수가 없었음
#### 해결
-  Docker 컨테이너 이미지와 AWS의 VM 이미지는 본질적인 차이가 있어서 호환이 안됨 -> Docker Image는 컨테이너화된 애플리케이션을 위한 파일 시스템 스냅샷으로, 컨테이너 환경에서 실행되지만, AMI는 가상 머신(VM)을 위한 완전한 운영 체제 이미지로, 가상 머신 환경에서 실행됨


<br>

## 📌 프로젝트 회고
### 멤버1
- 모델 개발과 동시에 MLOps 환경을 구축하면서 실제 서비스화의 중요성을 체감할 수 있었습니다.

<br>

## 📰​ 참고자료
- https://www.kaggle.com/datasets/kaushil268/disease-prediction-using-machine-learning
