[![CircleCI](https://circleci.com/gh/shikhas-git/devops.svg?style=svg)](https://circleci.com/gh/shikhas-git/devops)

Project Summary
---------------------
This project is operationalizing a Machine Learning Microservice API. First, docker image is built for the application (app.py file) using docker. This docker image is then uploaded to DockerHub. 
From DocekrHub, this image can be utilized by Kubernetes to deploy it to the cluster. The application is deployed in kubernetes pod and exposed to the outside world using port forwarding mechanism.
The application file app.py  serves predictions about housing prices through API calls. 

Instructions to run python scripts and webapp
----------------------------------------------------
Environment 
- Create AWS cloud9 environment and clone the repository to run this project.
- Dependencies and DockerFile can be tested by running circleci build at https://app.circleci.com/pipelines/github/shikhas-git/devops
- Create a virtual environment using python3 -m venv ~/.devops and activate it using source ~/.devops/bin/activate
- Start minikube using minikube start

1. Python scripts can be run using make file. All Python dependencies should be listed in make file and 'make install' can be run from within virtual environment. 
2. Lint python files and docker files using make lint
3. To run webapp image, run  ./run_docker.sh and then run ./make_predictions.sh in separate terminal. Check output in first terminal.
4. To run webapp in container, run ./run_kubernetes.sh and then run ./make_predictions.sh in separate terminal. Check output in second terminal

Summary of Files in repository
--------------------------------------------------------
1. requirements.txt - lists package dependencies for python and app.py
2. Makefile - used to run make install, make lint etc.
3. resize.sh - used to increase the partition size to run docker image
4. run_docker.sh - creates docker image. The image name will be the tag name in the docker file i.e. demopred
	- Dockerfile will copy app.py, install all dependencies listed in requirements.txt file and expose port 80 where the app is running.
	- The script will build docjer image using --tag=demopred. Built images can be checked using docker image ls command
	- docker run -p 8090:80 will expose the app at port 8090
5. upload_docker.sh - uploads docker image to DockerHub
	- Authenticates DockerHub credentials and pushes the image using docker push command.
6. run_kubernetes.sh  - runs the image in Kubernetes cluster.
	- minikube kubectl create deployment command creates deployment wotj name demopredict-app
	- minikube kubectl -- get pods can be used to check pods in 'Running' state
	- minikube kubectl -- expose deployment/demopredict-app --type="NodePort" --port 8090 exposes the app as service 
	- minikube kubectl -- port-forward pod/$POD_NAME 8090:80 application requests are handled at port 8090
7. Run ./make_prediction.sh to send input data to docker image in kubernetes pod and receive house pricing predictions.
8. .circleci/config.yml - to automate make install and make lint using continuous integration with github.

