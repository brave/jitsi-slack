set -e

. .env

command_exists () {
    type "$1" &> /dev/null ;
}

# sudo apt-install -y update 
# sudo apt-install -y upgrade
# sudo apt-install -y git jq 

echo "*** 1- Installing Docker & Docker Compose ***"
if command_exists docker ; then 
    echo "Docker exists"
else 
    echo "Installing Docker"
    ./install-docker.sh
fi


sleep 5

if command_exists docker-compose ; then 
    echo "Docker-Compose exists"
else 
    echo "Installing Docker-Compose"
    curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

echo "*** 2- Setting Up DynamoDB tables ***"

if aws dynamodb list-tables |  jq .TableNames | grep OAUTH ; then 
    echo "TOKENTABLE already exists"
else 
    aws dynamodb create-table --cli-input-json file://$TOKEN_TABLE_CONFIG --region $DYNAMO_REGION 
fi

if aws dynamodb list-tables |  jq .TableNames | grep SERVER ; then 
    echo "SERVER already exists"
else 
   aws dynamodb create-table --cli-input-json file://$SERVER_TABLE_CONFIG --region $DYNAMO_REGION
fi


echo "*** 3- Running Jitsi-Slack Integration ***"

docker-compose up


