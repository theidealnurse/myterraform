#Create a resource block for the EC2 instances. This block specifies the AWS EC2 instance details such as the instance type, AMI image ID, etc. You can specify the count parameter to create multiple instances.

resource "aws_instance" "project_in1" {
  ami             = "ami-01b8d743224353ffe"
  instance_type   = "t2.micro"
  key_name        = var.ssh_key
  security_groups = [aws_security_group.project_instance_sg.id]
  subnet_id       = aws_subnet.project_subnet1.id
  availability_zone = "eu-west-2a"
  tags = {
    Name   = "project1"
    source = "terraform"
  }
}

resource "aws_instance" "project_in2" {
  ami             = "ami-01b8d743224353ffe"
  instance_type   = "t2.micro"
  key_name        = var.ssh_key
  security_groups = [aws_security_group.project_instance_sg.id]
  subnet_id       = aws_subnet.project_subnet2.id
  availability_zone = "eu-west-2b"
  tags = {
    Name   = "project2"
    source = "terraform"
  }
}

resource "aws_instance" "project_in3" {
  ami             = "ami-01b8d743224353ffe"
  instance_type   = "t2.micro"
  key_name        = var.ssh_key
  security_groups = [aws_security_group.project_instance_sg.id]
  subnet_id       = aws_subnet.project_subnet3.id
  availability_zone = "eu-west-2c"
  tags = {
    Name   = "project3"
    source = "terraform"
  }
}

# create a key pair to generate secure key in PEM and OPENSSH PEM formats
resource "tls_private_key" "project_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name = var.ssh_key
  public_key = tls_private_key.project_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  content = tls_private_key.project_key.private_key_pem
  filename = "${var.ssh_key}.pem"
  file_permission = "0400"
}

# Create a file to store the IP addresses of the instances
resource "local_file" "Ip_address" {
  filename = "home/vagrant/terraform-project/host-inventory"
  content  = <<EOT
${aws_instance.project_in1.public_ip}
${aws_instance.project_in2.public_ip}
${aws_instance.project_in3.public_ip}
  EOT
}

# automatically run your ansible playbook
resource "null_resource" "ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook --private-key ${var.ssh_key}.pem project.yml"
  }

  depends_on = [aws_instance.project_in1, aws_instance.project_in2, aws_instance.project_in3 ]
} 