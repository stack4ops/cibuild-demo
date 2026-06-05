## cibuild-demo

## Platform images

### Verification

## Release Image Index

### Verification

`cosign verify --certificate-identity-regexp ".*" --certificate-oidc-issuer "https://token.actions.githubusercontent.com" ghcr.io/stack4ops/cibuild-demo:web-workflow`

### Inspect Signature

`cosign download signature ghcr.io/stack4ops/cibuild-demo:web-workflow | jq`

copy `logIndex` from json and set url in browser: `https://search.sigstore.dev/?logIndex=LOGINDEX`