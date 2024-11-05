#!/usr/bin/env groovy

pipeline {
    agent {
        docker {
            image 'ruby:3.3.5'
            label 'docker&&linux'
        }
    }

    stages {
        stage('Build and Test') {
            steps {
                sh 'gem install bundler -N && bundle install'
                sh 'bundle exec rake'
            }
        }
    }

    post {
        always {
            archiveArtifacts('pkg/*.gem')
        }
    }
}
