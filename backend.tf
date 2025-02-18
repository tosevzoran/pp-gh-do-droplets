terraform {
  cloud {

    organization = "pp-org"

    workspaces {
      name = "pp-gh-do-droplets"
    }
  }
}
