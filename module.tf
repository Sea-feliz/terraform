module "network" {
  source  = "./Modules/network"
  project_name = "${var.project_name}"
}

module "infra" {
  source  = "./Modules/infra"
  //project_name = "${var.project_name}"
  subnet1_id = "${module.network.subnet1_id}"
  subnet2_id = "${module.network.subnet2_id}"
  vpc = "${module.network.vpc}"
}


