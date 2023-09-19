resource "yandex_compute_instance" "test_teamcity" {
  for_each = local.instances
  name = "${each.key}"
  zone=var.zone
  resources {
    cores  = each.value.cores
    memory = each.value.memory
  } 

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.test_subnet.id
    ipv4 = true
    ip_address = each.value.ip_address
    nat = true
  }

  metadata = {
    docker-container-declaration = file("${each.value.docker_declaration}")
    user-data = file("./cloud_config.yaml")
  }
}

resource "yandex_compute_instance" "test_nexus" {
  name = "nexus"
  zone=var.zone
  resources {
    cores  = 2
    memory = 4
  } 

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos7.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.test_subnet.id
    ip_address = "192.168.10.12"
    nat = true
  }

  metadata = {
    user-data = file("./cloud_config.yaml")
  }
}