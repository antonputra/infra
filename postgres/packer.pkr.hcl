# 1. Golden or base image which is based ubuntu. Golden would monitoring or logging agents
# 2. Golden image for application

# 1. OS disk size -> 8G 95% ssh
# 2. Data disk 

packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.4"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "postgres" {
  ami_name      = "postgres-17-2-{{timestamp}}"
  instance_type = "t3.small"
  region        = "us-east-2"
  vpc_id        = "vpc-0b8910389c5ad1520"
  subnet_id     = "subnet-04648d9dcec065a59"
  source_ami    = "ami-036841078a4b68e14"
  ssh_username  = "ubuntu"
  volume_size  = 30
}

build {
  name    = "postgres"
  sources = ["source.amazon-ebs.postgres"]

  provisioner "shell" {
    environment_vars = []
    inline = [
        "sudo apt-get update",
        "sudo apt-get install -y postgresql-common",
        "yes | sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh",
        "sudo apt-get install -y postgresql-17"
    ]
  }
}

# logrotate
# install redis /var/postgres/log
# Kong 