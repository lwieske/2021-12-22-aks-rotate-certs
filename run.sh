#!/usr/bin/env bash

set -x

export LOCATION=germanywestcentral

export RESOURCE_GROUP=AZURE-AKS
export CLUSTER_NAME=AKS-ROTATECERT

az group create \
    --name ${RESOURCE_GROUP} \
    --location ${LOCATION}

sleep 20

az aks create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --node-count 1

sleep 60

az aks get-credentials \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --overwrite-existing

kubectl get nodes

cat ~/.kube/config | cut -c -80

sleep 20

az aks rotate-certs \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --yes

sleep 60

az aks get-credentials \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --overwrite-existing

kubectl get nodes

cat ~/.kube/config | cut -c -80

sleep 20

az aks delete \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --yes

sleep 20

az group delete \
    --name ${RESOURCE_GROUP} \
    --no-wait \
    --yes

sleep 20