jslay.net Website

# Install

```bash
helm upgrade --install --wait jslay-net \
  --namespace jslay-net --create-namespace \
  -f overrides.yaml oci://ghcr.io/cfpb/static-site
```
