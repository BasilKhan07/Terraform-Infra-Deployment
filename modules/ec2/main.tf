resource "aws_key_pair" "ssh-key-tf" {
  key_name   = "ssh-key-tf"
  public_key = var.public_key 
}

resource "aws_instance" "ec2instance" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  security_groups   = var.security_group_ids 
  key_name          = aws_key_pair.ssh-key-tf.key_name
  user_data         = file("${path.module}/script.sh")
}
