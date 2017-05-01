node("docker") {
    docker.withRegistry('', 'docker_hub_creds') {

        git url: "https://github.com/jameseck/docker-jenkins-slave", credentialsId: 'github_creds'

        sh "git rev-parse HEAD > .git/commit-id"
        def commit_id = readFile('.git/commit-id').trim()
        println commit_id

        stage "build"
        def app = docker.build "jameseckersall/jenkins-slave"

        stage "publish"
        app.push 'master'
        app.push "${commit_id}"
    }
}
