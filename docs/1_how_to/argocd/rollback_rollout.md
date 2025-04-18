# How to rollback a version for a component

First [connect to Argocd](./how_to_connect_to_argocd.md)

To rollback an existent application, let's say from `v2` to `v1`, use ArgoCD.
Run `just forward-argocd` at the repository's root and navigate to `http://localhost:8080`.

Select the application and click _History and rollback_ on the top bar.
It is now possible to select the `v1` deployment and rollback to its state.

# How to rollout to a version for a component

Let's say that now a `v3` is deployed fixing the application, ArgoCD-image-updater should detect it (if enabled) and create a new deployment for this version, but not enable it.

To enable this new version, enable the ArgoCD's auto-synchronization.
To do so, navigate to the desired application, click _App details_ and scroll down.
Select _Enable auto-sync_ at the bottom of the page and take care to activate both _Prune resources_ and _Self heal_ afterward.
