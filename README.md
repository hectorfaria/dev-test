# Introduction

This is a test for Devsu LLC, the tools I used were Docker, GitHub Actions, NPM, eslint, minikube, metrics-server and terraform (optional)

# Deciding the Architecture 

Initially, there were 4 ways of making this test, first was kubeadm, second Kops with AWS, AWS EKS and finally Minikube

- The reason I didn't used kubeadm this was the optimal way of actually developing in production but I felt it was too complex and would take me more time between the trouble shooting and the scope of the App, for Kops I attempted in doing it with Kops but quickly figured out that this wouldn't be really much more automated that I would like it to be, lastly EKS felt like I was just skipping too much and it was basically the same as Minikube, I decided with Minikube because it was the easiest tool to showcase a small Kubernetes Cluster without charging the Kubernetes with too much information.

# The Architecture
 
 Mini kube is a single node environment where it's good enough for this demo, the architecture consists all wrapped in a namespace, where I have my Deployment, where it has a template of my desired pod, besides a Horizontal Pod Scaler, then the deployment connects to the service which is a node port, and then it will go to the Ingress Controller, where it's exposed outside Kubernetes, the following diagram explains it:
 
![imagen](https://github.com/hectorfaria/dev-test/assets/33832060/33d1907d-7dfb-454f-815a-1f2610ed0d89)

# Deciding the Pipeline

I decided to use GitHub Actions since the requirements where to host the repository in GitHub so GitHub Actions was a no brainer, there are 6 type of jobs, with an overview how it should look like:

![imagen](https://github.com/hectorfaria/dev-test/assets/33832060/69e1cacf-d33d-4e7c-a800-1b9f069843a1)

**Scan**: a simple NPM command that will scan for vulnerabilities and will stop committing if there is any.
**Lint**: a simple code formatter to show clean and concise code.
**Test** (Depends on Scan and Lint): A testing framework that will test the app if the app works properly. there will be an artifact uploaded with the results of the tests.
**Docker** (Depends on Test): Once the app is functional we will upload it to DockerHub
**Coverage** (Depends on Test): Once we did the test, we will print the coverage and it will be uploaded as an artifact with the results of the test.
**Kubernetes** (Depends on Docker): Once we upload the image to Dockerhub, we will start a copy of minikube, build the metrics, install dependencies applying the files to the cluster and confirm the Cluster works without any issue.

# Running the App

### Requiremenets:

 - Minikube
 - Kubectl
 - Docker
 - Terraform (Optional)

### Installation

Start your minikube cluster

```bash
minikube start
```

Make sure you enable addons Ingress for the ingress controller and metrics server for the horizontal podscaler

```bash
minikube addons enable ingress
```
```bash
minikube addons enable metrics-server 
```

Install the metrics-server

```bash
kubectl apply -f https://raw.githubusercontent.com/pythianarora/total-practice/master/sample-kubernetes-code/metrics-server.yaml
```

Apply the namespace

```bash
kubectl apply -f minikube/namespace.yaml
```

Apply the rest of the services


```bash
kubectl apply -f minikube/
```

Alternatively you can do it with Terraform (I tried to use TLS in Terraform it just works weird)

```bash
cd minikube/terraform
terraform init
terraform apply
```

Add your dev-test.com to your host


```bash
echo "$(minikube ip) dev-test.com" | sudo tee -a /etc/hosts
```

Alternatively with Windows (with PowerShell) I believe you can do something like this:

```bash
echo "$(minikube ip) dev-test.com" | Tee-Object > C:\Windows\System32\drivers\etc\hosts
```

You can either go to a browser (please be mindful of accepting http or accepting certificates) or try this command:

```bash
curl dev-test.com
```

Alternatively minikube can give you an port for the service:

```bash
minikube service dev-test-srv --url -n=dev-test-ns
```


# Demo Devops NodeJs

This is a simple application to be used in the technical test of DevOps.

## Getting Started

### Prerequisites

- Node.js 18.15.0

### Installation

Clone this repo.

```bash
git clone https://bitbucket.org/devsu/demo-devops-nodejs.git
```

Install dependencies.

```bash
npm i
```

### Database

The database is generated as a file in the main path when the project is first run, and its name is `dev.sqlite`.

Consider giving access permissions to the file for proper functioning.

## Usage

To run tests you can use this command.

```bash
npm run test
```

To run locally the project you can use this command.

```bash
npm run start
```

Open http://localhost:8000/api/users with your browser to see the result.

### Features

These services can perform,

#### Create User

To create a user, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "error": "error"
}
```

#### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

#### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "error": "User not found: <id>"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "errors": [
        "error"
    ]
}
```

## License

Copyright © 2023 Devsu. All rights reserved.
