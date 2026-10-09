locals {
    common_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
    gke_subnet_name = "${local.common_vars.locals.region}-gke-${local.common_vars.locals.env}"
}

terraform {
    source = "../../../modules/ar"
}

include "root" {
    path = find_in_parent_folders()
}

dependencies {
  paths = ["../project"]
}

inputs = {
    project_id = local.common_vars.locals.project_id
    location = local.common_vars.locals.region
    name = "gke"
    additional_read_only_sa_emails = local.common_vars.locals.artifact_registry.additional_read_only_sa_emails
}
