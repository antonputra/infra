## Master replica

## AWS Certificate Manager

## Commands

```bash
terraform apply -var-file=dev.tfvars -var-file=../common.tfvars
```

1. Create Route53 PrivateHosted ZOne
2. To create EC2 instance using Terraform
   - we have 2 disks OS /
   - 20 Gb mounted /data
3. Install Postgres (manually) -> packer

   - 17.2 (latest vesion)
   - optimize it with pgtune for ec2 instance
   - systemd service files

   - postgres.antonputra.pvt

4. Create schema + tables
5. Add python endpoint

## Install PostgreSQL

```bash
sudo apt update && sudo apt -y upgrade
sudo reboot

export DATA_DISK="/dev/nvme1n1"

sudo mkdir /data
sudo mkfs.xfs ${DATA_DISK}
sudo mount -o defaults ${DATA_DISK} /data
sudo lsblk --fs
echo "/dev/disk/by-uuid/730a8acd-d12b-49e6-a99b-7e9e22e7b63f /data xfs defaults 0 1" | sudo tee -a /etc/fstab
```

```sql
--
-- Create application users.
--
CREATE USER fastapi_app WITH PASSWORD 'devops123' SUPERUSER CREATEDB CREATEROLE LOGIN;

--
-- Create device tables.
--
CREATE TABLE IF NOT EXISTS fastapi_device (id SERIAL PRIMARY KEY, uuid UUID DEFAULT NULL, mac VARCHAR(255) DEFAULT NULL, firmware VARCHAR(255) DEFAULT NULL, created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

```

```
TEMPORAL_VERSION=1.25.2
TEMPORAL_ADMINTOOLS_VERSION=1.25.2-tctl-1.18.1-cli-1.1.1
TEMPORAL_UI_VERSION=2.31.2
POSTGRESQL_VERSION=17
OPENSEARCH_VERSION=2.5.0
```

```bash
# ssh -i ~/.ssh/aws-demo.pem ubuntu@3.137.168.100


aws ssm start-session --region us-east-2 \
    --target i-0483135dee25af8c5 \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["5432"], "localPortNumber":["5432"]}'

aws ssm start-session --region us-east-2 \
    --target "ecs:dev-main_d7441b23df6c426086cb772308fc5315_b198e08e395e487aa260f601032aeb5c" \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["8080"], "localPortNumber":["8080"]}'

# SSH to EC2
aws ssm start-session --region us-east-2 --target 0894a11f2ac14ac04

# SSH to container
aws ecs execute-command \
 --region us-east-2 \
 --cluster dev-main \
 --task arn:aws:ecs:us-east-2:424432388155:task/dev-main/b0da9bfc0b894704a158972d1782ba9f \
 --container temporal \
 --command "/bin/bash" \
 --interactive

aws ecs describe-tasks \
    --cluster dev-main \
    --region us-east-2 \
    --tasks arn:aws:ecs:us-east-2:424432388155:task/dev-main/c8b394d7fea64bb88a2ee018ca106615
```

https://docs.timescale.com/self-hosted/latest/install/installation-linux/

2 options

1. Build from source code

2. Use package managers

- no compile
- apt -> create linux user
- security

EFS vs EBS

EFS is elastic
EFS

- no size limit
- you can attach this ebs to multiple EC2 instance
- more expencive
  $0.30 GB-Month

EBS

- gp3
- no sharing, only 1 instance
- size
- $0.08/GB-month

gp3
io
io1
io2 - $0.125/GB-month

EFS - common use case
Wordpress
mysql + php

ec2 -> mysql -> same EFS volume
ec2 -> php -> same EFS volume

EFS - replicate between regions for disaster recovery
EBS - backups + upload to s3 + glasier (cold much cheaper)
12 hours
1 hou

EBS (network storage)

- storage (ssd size)
- thoughtput (network)
- disk write operations

i8g.2xlarge (included)

- local ssd (1 x 1,875 GB )

cassabdra-01 2TB
cassabdra-02 2TB
cassabdra-03 2TB
cassabdra-04 2TB

<!-- cassabdra-04 2TB -->

3 types

1. Linux command -
2. TCP - nc -vz localhost:8080
3. Application/http - curl localhost/healthz

- 200
  201

Prepare:

- Frontend with application load balancer + TLS + HTTPS
- AWS certificate manager
- ecs app (nodejs) + backend = db for caching
- Packer to create Postgres
- attach data disks using user_data

AWS certificate manager -> 1 year
Lets encrypt -> 90 days, 60 renewwed

## Validate Temporal

```bash
wget https://github.com/fullstorydev/grpcurl/releases/download/v1.7.0/grpcurl_1.7.0_linux_x86_64.tar.gz && tar -xvf grpcurl_1.7.0_linux_x86_64.tar.gz && chmod +x grpcurl

./grpcurl -plaintext -d '{"service": "temporal.api.workflowservice.v1.WorkflowService"}' temporal.dev.exotic.ecs:7233 grpc.health.v1.Health/Check

./tctl --address temporal.dev.exotic.ecs:7233 cluster health
```
