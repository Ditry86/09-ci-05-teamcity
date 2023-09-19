resource "yandex_vpc_network" "netology_net" {
}

resource "yandex_vpc_subnet" "test_subnet" {
  name           = "test_subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.netology_net.id
  v4_cidr_blocks = local.lans.default
}