#!/bin/bash
set -e

pipeline="$PWD"/pipeline
logs="$PWD"/logs

if [ "$1" == "-h" ] ; then
    echo "This will run a docker container with Logstash.
Pipeline configuration is by default loaded from the running directory + /pipeline. This can be overridden by specifying a first argument.
Updates to the config will automatically be reloaded.
   
Logs are by default read from the running directory + /logs. This can be overridden by specifying a second argument.
    
Make sure the container has read access!"
    exit 0
fi

if [ -z "$1" ] ; then
    echo "default pipeline directory: $pipeline" 
else
    pipeline=$1
fi

if [ -z "$2" ] ; then
    echo "default log directory: $logs" 
else
    logs=$2
fi

# -r specifies that pipeline configuration is automatically reloaded
docker run --rm -it -v $pipeline:/usr/share/logstash/pipeline/ -v $logs:/usr/share/logstash/logs/ docker.elastic.co/logstash/logstash-oss:6.1.0 -r
