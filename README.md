# Deploy Multiple Azure App Services using GitHub Actions Matrix
Deploy Multiple Azure App Services using GitHub Actions Matrix

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