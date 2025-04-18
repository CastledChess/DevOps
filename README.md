# Scaleway Infrastructure

## Repository structure overview

- `.gitlab-ci` : Contains all the Gitlab CI / CD templates used to checks the infra code quality.
- `.kubeconfig` : Contains the different kubernetes kubeconfigs for all the infras envs. By default all the gitignored.
- `docs` : Contains all the documentation pages, images, schemas.
- `environments` : Contains, all the deployed ressources deployed for separated in one folder per envs.
- `modules` : Contains all terraform modules used in the terraform stacks.
- `stacks` : Contains all the stacks (modules assembled) needed to implement an environment
- `testing`: Contains scripts to test the infra (load test, connection to services, ...).

## Availables Environments for the infrastructure

- [Organization](./environments/organization/README.md)
- [Production](./environments/prod/README.md)
- [Mock](./environments/mock/README.md)

## Architecture extra infos

- [Backup & Restore system](./docs/0_wiki/backup.md)
- [Secret management](./docs/0_wiki/secrets.md)
- [CI / CD](./docs/0_wiki/cicd.md)

## Ops infos

### Compute / Kubernetes
- [How to connect to a Kubernetes cluster](docs/1_how_to/how_to_connect_to_kube.md)

### Database / Caching / Queuing
- [How to connect to the Mysql Database](docs/1_how_to/database/connect_mysql.md)
- [How to connect to the Postgresl Database](docs/1_how_to/database/connect_postgresql.md)
- [How to connect to a redis instance deployed on Kubernetes](docs/1_how_to/redis/connect_kube.md)
- [How to run a manual backup on Scaleway Database instance](https://www.scaleway.com/en/docs/managed-databases/postgresql-and-mysql/how-to/manage-manual-backups/)

### CI / CD
- [How to connect to ArgoCD](docs/1_how_to/argocd/connect.md)
- [How to rollback a version for a component](docs/1_how_to/argocd/rollback_rollout.md)
- [How to configure the infra CI](docs/1_how_to/how_to_configure_the_infra_ci.md)

### Migration
- [How to migrate Mysql database to Scaleway instance](docs/1_how_to/database/migrate_mysql.md)
- [How to migrate folder to S3 Scaleway Bucket](docs/1_how_to/how_to_migrate_folder_to_s3.md)
