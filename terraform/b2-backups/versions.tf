terraform {
  required_version = ">= 1.5"

  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "~> 0.13"
    }
  }
}

provider "b2" {}
