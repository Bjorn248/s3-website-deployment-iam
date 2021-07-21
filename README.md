# s3-website-deployment-iam
Terraform module that creates an IAM user, IAM group, and permissions required to deploy
and sync to an S3 bucket hosting a website

## Behavior
This terraform module creates the following resources:

* 1 IAM Group
* 1 IAM Policy
* 1 IAM User

## Pre-Requisites
* An S3 bucket exists that you wish to deploy to

## Usage

```
module "s3-website-deployment-iam" {
  source = "github.com/Bjorn248/s3-website-deployment-iam"

  s3-bucket-name = BUCKET_NAME_HERE

  global-tags = {
    project = "PROJECT_NAME_HERE"
  }
}
```

## Inputs

| Name           | Description                                                    | Type   | Default   | Required   |
| ------         | -------------                                                  | :----: | :-------: | :--------: |
| s3-bucket-name | The S3 bucket to grant permissions to                          | string | -         | yes        |
| global-tags    | A map of tags to apply to all resources created by this module | map    | -         | no         |
