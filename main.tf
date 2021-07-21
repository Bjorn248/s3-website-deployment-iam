terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.50"
    }
  }
}

resource "aws_iam_group" "s3_static_site_deployers" {
  name = "${var.s3-bucket-name}-deployer"
}

resource "aws_iam_policy" "s3_sync_permissions" {
  name = "${var.s3-bucket-name}-sync-permissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = "*"
      },
      {
        Resource = [
          "arn:aws:s3:::${var.s3-bucket-name}",
          "arn:aws:s3:::${var.s3-bucket-name}/*"
        ],
        Effect = "Allow",
        Action = [
          "s3:DeleteObject",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ]
      }
    ]
  })

  tags = var.global-tags
}

resource "aws_iam_group_policy_attachment" "sync_attachment" {
  group      = aws_iam_group.s3_static_site_deployers.name
  policy_arn = aws_iam_policy.s3_sync_permissions.arn
}

resource "aws_iam_user" "deployer" {
  name = "${var.s3-bucket-name}-deployer"
  tags = var.global-tags
}

resource "aws_iam_user_group_membership" "deployer_membership" {
  user = aws_iam_user.deployer.name

  groups = [
    aws_iam_group.s3_static_site_deployers.name,
  ]
}
