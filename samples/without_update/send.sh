#!/bin/sh
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
BODY=`cat $SCRIPTPATH/body.json`
AWS_ACCESS_KEY_ID="id" AWS_SECRET_ACCESS_KEY="secret" aws --endpoint-url http://localhost:9324 sqs send-message --queue-url http://localhost:9324/queue/default --message-body "$BODY"