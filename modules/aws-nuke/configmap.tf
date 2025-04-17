resource "kubernetes_config_map" "aws_nuke_config" {
  for_each = var.aws_accounts

  metadata {
    name      = "aws-nuke-config-${each.key}"
    namespace = var.namespace
  }

  depends_on = [kubernetes_namespace.aws_nuke_namespace]

  data = {
    "nuke-config.yml" = <<EOF
regions:
  - global
  - us-east-2
  - us-east-1
  - us-west-1
  - us-west-2
  - af-south-1
  - ap-east-1
  - ap-south-2
  - ap-southeast-3
  - ap-southeast-4
  - ap-south-1
  - ap-northeast-3
  - ap-northeast-2
  - ap-southeast-1
  - ap-southeast-2
  - ap-northeast-1
  - ca-central-1
  - eu-central-1
  - eu-west-1
  - eu-west-2
  - eu-south-1
  - eu-west-3
  - eu-south-2
  - eu-north-1
  - eu-central-2
  - me-south-1
  - me-central-1
  - sa-east-1

account-blocklist:
  - "000000000000"

resource-types:
  excludes:
    - IAMGroup
    - IAMGroupPolicy
    - IAMGroupPolicyAttachment
    - IAMInstanceProfile
    - IAMInstanceProfileRole
    - IAMLoginProfile
    - IAMOpenIDConnectProvider
    - IAMPolicy
    - IAMRole
    - IAMRolePolicy
    - IAMRolePolicyAttachment
    - IAMSAMLProvider
    - IAMServerCertificate
    - IAMServiceSpecificCredential
    - IAMSigningCertificate
    - IAMUser
    - IAMUserAccessKey
    - IAMUserGroupAttachment
    - IAMUserPolicy
    - IAMUserPolicyAttachment
    - IAMUserSSHPublicKey
    - IAMVirtualMFADevice

accounts:
  "${each.value.account_id}": {}
EOF
  }
}
