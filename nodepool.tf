provider "kubernetes-alpha" {
  config_path = "/tmp/config" // path to kubeconfig
}
resource "kubernetes_manifest" "nodepool" {
  provider = kubernetes-alpha


  manifest = {
    "apiVersion" = "container.gcp.crossplane.io/v1alpha1"
    "kind"       = "NodePool"
    "metadata" = {
      "name"      = "mayastor-nodepool"
      "namespace" = "default"
    }
    "spec" = {
      "forProvider" = {
        "cluster" = "projects/steady-service-269616/locations/us-central1-c/clusters/cluster-1"
        "config" = {
          "diskSizeGb"  = 100
          "diskType"    = "pd-standard"
          "imageType"   = "UBUNTU"
          "machineType" = "n2-standard-4"
        }
        "initialNodeCount" = 2
      }
      "providerRef" = {
        "name" = "gcp-provider"
      }
      "writeConnectionSecretToRef" = {
        "name"      = "mayastor-nodepool"
        "namespace" = "default"
      }
    }
  }
}