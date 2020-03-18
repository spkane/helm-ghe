# Plugin to use private Github Enterprise repo as helm repo

License (for this plugin): MIT
Hard forked from: https://github.com/diwakar-s-maurya/helm-git

This plugin makes it possible to use a private/public repository on Github Enterprise as a helm repository also. You can keep the charts beside your code in the same repository.

## Getting Started

* **NOTE**: At the moment this script is designed for unix-style systems and expects `bash`, `curl`, `cut`, and `rev` to be available.

You must set ${HELM_GHE_HOSTNAME} to the FQDN for your Github Enterprise (GHE) server and ${HELM_GHE_TOKEN} to a valid personal access token for the GHE server at ${HELM_GHE_HOSTNAME}.

```bash
echo "HELM_GHE_TOKEN=123456" >> ~/.bashrc
echo "HELM_GHE_HOSTNAME=private_ghe.example.org" >> ~/.bashrc
source ~/.bashrc
```

Now install the plugin:

```bash
helm plugin install https://github.com/spkane/helm-ghe
```

Now add the repo:

```bash
helm repo add my-helm-charts https://private_ghe.example.org/pages/me/helm-chart
helm repo list
```

Now that you have added the repository, start using it as any other regular repository.

```bash
helm install my-helm-charts/myapplication
```
