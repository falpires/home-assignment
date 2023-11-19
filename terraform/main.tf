## BACKEND

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

## PROVIDER

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "minikube"
}

## Apply my .yaml file

locals {
  #manifests = yamldecode(file("${path.module}/../kubernetes/app.yaml"))

  manifests = {
    for value in  [
      for yaml in split(
        "\n---\n",
        "\n${replace(file("${path.module}/../kubernetes/app.yaml"), "/(?m)^---[[:blank:]]*(#.*)?$/", "---")}\n" # This is used to match multi document yaml files (Lines that start with ---) and is written to ignore comments too
      ) :
      yamldecode(yaml)
      if trimspace(replace(yaml, "/(?m)(^[[:blank:]]*(#.*)?$)+/", "")) != "" # This is to avoid trying to get a empty document, or document with only comments
    ] : "${value["kind"]}--${value["metadata"]["name"]}" => value # This is the key of the map
  }
}

resource "kubernetes_manifest" "app" {
  for_each = local.manifests

  manifest = each.value
}
