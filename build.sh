#!/usr/bin/env bash

# Print the commands.
set -x

# Exit script on error.
set -e

APP_VERSION="v0.2.0"

# Use an AWS account to store the Docker image.
AWS_ACCOUNT="424432388155.dkr.ecr.us-east-2.amazonaws.com"

# Repository to store this Docker image in.
ECR_REPO="node-app"

# Set the AWS profile to push images.
AWS_PROFILE="${AWS_PROFILE:-default}"

# Retrieve an authentication token and authenticate your Docker client to your registry.
aws ecr get-login-password --region us-east-2 --profile ${AWS_PROFILE} | docker login --username AWS --password-stdin ${AWS_ACCOUNT}

# Build Docker image.
docker build -t ${AWS_ACCOUNT}/${ECR_REPO}:${APP_VERSION} --platform linux/amd64 node-app

# Push Docker image.
docker push ${AWS_ACCOUNT}/${ECR_REPO}:${APP_VERSION}
