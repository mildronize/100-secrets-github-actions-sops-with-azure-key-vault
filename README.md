#  Dealing with more than 100 secrets on GitHub Actions using Mozilla SOPS and Azure Key Vault 

## Global Azure Thailand 2022.

May 7, 2022

The problem we're facing with more than 100 secrets in our environment and how to we utilize implementation method and still provide acceptable security level. Lesson learn about how we manage secrets using Mozilla SOPS and Azure Key Vault on GitHub Actions deployment pipeline.

## Resources & Repo

- Article for this talk: https://thadaw.com/s/suzlta6/
- Main Repo: https://github.com/mildronize/100-secrets-github-actions-sops-with-azure-key-vault
- SOPS Secrets for Azure Key Vault Template: https://github.com/mildronize/sops-with-azure-keyvault-secrets
- SOPS Actions for Azure Key Vault: https://github.com/mildronize/actions-get-secret-sops
- Slides: https://docs.google.com/presentation/d/1PTlPazHr-e8Hehd9GBjLG0SseBPVZAMDxzrjbkOoXXY/edit?usp=sharing
- Recording Demo: https://youtu.be/KV5mZ3xtuSA

## Demo Step

1. Create template from https://github.com/mildronize/sops-with-azure-keyvault-secrets to `mildronize/my-private-repo-secrets`
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