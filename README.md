#  Dealing with more than 100 secrets on GitHub Actions using Mozilla SOPS and Azure Key Vault 

May 7, 2022

The problem we're facing with more than 100 secrets in our environment and how to we utilize implementation method and still provide acceptable security level. Lesson learn about how we manage secrets using Mozilla SOPS and Azure Key Vault on GitHub Actions deployment pipeline.

Event: Global Azure Thailand.
Demo Repo in Talk
[SOPS for Azure Key Vault Boilerplate on GitHub](https://github.com/mildronize/sops-with-azure-keyvault-secrets)

## Demo Step


1. Clone https://github.com/mildronize/sops-with-azure-keyvault-secrets
2. Modify config file `./examples/data.config.yaml`
3. Create azure key vault

    ```bash
    ./create-az-key-vault.sh ./examples/data.config.yaml
    ```
4. Encrypt secret from plain text

    ```bash
    ./encrypt.sh ./examples/data.config.yaml ./examples/data.plain.yaml > ./examples/data.enc.yaml
    ```
5. Commit & Push code
6. Release to Pipeline (GitHub Action)
    ```bash
    ./scripts/bump-and-tag-version.sh 
    ```

    It will tag version, for example:

    ```
    Tag created and pushed: "0.0.1"
    ```

    Using this version to next step
    
7. Go to GitHub Action Repo which using this project for downloading secrets. (This Project)


8. Health Check 

    ```bash
    # health check
    cd ../health-check
    node ./index.js ../terraform/deploy.json
    ```

## Destroy App Services

terraform destroy -target 'azurerm_app_service.web_api["ant"]' -target 'azurerm_app_service.web_api["cat"]' -target 'azurerm_app_service.web_api["dog"]'