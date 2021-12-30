---
marp: true
---

<!-- _class: invert -->

## Rotate Certificates In AKS

* Azure Kubernetes Service (AKS) uses certificates for authentication with many
  of its components. Periodically, you may need to rotate those certificates for
  security or policy reasons. For example, you may have a policy to rotate all
  your certificates every 90 days.

---

## AKS Certificates, Certificate Authorities, and Service Accounts

* AKS generates and uses the following certificates, Certificate Authorities,
  and Service Accounts:

* The AKS API server creates a Certificate Authority (CA) called the Cluster CA.

* The API server has a Cluster CA, which signs certificates for one-way
  communication from the API server to kubelets.

* Each kubelet also creates a Certificate Signing Request (CSR), which is signed
  by the Cluster CA, for communication from the kubelet to the API server.

---

## AKS Certificates, Certificate Authorities, and Service Accounts (II)

* The API aggregator uses the Cluster CA to issue certificates for communication
  with other APIs. The API aggregator can also have its own CA for issuing those
  certificates, but it currently uses the Cluster CA.

* Each node uses a Service Account (SA) token, which is signed by the Cluster
  CA.

* The kubectl client has a certificate for communicating with the AKS cluster.

---

## Certificate Auto Rotation

* Azure Kubernetes Service will automatically rotate non-ca certificates on both
  the control plane and agent nodes before they expire with no downtime for the
  cluster.
* For AKS to automatically rotate non-CA certificates, the cluster must have TLS
  Bootstrapping.

---

## Rotate Cluster Certificates

* Rotating your certificates using az aks rotate-certs will recreate all of your
  nodes and their OS Disks and can cause up to 30 minutes of downtime for your
  AKS cluster.

* Use az aks get-credentials to sign in to your AKS cluster. This command also
  downloads and configures the kubectl client certificate on your local machine.
