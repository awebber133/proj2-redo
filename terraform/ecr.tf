# ECR Repository for Python Flask App
resource "aws_ecr_repository" "app" {
  name                 = "app-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "hello-app"
  }
}

# ECR Repository Policy for Flask App
resource "aws_ecr_repository_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowPullFromEKS",
        Effect = "Allow",
        Principal = {
          AWS = aws_iam_role.eks_node_group.arn
        },
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}

# ECR Repository for Node.js App
resource "aws_ecr_repository" "node_app" {
  name                 = "node-app-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "node-app"
  }
}

# ECR Repository Policy for Node.js App
resource "aws_ecr_repository_policy" "node_app" {
  repository = aws_ecr_repository.node_app.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowPullFromEKS",
        Effect = "Allow",
        Principal = {
          AWS = aws_iam_role.eks_node_group.arn
        },
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}
