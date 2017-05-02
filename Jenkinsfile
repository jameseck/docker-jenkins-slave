#!/usr/bin/env groovy
node("docker") {
 sh 'env > env.txt'
    readFile('env.txt').split("\r?\n").each {
        println it
    }
  docker.withRegistry('', 'docker_hub_creds') {

/*    git url: "https://github.com/jameseck/docker-jenkins-slave", credentialsId: 'github_creds' */
    stage("checkout") {
      sh "env"
      /* checkout scm */
      git url: "https://github.com/jameseck/docker-jenkins-slave", credentialsId: 'github_creds'

      BRANCH_NAME = sh ( script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()

      sh "git rev-parse HEAD > .git/commit-id"
      def commit_id = readFile('.git/commit-id').trim()
      println "commit_id: $commit_id"
      println "BRANCH_NAME: $BRANCH_NAME"
    }

    stage("build") {
      def app = docker.build "jameseckersall/jenkins-slave"

      stage("publish") {
        if (env.BRANCH_NAME.equals('master')) {
          app.push 'latest'
        }
        app.push "${commit_id}"
      }
    }
  }
}
