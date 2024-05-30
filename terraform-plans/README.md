# Terraform plans for Solution Engineering

## Rationale

Solution engineer team use terraform to make sure the github repositories have consistent repository settings and workflow files.
The terraform init/plan/apply will run automatically on the Github action.

## Permissions

We use [Terraform Github Provider](https://registry.terraform.io/providers/integrations/github/latest/docs) to interact with Github resources. And this provider has multiple ways to to authenticate with Github API. We use Github application for authentication.

> For more details how to use Github application authentication, please check [Terraform Github Provider - Github App Installation](https://registry.terraform.io/providers/integrations/github/latest/docs#github-app-installation)

The permissions required for the github application are:

-  Read access to members and metadata
-  Read and write access to actions, actions variables, administration, checks, code, commit statuses, environments, issues, merge queues, packages, pull requests, secrets, and workflows

> This Github Application need to be installed on every repositories we want to manage. Please ask people who has Github Organization permission for help.
> 
> For how to create the github application, please check [Creating Github Apps](https://docs.github.com/en/apps/creating-github-apps)
