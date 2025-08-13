# https://explore.ggcr.dev/?repo=registry.k8s.io

# kubectl is supported within one minor version (older or newer) of kube-apiserver
FROM registry.k8s.io/kubernetes/kubectl:v1.33.4 AS kubectl
FROM registry.k8s.io/kustomize/kustomize:v5.7.1 AS kustomize
FROM ghcr.io/tcurdt/oci-resolve:v0.0.14 AS oci-resolve

FROM alpine:3

COPY --from=kubectl /bin/kubectl /usr/local/bin/
COPY --from=kustomize /app/kustomize /usr/local/bin/
COPY --from=oci-resolve /usr/local/bin/oci-resolve /usr/local/bin/

RUN apk add --no-cache \
  curl \
  xh \
  jq \
  yq

# RUN curl -L https://github.com/tcurdt/oci-resolve/releases/download/v0.0.1/oci-resolve_0.0.1_aarch64.apk > oci-resolve.apk && apk add --allow-untrusted ./oci-resolve.apk && rm oci-resolve.apk

# docker run --rm -it kubeops sh
