#  Dealing with more than 100 secrets on GitHub Actions using Mozilla SOPS and Azure Key Vault 

May 7, 2022

The problem we're facing with more than 100 secrets in our environment and how to we utilize implementation method and still provide acceptable security level. Lesson learn about how we manage secrets using Mozilla SOPS and Azure Key Vault on GitHub Actions deployment pipeline.

Event: Global Azure Thailand.
Demo Repo in Talk
[SOPS for Azure Key Vault Boilerplate on GitHub](https://github.com/mildronize/sops-with-azure-keyvault-secrets)

## Demo Step

```bash
cd ./terraform
terraform apply
terraform output -json  app_service_deployment > deploy.json
dasel -r json -w yaml < deploy.json > thadaw.jobs.yml

# copy yaml to thadaw.config.yml
# copt yaml to .github/workflows/build-and-deploy.yml

# Go to Project Azure-to-github
yarn set-github-secrets -f thadaw.config.yml -m
./tmp/run-all.sh

# health check
cd ../health-check
node ./index.js ../terraform/deploy.json
```

## Destroy App Services

terraform destroy -target 'azurerm_app_service.web_api["ant"]' -target 'azurerm_app_service.web_api["cat"]' -target 'azurerm_app_service.web_api["dog"]'