output "cluster_id" {
  value = aws_eks_cluster.eks.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "node_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}
