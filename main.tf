module "myvpc" {
  source              = "./modules/vpc"
  region              = var.region
  vpc_cidr_block      = var.vpc_cidr_block
  access_key          = var.access_key
  secret_key          = var.secret_key
  public1_cidr_block  = var.public1_cidr_block
  public2_cidr_block  = var.public2_cidr_block
  private1_cidr_block = var.private1_cidr_block
  private2_cidr_block = var.private2_cidr_block
  public1_az          = var.public1_az
  public2_az          = var.public2_az
  private1_az         = var.private1_az
  private2_az         = var.private2_az
}

module "mysecuritygroup" {
  source = "./modules/sg"
  vpc_id = module.myvpc.vpc_id
}

module "myec2instance" {
  source             = "./modules/ec2"
  public_key         = var.ssh_key_tf
  ami                = var.ami
  instance_type      = var.instance_type
  subnet_id          = module.myvpc.public1_id
  security_group_ids = [module.mysecuritygroup.sg_id]
}
