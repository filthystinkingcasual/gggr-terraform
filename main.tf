
resource "aws_iam_openid_connect_provider" "default" {
  url = var.github_provider_url

  client_id_list = var.github_client_ids
}

data "aws_iam_policy_document" "github_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:filthystinkingcasual/*",
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com",
      ]
    }
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.default.arn]
    }
  }
}

data "aws_iam_policy_document" "gha_ecr_public_role_policy" {
  statement {
    actions = [
      "ecr-public:BatchCheckLayerAvailability",
      "ecr-public:CompleteLayerUpload",
      "ecr-public:InitiateLayerUpload",
      "ecr-public:PutImage",
      "ecr-public:UploadLayerPart",
      "ecr-public:Describe*",
      "ecr-public:GetAuthorizationToken"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}


resource "aws_iam_role" "github_public_ecr" {
  name               = "gha_ecr_role"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role_policy.json
}

resource "aws_iam_role_policy" "github_public_ecr_policy" {
  name   = "gha_ecr_policy"
  role   = aws_iam_role.github_public_ecr.id
  policy = data.aws_iam_policy_document.gha_ecr_public_role_policy.json
}

resource "aws_ecrpublic_repository" "gogogadget" {

  repository_name = "gogogadget"

}