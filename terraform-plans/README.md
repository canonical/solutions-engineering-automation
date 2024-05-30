# Terraform plans for Solution Engineering

Currently these plans are only for setting GitHub repos and to add workflow files.

## How to start

1. Initialize Terraform.

```bash
terraform init
```

1. [Optional] If it's used locally for multiple repos. Create a workspace for each repo, otherwise terraform will try to overwrite the existing resource, e.g. repo.

```bash
terraform workspace new <repo-name>
```

1. Set GitHub authenetication for GitHub application.
```bash
export GITHUB_APP_ID="1234"
export GITHUB_APP_INSTALLATION_ID="56789"
export GITHUB_APP_PEM_FILE=$(cat ./my-app.private-key.pem)
```

1. [Optional] Create custom configuration or use one of defined in config directory.

```tfvars
owner      = "<owner/org name>"
repository = "<repo name>"
branch     = "main"
workflow_files = {
  jira_sync_config = {
    source      = "./files/workflows/jira_sync_config.yaml"
    destination = ".github/workflows/jira_sync_config.yaml"
  }
  codeowners = {
    source      = "./files/workflows/CODEOWNERS"
    destination = ".github/CODEOWNERS"
  }
}
```

1. Generate Terraform plan to validate it.

```bash
terraform plan -var-file=configs/github.tfvars -var-file=configs/soleng-tf-test-repo.tfvars
```
