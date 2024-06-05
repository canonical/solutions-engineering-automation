# How to Create a Test Environment for Terraform Automation

## Overview

To set up a personal testing environment, you will need:

- A GitHub organization
- A GitHub application
- A Terraform automation repository to run Terraform on GitHub Actions
- Multiple repositories for testing

## Step 1: Create a New GitHub Organization

### Step 1.1: Follow Official Documentation

Create a new organization by following the official guide: [Creating a new organization from scratch](https://docs.github.com/en/organizations/collaborating-with-groups-in-organizations/creating-a-new-organization-from-scratch).

### Step 1.2: Create Teams in the Organization

Manually create the following GitHub Teams:

- `soleng-admin`
- `soleng-reviewers`
- `solutions-engineering`

## Step 2: Create Repositories for Testing

### Step 2.1: Create Testing Repositories

Create repositories under the organization for testing purposes.

### Step 2.2: Create Branch Protection Rules

Manually create branch protection rules. Ensure that rules for the `main` branch and other required branches are set up.

## Step 3: Create a New GitHub Application

### Step 3.1: Create GitHub Application

Follow the official guide [Registering a GitHub App](https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app) to create a new GitHub Application under the organization created in Step 1.

> You will need to generate a private key to install the GitHub Application later. Save the `.pem` file provided by GitHub for later use.

### Step 3.2: Configure GitHub Application's Permissions

Set the following permissions for the GitHub Application:

- **Repository permissions**
  - Actions (read and write)
  - Administration (read and write)
  - Checks (read and write)
  - Commit statuses (read and write)
  - Contents (read and write)
  - Environments (read and write)
  - Issues (read and write)
  - Merge queues (read and write)
  - Metadata (read-only)
  - Packages (read and write)
  - Pull requests (read and write)
  - Secrets (read and write)
  - Workflows (read and write)
- **Organization permissions**
  - Members (read-only)

### Step 3.3: Install GitHub Application

Follow these steps:

- Follow [Installing your own GitHub App](https://docs.github.com/en/apps/creating-github-apps/installing-a-github-app-from-your-personal-account) to install the application for your organization.
- Change the **Repository access** to give the GitHub Application access to your repositories.

> Follow [Authorizing GitHub Apps](https://docs.github.com/en/apps/using-github-apps/authorizing-github-apps#difference-between-authorization-and-installation) to grant the application permission to access the organization and repository resources.

## Step 4: Create Terraform Automation Repository

### Step 4.1: Create a new Terraform automation repository

- Create a new Terraform automation repository under the testing organization. So you can verify github action is working by submit a PR to this repository.
- Copy files from *solutions-engineering-automation repository*
    - Copy the `terraform-plans` folder.
    - Copy the `./github/workflows/terraform-apply.yaml` file.

### Step 4.2: Add GitHub App Secrets

Add the following secrets to the repository:

- `SOLENG_APP_ID`: Find your app's ID on the settings page for your GitHub App.
- `SOLENG_APP_INSTALLATION_ID`: Follow [this Stack Overflow guide](https://stackoverflow.com/questions/74462420/where-can-we-find-github-apps-installation-id) to find your GitHub Application installation ID.
- `SOLENG_APP_PEM_FILE`: Use the `.pem` file provided by GitHub when you generated the private key for the GitHub Application.

These secrets will allow Terraform to access the GitHub Application. Permissions will be provided to the GitHub provider on the CI.

### Step 4.3: Update Configuration Files

Update the `.tfvars` files for your testing repositories and add them to `./.github/workflows/terraform-apply.yaml`.

> You may need to delete real repositories' `.tfvars` files and remove them from `terraform-apply.yaml` since this is just a test environment and you might not have the same repository names.

## Step 5: Run Locally (Optional)

If you prefer to verify things locally instead of on the CI, you can do so.

> Verify on the CI means you have to create a PR to the new testing terraform automation repository, which we created on step4 and check the github action output.

### Step 5.1: Install Terraform

Install Terraform using snap:

```sh
sudo snap install terraform --classic
```

### Step 5.2: Set Up GitHub Application Authentication

Set the following environment variables:

```sh
export GITHUB_APP_ID="your app id"
export GITHUB_APP_INSTALLATION_ID="your app installation id"
export GITHUB_APP_PEM_FILE="$(cat ~/your-pem-file)"
```

### Step 5.3: Execute Terraform Commands

Navigate to the `terraform-plans` directory and run the following commands:

```sh
# Remove .tfstate file first
cd ./terraform-plans
terraform init
terraform validate
# Replace <YOUR_TESTING_REPO> to real file path
terraform plan -var-file=configs/github.tfvars -var-file=configs/<YOUR_TESTING_REPO>.tfvars -out ./tf.plan
terraform apply ./tf.plan
```
