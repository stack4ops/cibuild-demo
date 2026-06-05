## cibuild-demo

Reference build repo for cibuild libs, see full documentation: https://github.com/stack4ops/cibuild

## Platform image - amd64

### Verification 

```sh
DIGEST=$(jq -r .image_digest artifact-lock.linux-amd64.json)
cosign verify --private-infrastructure --key cosign.pub ghcr.io/stack4ops/cibuild-demo@"$DIGEST"
```

### SBOM

```sh
# CycloneDX SBOM with regctl
SBOM=$(jq -r .referrers.sbom artifact-lock.linux-amd64.json)
regctl artifact get ghcr.io/stack4ops/cibuild-demo@"$SBOM"
```

or

```sh
# CycloneDX SBOM  with oras
SBOM=$(jq -r .referrers.sbom artifact-lock.linux-amd64.json)
oras blob fetch --output - ghcr.io/stack4ops/cibuild-demo@"$(
  oras manifest fetch ghcr.io/stack4ops/cibuild-demo@"$SBOM" | jq -r '.layers[0].digest'
)" | jq .
```

### Provenance

```sh
# SLSA provenance with regctl
PROVENANCE=$(jq -r .referrers.provenance artifact-lock.linux-amd64.json)
regctl artifact get ghcr.io/stack4ops/cibuild-demo@"$PROVENANCE"
```

or

```sh
# SLSA provenance  with oras
PROVENANCE=$(jq -r .referrers.provenance artifact-lock.linux-amd64.json)
oras blob fetch --output - ghcr.io/stack4ops/cibuild-demo@"$(
  oras manifest fetch ghcr.io/stack4ops/cibuild-demo@"$PROVENANCE" | jq -r '.layers[0].digest'
)" | jq .
```

### Vulnerability

```sh
# CVE vulnerability report with regctl
VULN=$(jq -r .referrers.vuln artifact-lock.linux-amd64.json)
regctl artifact get ghcr.io/stack4ops/cibuild-demo@"$VULN"
```

or

```sh
# vulnerability report with oras
VULN=$(jq -r .referrers.vuln artifact-lock.linux-amd64.json)
oras blob fetch --output - ghcr.io/stack4ops/cibuild-demo@"$(
  oras manifest fetch ghcr.io/stack4ops/cibuild-demo@"$VULN" | jq -r '.layers[0].digest'
)" | jq .
```

## Platform image - arm64

See above and replace `artifact-lock.linux-amd64.json` with `artifact-lock.linux-arm64.json`

## Release Image Multi-Arch Index

### Verification

`cosign verify --certificate-identity-regexp ".*" --certificate-oidc-issuer "https://token.actions.githubusercontent.com" ghcr.io/stack4ops/cibuild-demo:web-workflow`

### Inspect Transparency log entry

```sh
REF=ghcr.io/stack4ops/cibuild-demo:web-workflow
LOG_INDEX=$(cosign download signature "$REF" | jq -r '.verificationMaterial.tlogEntries[0].logIndex // empty')
printf '\nTransparency log entry:\n  https://search.sigstore.dev/?logIndex=%s\n\n' "$LOG_INDEX"
```