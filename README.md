[![SBOM](https://img.shields.io/badge/SBOM-SPDX%20%2B%20CycloneDX-blue?logo=json)](https://gitlab.hrz.uni-marburg.de/hrz/container-ci/cibuilder/cibuild-demo/-/packages/)
[![Provenance](https://img.shields.io/badge/Provenance-SLSA%20L2-blue?logo=json)](https://gitlab.hrz.uni-marburg.de/hrz/container-ci/cibuilder/cibuild-demo/-/packages/)
[![Vulnerabilities](https://img.shields.io/badge/CVE--Report-available-blue?logo=json)](https://gitlab.hrz.uni-marburg.de/hrz/container-ci/cibuilder/cibuild-demo/-/packages/)
[![Signed](https://img.shields.io/badge/cosign-signed-green?logo=sigstore&logoColor=white)](https://gitlab.hrz.uni-marburg.de/hrz/container-ci/cibuilder/cibuild-demo/-/blob/web-workflow/cosign.pub?ref_type=heads)

# demo build repo

Repo for demonstrating various config settings for cibuild lib in Multi-CI environments.

The build is triggered by manual web workflow.

## 🔐 Supply Chain Security

This container image is secured using Sigstore:

- ✅ Signed with Cosign (public/private key: CIBUILD_RELEASE_COSIGN_SIGNING_MODE=key)
- ✅ SBOM attached (SPDX, CIBUILD_BUILD_SBOM=1)
- ✅ SLSA provenance available (CIBUILD_BUILD_PROVENANCE=1)

### Verification

- The private key is provided by CIBUILD_RELEASE_COSIGN_PRIVATE_KEY (base64 encoded)
- The public key is part of the repo: cosign.pub

`cosign verify --key cosign.pub --private-infrastructure registry.hrz.uni-marburg.de/cibuilder/cibuild-demo:web-workflow`
