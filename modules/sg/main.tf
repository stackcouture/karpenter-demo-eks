resource "aws_security_group" "node_sg" {
  name   = "${var.cluster_name}-node-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-node-sg"
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  name   = "${var.cluster_name}-sg"
  vpc_id = var.vpc_id

  tags = {
    Name                     = "${var.cluster_name}-sg"
    "karpenter.sh/discovery" = var.cluster_name
  }
}

resource "aws_security_group" "vpce_sg" {
  name   = "${var.cluster_name}-vpce-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-vpce-sg"
  }
}

resource "aws_security_group_rule" "node_to_node" {
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.node_sg.id
  self              = true
}

resource "aws_security_group_rule" "cluster_to_node_kubelet" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_security_group_rule" "cluster_to_node_ephemeral" {
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_security_group_rule" "node_to_cluster_api" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.node_sg.id
}

resource "aws_security_group_rule" "node_to_vpce_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vpce_sg.id
  source_security_group_id = aws_security_group.node_sg.id
}
