pipeline {
environment {
registry = "sahu123/my_image:3"
registryCredential = 'dockerhub'
dockerImage = 'my_image'
}
agent any
stages {
stage('Cloning our Git') {
steps {
git 'https://github.com/biswa123642/dockerfile.git'
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
