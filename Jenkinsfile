#!/usr/bin/env groovy

pipeline {
    agent {
        docker {
            image 'ruby:2.4-alpine'
            label 'docker'
        }
    }

    stages {
        stage('Build and Test') {
            steps {
                sh 'gem install bundler -n && bundle install'
                sh 'bundle exec rake'
            }
        }
    }
}
