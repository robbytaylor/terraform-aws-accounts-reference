# Terraform AWS Accounts Reference

## Requirements

* *Terraform >= 0.12
* [Terragrunt](https://github.com/gruntwork-io/terragrunt)
* [jq](https://stedolan.github.io/jq/)

## Introduction

Read the introductory post for this repository [on Medium](https://medium.com/@robbytaylor/how-i-manage-my-aws-accounts-with-terraform-f52c63dd2aa)

This repo contains a simple Terraform reference configuration for managing multiple AWS accounts as part of an AWS Organization.

You can either use this Terraform to create a new AWS environment or apply it to an existing environment by importing resources (Organization, accounts, etc.) into the Terraform state.


This code isn't intended to be run as-is, but should instead serve as a reference which you can build on and adapt to your own needs.
In particular, you would need to update any S3 bucket names before being able to run this code.

There are multiple parts to this Terraform, designed to be applied seperately.

## Bootstrap

The Terraform in the `bootstrap` directory creates the required resources for running Terraform:

* S3 bucket for storing Terraform state for the other directories
* DynamoDB table for Terraform state locking
* IAM group for admin users (optional)
* IAM users for admins (optional)

The IAM group and users are optional but recommened if you're starting with a fresh account.
In that case you should create an IAM group and user for yourself and run the remaining Terraform as that user.

You should apply this Terraform to your root account.

The `bootstrap` Terraform state is stored locally.
This is fine, you'll only be running it once.
After applying the Terraform you should commit this state file to source control but note that this is the only part of the Terraform which will store state locally.


## Account creation

The Terraform in the `accounts/-creation` directory should also be applied to the root account.

This will create an AWS organization and your AWS accounts.
An account will be created for each directory with the `accounts` directory which doesn't start with a hyphen.
You can specify additional account names with the `account_names` variable.

After creating accounts it will create IAM permissions to allow the `Admin` group (created as part of the `bootstrap` process)
to assume a role in the child accounts.

The bucket policy for the Terraform state bucket is also updated to allow the `Admin` role in child-accounts to write to a state file for that account.


## Account specific Terraform

The `accounts/-root`, `accounts/production`, and `accounts/staging` directories contain account specific resources.
These configurations should be applied against their respective accounts.

For the `production` and `staging` accounts an example S3 bucket is created.

For the root account there's an example of creating a Route53 hosted zone and delegating a subdomain to a child account.
