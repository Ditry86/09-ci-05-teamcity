terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.zone
}

data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

data "yandex_compute_image" "centos7" {
  family = "centos-7"
}