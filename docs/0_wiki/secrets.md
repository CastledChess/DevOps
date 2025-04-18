# Secret Managment

## Introduction

All secrets are stored and must be stored in the Scaleway Secret Manager

In Scaleway each environment has their own Project.

Secrets must be placed on good Scaleway Project (Example : Production secret -> Scaleway Production Project)


## Use secrets in Kubernetes

External Secret is installed on each Kubernetes cluster. To inject Secret data in Kubernetes you must define an External Secret in the App Helm Chart pointing to the Scaleway Secret Manager Secret Id of the Secret
