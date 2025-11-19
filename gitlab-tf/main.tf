terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}

variable "admin_token" {
  description = "Owner/Maintainer PAT token with the api scope applied."
  type        = string
  sensitive = true
}

provider "gitlab" {
  token    = var.admin_token
  base_url = "http://gitlab.k3d.localhost" # change this if you are on a self-hosted GitLab instance. /api/v4
  insecure = true
}

resource "gitlab_group" "example" {
  name        = "example"
  path        = "example"
  description = "An example group"
}

# Create a project in the example group
resource "gitlab_project" "example" {
  name         = "example"
  description  = "An example project"
  namespace_id = gitlab_group.example.id
}


