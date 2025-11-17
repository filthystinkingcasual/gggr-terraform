import {
  to = aws_iam_openid_connect_provider.default
  id = "arn:aws:iam::070936606018:oidc-provider/token.actions.githubusercontent.com"
}

import {
  to = aws_iam_role.github_public_ecr
  id = "gha_ecr_role"
}
import {
  to = aws_iam_role_policy.github_public_ecr_policy
  id = "gha_ecr_role:gha_ecr_policy"
}