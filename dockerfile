pipeline {
environment {
registry = "sahu123/nginx-http:latest"
registryCredential = 'sahu123'
dockerImage = 'nginx-http'
}
agent any
stages {
stage('Cloning our Git') {
steps {
git 'https://github.com/YourGithubAccount/YourGithubRepository.git'
}
}
stage('Building our image') {
steps{
script {
dockerImage = docker.build registry + ":$BUILD_NUMBER"
}
}
}
stage('Deploy our image') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push()
}
}
}
}
stage('Cleaning up') {
steps{
sh "docker rmi $registry:$BUILD_NUMBER"
}
}
}
}
