# 질병예측 모델 MLOps 팀 프로젝트

<br>

## 💻 프로젝트 소개
### <프로젝트 소개>
- 본 프로젝트는 증상 데이터를 기반으로 한 질병 예측 모델을 개발하고, 이를 MLOps 환경 위에서 자동화 및 서빙까지 일관되게 구성하는 것을 목표로 합니다

### <작품 소개>
- 팀원들이 협업하여 데이터 처리부터 모델 서빙까지 전 과정을 Docker 기반의 파이프라인으로 구성하였고, MLflow를 통한 실험 추적과 BentoML을 활용한 서빙 기능을 포함합니다

<br>

## 👨‍👩‍👦‍👦 팀 구성원

| ![1](https://avatars.githubusercontent.com/u/156163982?v=4) | ![2](https://avatars.githubusercontent.com/u/156163982?v=4) | ![3](https://avatars.githubusercontent.com/u/156163982?v=4) | ![4](https://avatars.githubusercontent.com/u/156163982?v=4) | ![5](https://avatars.githubusercontent.com/u/156163982?v=4) | ![6](https://avatars.githubusercontent.com/u/156163982?v=4) |
| :--------------------------------------------------------------: | :--------------------------------------------------------------: | :--------------------------------------------------------------: | :--------------------------------------------------------------: | :--------------------------------------------------------------: |
|            [1](https://github.com/UpstageAILab)             |            [2](https://github.com/UpstageAILab)             |            [3](https://github.com/UpstageAILab)             |            [4](https://github.com/UpstageAILab)             |            [5](https://github.com/UpstageAILab)             |            [6](https://github.com/UpstageAILab)             |
|                            팀장, 담당 역할                             |                            담당 역할                             |                            담당 역할                             |                            담당 역할                             |                            담당 역할                             |                            담당 역할                             |

<br>

## 🔨 개발 환경 및 기술 스택
- 주 언어 : Python
- 버전 및 이슈관리 : GitHub / Linear
- 협업 툴 : GitHub / Linear / Notion

<br>

## 📁 프로젝트 구조
```
├── code
│   ├── jupyter_notebooks
│   │   └── model_train.ipynb
│   └── train.py
├── docs
│   ├── pdf
│   │   └── (Template) [패스트캠퍼스] Upstage AI Lab 1기_그룹 스터디 .pptx
│   └── paper
└── input
    └── data
        ├── eval
        └── train
```

<br>

## 💻​ 구현 기능
### 기능1
- 사용자 증상 입력 기반 질병 예측 기능

### 기능2
- MLflow를 통한 실험 기록 및 버전 관리

### 기능3
- Airflow 기반 자동화 파이프라인

<br>

## 🛠️ 작품 아키텍처(필수X)
- #### _아래 이미지는 예시입니다_
![이미지 설명](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*ub_u88a4MB5Uj-9Eb60VNA.jpeg)

<br>

## 🚨​ 트러블 슈팅
### 1. MLflow experiment 접근 에러

#### 설명
- 초기 Docker 내부 MLflow 호스트명이 잘못 설정되어 API 연결 오류 발생

#### 해결
- Docker Compose 내부 네트워크 설정 및 `.env` 수정으로 해결

<br>

## 📌 프로젝트 회고
### 멤버1
- 모델 개발과 동시에 MLOps 환경을 구축하면서 실제 서비스화의 중요성을 체감할 수 있었습니다.

<br>

## 📰​ 참고자료
- https://www.kaggle.com/datasets/kaushil268/disease-prediction-using-machine-learning  
- https://mlflow.org/  
- https://docs.bentoml.org/  
