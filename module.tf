module "network" {
  source = "./module/network/"
}

module "infra" {
  source = "./module/infra/"
  subnet1_id = "${module.network.subnet1_id}"
  subnet2_id = "${module.network.subnet2_id}"
  security_group1 = "${module.network.security_group1}"
  security_group2 = "${module.network.security_group2}"
}
