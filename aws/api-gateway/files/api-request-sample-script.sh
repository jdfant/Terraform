#!/bin/bash

region="us-west-2"
# Secondary account is the account ID used in the second 'Principal' for KMS Key policy.
secondary_account="222222222222"
key_usage="ENCRYPT_DECRYPT"
key_alias="alias/TestKey"
key_description="Test KMS Key"
api_gateway_url="https://xxxxxxxxxxxx.execute-api.us-west-2.amazonaws.com/kms_key_generator"
api_key_path="/APIGateway/APIKeys/kms-test"
api_key="$(aws ssm get-parameters --names ${api_key_path} --with-decryption --region ${region}| jq -r '.Parameters[].Value')"

curl -i -L -X POST \
  -H "x-api-key: ${api_key}" \
  "${api_gateway_url}" \
  -H "Content-Type: application/json" \
  -d "{"account": ${secondary_account}, \
  "region": ${region}, \
  "key_usage": ${key_usage}, \
  "key_alias": ${key_alias}, \
  "key_description": ${key_description}}"
