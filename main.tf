module "elasticsearch"{
    source = "./modules/elasticsearch"
}
module "prometheus"{
    source = "./modules/prometheus"
    instance_private_ip = module.elasticsearch.instance_private_ip
}

