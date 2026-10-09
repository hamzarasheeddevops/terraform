locals {
    common_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
    source = "../../../modules/bucket"
}

include "root" {
    path = find_in_parent_folders()
}

dependency "project" {
    config_path = "../project"
    skip_outputs = true
}

dependency "workload_sa" {
    config_path = "../workload_sa"
}

inputs = {
    project_id = local.common_vars.locals.project_id
    location = local.common_vars.locals.region
    bucket_base_name = "wmc-documentstorage"
    uniform_bucket_level_access = true
    allow_public_access = false
    sa_write_permissions_emails = ["${dependency.workload_sa.outputs.documentstorage_service_account_email}"]
    group_write_permissions_emails = local.common_vars.locals.developer_group_emails
}
