#!/bin/sh
curl -XPOST -H "Content-Type: application/json" http://193.205.66.173:8080/v2/apps -d @submitter.json -u admin:HTMesos
