variable "github_provider_url" {
  type    = string
  default = "https://token.actions.githubusercontent.com"
}

variable "github_client_ids" {
  type    = list(string)
  default = ["sts.amazonaws.com"]
}

variable "github_repos" {
  type = list(string)
  default = [
    "repo:filthystinkingcasual/gggr-terraform/*",
  ]
}