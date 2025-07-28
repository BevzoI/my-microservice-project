resource "helm_release" "aws_ebs_csi_driver" {
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  version    = "3.0.0"  
  create_namespace = false

  values = [
    yamlencode({
      enableVolumeScheduling = true
      enableVolumeResizing   = true
      enableVolumeSnapshot   = true
    })
  ]

  depends_on = [aws_eks_cluster.this]
}
