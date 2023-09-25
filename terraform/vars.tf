variable "zone" {
    default=""
}

locals {
    
    lans = {
        default = ["192.168.10.0/24"]
    }

    instances = { 
        "teamcity-server" = {
            cores = 4,
            memory = 4
            ip_address = "192.168.10.10"
            docker_declaration = "./teamcity-server.yaml"
        },
        "teamcity-agent" = {
            cores = 2,
            memory = 4
            ip_address = "192.168.10.11"
            docker_declaration = "./teamcity-agent.yaml"
        },
    }
}

output "external_teamcity_ip_address" {
    value = {for k, v in yandex_compute_instance.test_teamcity: k => v.network_interface.0.nat_ip_address}
}

output "external_nexus_ip_address" {
    value = ["${yandex_compute_instance.test_nexus.name} = ${yandex_compute_instance.test_nexus.network_interface.0.nat_ip_address}"]
}

#output "local_ip_address" {
#    value = {for k, v in yandex_compute_instance.test_vm: k => v.network_interface.0.ip_address}
#}