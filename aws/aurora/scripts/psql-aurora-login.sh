#!/bin/bash
# 
# Parse SSM/Parameter Store values for auto logins
# to Aurora PG using IAM DB User credentials
#

PROFILE="prod"
REGION="us-west-2"
SSM_PARAMETER_STORE="/jd_aurora/${PROFILE}/db_access"

RDSHOST="$(aws ssm get-parameters --names "${SSM_PARAMETER_STORE}" --profile "${PROFILE}" | jq -r '.Parameters[].Value' | awk -F, '{print $1}')"
DB_USER="$(aws ssm get-parameters --names "${SSM_PARAMETER_STORE}" --profile "${PROFILE}" | jq -r '.Parameters[].Value' | awk -F, '{print $3}')"
DB_NAME="$(aws ssm get-parameters --names "${SSM_PARAMETER_STORE}" --profile "${PROFILE}" | jq -r '.Parameters[].Value' | awk -F, '{print $4}')"
PASSWORD="$(aws rds generate-db-auth-token --hostname "${RDSHOST}" --port 5432 --region "${REGION}" --username "${DB_USER}" --profile "${PROFILE}")"

PGPASSWORD="${PASSWORD}" psql -h "${RDSHOST}" -d "${DB_NAME}" -U "${DB_USER}"
# Comment line above and Uncomment line below to perform a database 'dump' using pg_dump, then redirect output to a file_name.sql
# PGPASSWORD="${PASSWORD}" pg_dump -v -Fc -h "${RDSHOST}" -d "${DB_NAME}" -U "${DB_USER}"

# Example:
# psql-aurora-login.sh > jd_aurora-stage-db-2021-12-13.sql
