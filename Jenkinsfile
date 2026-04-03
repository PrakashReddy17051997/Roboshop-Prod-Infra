pipeline {
    agent {
        node {
            label 'agent-1'
        }
    }
    options {
        timeout(time: 1, unit:'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    // parameters{
    //     choice(name: 'action', choices: ['apply', 'destroy'], description: 'Pick your choice')
    // }
    stages {
        stage('vpc-creation') {
            steps {
                sh """
                    cd 01-vpc-creation
                    terraform init -reconfigure
                    terraform plan
                    terraform apply -auto-approve
                    """
            }
        }
        stage('security-groups') {
            steps {
                sh """
                    cd 02-security-groups
                    terraform init -reconfigure
                    terraform plan
                    terraform apply -auto-approve
                    """
            }
        }
         stage('VPN-setup') {
            steps {
                sh """
                    cd 03-VPN-setup
                    terraform init -reconfigure
                    terraform plan
                    terraform apply -auto-approve
                    """
            }
        }
        stage('Databses and ALB'){
            parallel{
                stage('databases') {
                    steps {
                        sh """
                            cd 04-databases
                            terraform init -reconfigure
                            terraform plan
                            terraform apply -auto-approve
                        """
                    }
                }
                stage('Automatic Load BAlancer') {
                    steps {
                        sh """
                            cd 05-App-alb
                            terraform init -reconfigure
                            terraform plan
                            terraform apply -auto-approve
                        """
                    }
            }
        }
        
        }
    }
    // post build
    post {
        always{
            echo 'We Will always Win again!'
        }
        failure {
            echo 'failure occured, inform the concerned teams over slack'
        }
        success {
            echo 'Confragulations on success build'
        }
    }
}

