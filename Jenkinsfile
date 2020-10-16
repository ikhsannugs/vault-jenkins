def secrets = [
  [path: 'kv/secret/jenkins/harbor', engineVersion: 2, secretValues: [
    [envVar: 'USER_HARBOR', vaultKey: 'username'],
    [envVar: 'PASS_HARBOR', vaultKey: 'password']]],
  [path: 'kv/secret/jenkins/tkgi', engineVersion: 2, secretValues: [
    [envVar: 'USER_TKGI', vaultKey: 'username'],
    [envVar: 'PASS_TKGI', vaultKey: 'password']]],
]
def configuration = [vaultUrl: 'http://IP_VAULT:8200',  vaultCredentialId: 'vault-token', engineVersion: 2]

pipeline {
  agent any 
  stages {
      stage('Checkout SCM') {
        steps{
          checkout scm
        }
      }
      stage('Build Docker') {
        steps{
          script {
            sh "ls; git --version"
          }
        }
      }
      stage('Push Docker') {
        steps{
          withVault([configuration: configuration, vaultSecrets: secrets]) {
            sh "docker login https://URL_HARBOR --username ${USER_HARBOR} --password ${PASS_HARBOR}"
            echo "Push yang ${BUILD_NUMBER} ke docker hahahahahahaha"
          }
        } 
      }
      stage('Deploy') {
        steps{
          withVault([configuration: configuration, vaultSecrets: secrets]) {
            sh "tkgi login -a URL_TKGI -u ${USER_TKGI} -k -p ${PASS_TKGI}"
          }
        }
      }
  }
  post {
    always {
      cleanWs deleteDirs: true
    }
  }
}
