#!/bin/bash
unset TF_LOG
unset TF_LOG_PATH
export TF_LOG="TRACE"
export TF_LOG_PATH="terraform.log"

echo $TF_LOG
echo $TF_LOG_PATH
