node ('centos8') {
    // default tag to latest, only override if branch isn't master.  This
    // allows the tag to work outside of multibranch (it will just always be
    // latest in that case)
    def tag = "latest" 

    stage('checkout') {
        checkout scm
    }

    stage('build') {
      withCredentials([usernameColonPassword(credentialsId: '0f11d4d1-6557-423c-b5ae-693cc87f7b4b', variable: 'HUB_LOGIN')]) {

        // set tag to branch if it isn't master
        if (env.BRANCH_NAME != 'master') {
           tag = "${env.BRANCH_NAME}"
         }

        // build the image
	sh 'podman build --format=docker -t solr'

        // push to dockerhub (for now)
        sh "podman push --creds \"$HUB_LOGIN\" solr docker://docker.io/veupathdb/solr:${tag}"
        }
      }

    }
