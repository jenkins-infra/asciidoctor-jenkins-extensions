#!/usr/bin/env groovy

pipeline {
    agent {
        docker {
            image 'ruby:3.2.0'
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
            junit 'spec/reports/**/*.xml'
        }
    }
}
