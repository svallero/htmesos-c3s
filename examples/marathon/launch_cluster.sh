#!/bin/sh

marathon_host="193.205.66.173"
credentials="admin:HTMesos"
net="192.168.128.{0,3}"

role="master"
curl -XPOST -H "Content-Type: application/json" http://$marathon_host:8080/v2/apps -d @$role.json -u $credentials

sleep 15


master_ip=`curl http://$marathon_host:8080/v2/apps/htcondor-master  -u $credentials | grep -P -o "$net"`

#echo $master_ip

# substitute master ip in submitter and executor templates
role="submitter"
awk  -v master_ip="    \"$master_ip\"," '/"-s"/ {f=1; print; next} f {$1=master_ip; f=0} 1' ${role}.json > .${role}.json

curl -XPOST -H "Content-Type: application/json" http://$marathon_host:8080/v2/apps -d @.${role}.json -u $credentials


role="executor"
awk  -v master_ip="    \"$master_ip\"," '/"-e"/ {f=1; print; next} f {$1=master_ip; f=0} 1' ${role}.json > .${role}.json

curl -XPOST -H "Content-Type: application/json" http://$marathon_host:8080/v2/apps -d @.${role}.json -u $credentials
