[![CircleCI](https://dl.circleci.com/status-badge/img/gh/DevOpsHiker42/ML_Kubernetes/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/DevOpsHiker42/ML_Kubernetes/tree/master)  on branch: master

## Project Summary
This project demonstrates the operationalization of a machine learning microservice using [kubernetes](https://kubernetes.io/).
The microservice (written in Python Flask) runs a pre-trained ``sklearn`` model (see [https://www.kaggle.com/c/boston-housing](https://www.kaggle.com/c/boston-housing)) that predicts housing prices in Boston according to several features, such as average rooms in a home, highway access data, teacher-to-pupil ratios etc. Predictions are issued in response to API calls.

## How to Run the Web App

### 1. Run in Standalone Python
* Run `make setup` to create and activate a Python virtual environment: ~/.devops
* Run `make install` to install the necessary dependencies
* Run the app using `python app.py`
* Stop the app when you are done, using `ctrl-c`

The app needs to be run using Python 3.7
On a system with multiple Python versions installed, it may be necessary to modify Makefile (see example in ``Makefile_Python3.7.txt``), and run the app using `python3.7 app.py`

To make a prediction (the app must be running), run the following in a separate terminal window:

`./make_prediction.sh 80`

Note that port 80 is specified to the script via an optional command line argument - without this, the script defaults to port 8000.

### 2. Run in Docker
* Make sure that Docker is running
* Run `./run_docker.sh`
* Stop the app when you are done, using `ctrl-c`

To make a prediction, run the following in a separate terminal window:

`./make_prediction.sh`

### 3. Run in Kubernetes using minikube
* Make sure that Docker is running
* Start a local minikube cluster *e.g.* using `minikube start`
* Run `./run_kubernetes.sh`
* Once the cluster is up and running, you will see information about the running pod and app *e.g.*

<pre style="margin-left: 50px;">
pod/boston-housing created
NAME             READY   STATUS              RESTARTS   AGE
boston-housing   0/1     ContainerCreating   0          0s
pod/boston-housing condition met
Forwarding from 127.0.0.1:8000 -> 80
Forwarding from [::1]:8000 -> 80
</pre>

* Stop the app when you are done, using `ctrl-c`

To make a prediction, run the following in a separate terminal window:

`./make_prediction.sh`

To see the output (STDOUT) from the pod, you'll need to use the following command: `kubectl logs boston-housing`

When you are finished with the minikube cluster, clean up *e.g.* using `minikube delete`.

## Overview of Repository Files

| **Subdirectory** | **File**                         | **Description**                                                 |
|------------------|----------------------------------|-----------------------------------------------------------------|
|                  | Dockerfile                       | Template file containing instructions for building Docker image |
|                  | Makefile                         | File containing instructions for UNIX ``make`` utility          |
|                  | Makefile_Python3.7.txt           | Example of how to specify Python3.7 in Makefile                 |
|                  | README.md                        | *This file*                                                     |
|                  | app.py                           | Python Flask application for running model                      |
|                  | make_prediction.sh               | BASH script for issuing API call to request a prediction        |
|                  | requirements.txt                 | List of Python dependencies required by app.py                  |
|                  | run_docker.sh                    | Script for running app.py via Docker                            |
|                  | run_kubernetes.sh                | Script for running app.py via Kubernetes (minikube)             |
|                  | upload_docker.sh                 | Script for uploading Docker image to Docker Hub                 |
| .circleci        | config.yml                       | CircleCI configuration (YAML) file                              |
| model_data       | boston_housing_prediction.joblib | *Model data*                                                    |
| model_data       | housing.csv                      | *Model data*                                                    |
| output_txt_files | docker_out.txt                   | Sample output from running app.py via Docker                    |
| output_txt_files | kubernetes_out.txt               | Sample output from running app.py via Kubernetes (minikube)     |

<End of README>
