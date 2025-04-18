# Export Scaleway credentials on your terminal


## 0. Create Scaleway personal Api Key with access to the Organization Project

Go on the IAM Panel on the Scaleway Console and create an Api on your user


## 1. Expose infrastructure required credentials on your laptop

To deploy and manage different environments, you need to expose a set of credentials on your laptop.

The credentials to expose are the various API keys needed to access services like Scaleway, Cloudflare, GitLab, etc.

Each Scaleway project has its own set of credentials.

We use direnv to expose credentials based on the current directory in the repository.

To work properly, you must create a credentials file for each Scaleway project.

An example configuration file is available under `.credentials/context.example`. Copy it to `.credentials/<your company name>.<env name>` and edit it with the newly created keys.

If you do not use direnv, don't forget to source the file corresponding to the Scaleway project you are working on.

**Notes :**
* For the organization's Scaleway project credentials: Use the previously created Scaleway Personal API Key.
* For any other project: Create an API Key in the IAM Developer Access matching app. Note that the organization must be deployed before you can complete this step.
