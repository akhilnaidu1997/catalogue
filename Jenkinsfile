@Library('jenkins-shared-library') _
def configmap = [
    project : "roboshop",
    components : "catalogue"
]

if (env.BRANCH_NAME.equalsIgnoreCase('main')){
    nodejsEKSpipeline(configmap)
}
else{
    echo "Please follow the CR(change release) process"
}
