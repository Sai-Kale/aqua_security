resource "aws_eks_node_group" "sre-pool-main" {
  # Name of the EKS Cluster.
  cluster_name = var.cluster-name

  # Name of the EKS Node Group.
  node_group_name = var.node1-name

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = aws_iam_role.nodes_general.arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids = aws_subnet.private_subnet[*].id 

  # Configuration block with scaling settings
  scaling_config {
    # Desired number of worker nodes.
    desired_size = var.node1_desired_size

    # Maximum number of worker nodes.
    max_size = var.node1_max_size

    # Minimum number of worker nodes.
    min_size = var.node1_min_size
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group. 
  # Valid values: ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  # Disk size in GiB for worker nodes
  disk_size = 20

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false

  # List of instance types associated with the EKS Node Group
  instance_types = ["t3.medium"]

  labels = {
    role = "sre-pool-main"
  }

  # Kubernetes version
  #version = "1.18"

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    aws_iam_instance_profile.demo-node,
  ]


}



###########################


resource "aws_eks_node_group" "sre-pool-sec" {
  # Name of the EKS Cluster.
  cluster_name = var.cluster-name

  # Name of the EKS Node Group.
  node_group_name = var.node2-name

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = aws_iam_role.nodes_general.arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids = aws_subnet.private_subnet[*].id 

  # Configuration block with scaling settings
  scaling_config {
    # Desired number of worker nodes.
    desired_size = var.node2_desired_size

    # Maximum number of worker nodes.
    max_size = var.node2_max_size

    # Minimum number of worker nodes.
    min_size = var.node2_min_size
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group. 
  # Valid values: ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  # Disk size in GiB for worker nodes
  disk_size = 20

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false

  # List of instance types associated with the EKS Node Group
  instance_types = ["t3.medium"]

  labels = {
    role = "sre-pool-sec"
  }

  # Kubernetes version
  #version = "1.18"

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

}