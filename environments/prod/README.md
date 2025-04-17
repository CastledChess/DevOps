# Env : Prod

## How to deploy the env

In order to deploy the env, you have to setup all the following prerequisites :

- [0. Setup your laptop to work on the project](../../docs/0_setup_laptop_to_work_on_the_project.md)
- [1. Export Scaleway credentials on your terminal](../../docs/1_setup_scaleway_credentials_on_terminal.md)
- [2. Deploy base Infrastructure & core components](../../docs/2_deploy_base_infra_and_core_components.md)
- [3. How to create a token to push metrics and logs to monitoring stack](https://www.scaleway.com/en/docs/observability/cockpit/quickstart/#how-to-retrieve-your-grafana-credentials)
- [4. Deploy an app component](../../docs/3_deploy_app_component.md)


## Monitoring
c
### Overview of monitoring in place

#### Cockpit
Scaleway’s Observability Cockpit (SaaS Service) allows you to monitor your applications and their infrastructure by giving you insights and context into their behavior.
With Cockpit, you can visualize your resources’ and applications’ metrics, logs, and traces in Grafana dashboards.

The Scaleway Cockpit service includes:
  - A Grafana instance: (Url available via the console on the production environment)
  - A Prometheus instance
  - An instance of Alertamanager

### Monitoring procedures
- [How to retrieve your Grafana credentials](https://www.scaleway.com/en/docs/observability/cockpit/quickstart/#how-to-retrieve-your-grafana-credentials)


## Alerting

### Infrastructure alerts

Alerts for infrastructure resources (Kubernetes, Database, etc.) are activated and Scaleway and sent to the `infra-alerts` slack channel and by mail to the devops team members.
These alerts notify in the event of a problem with one or more components of a Scaleway service. They are managed and configured by the Scaleway alert manager and cannot be configured in fine detail.


### Application alerts

Application Alerts are setup for the following components :
- castled Laravel
, and sent to the `infra-alerts` slack channel and by mail to the devops team members.

#### castled | Laravel

Here are the active alerts for the castled Laravel component :
- Endpoint down : Check every 10 sec if the following endpoint is up https://app.castled.app
- Endpoint high Latency : Check every 10 sec if the following endpoint has big latency https://app.castled.app

These alerts are all configured in `4_apps` terraform layer


## Logging

### Logging procedures
- [How to see application logs](../../docs/1_how_to/how_to_see_application_logs.md)
