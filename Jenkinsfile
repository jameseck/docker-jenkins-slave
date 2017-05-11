#!/usr/bin/env groovy
node("docker") {
sh "env"
  docker.withRegistry('', 'docker_hub_creds') {

/*    git url: "https://github.com/jameseck/docker-jenkins-slave", credentialsId: 'github_creds' */
    stage("checkout") {
      sh "env"
      /* checkout scm */
      git url: "https://github.com/jameseck/docker-jenkins-slave", credentialsId: 'github_creds'

      BRANCH_NAME = sh ( script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()

      COMMIT_ID = sh ( script: 'git rev-parse HEAD', returnStdout: true).trim()
      println "commit_id: $COMMIT_ID"
      println "BRANCH_NAME: $BRANCH_NAME"
    }

    stage("build") {
      def app = docker.build "jameseckersall/jenkins-slave"

      stage("publish") {
        if (env.BRANCH_NAME.equals('master')) {
          app.push 'latest'
        }
        app.push "${COMMIT_ID}"
      }
    }
  }
}
