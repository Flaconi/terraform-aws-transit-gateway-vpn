provider "aws" {
  region              = "eu-central-1"
  allowed_account_ids = [var.allowed_account_id]
  assume_role {
    role_arn     = "arn:aws:iam::${var.allowed_account_id}:role/${var.role_to_assume}"
    session_name = "tf-vpn-module-satellite"
  }
}
