ARG BUILDKIT_INLINE_CACHE

FROM docker:24-dind
ARG ANSIBLE_VERSION
ARG MOLECULE_VERSION
ARG MOLECULE_DOCKER_PLUGIN_VERESION
RUN apk add --no-cache \
    python3 python3-dev py3-pip gcc git curl build-base \
    autoconf automake py3-cryptography linux-headers \
    musl-dev libffi-dev openssl-dev openssh rsync ca-certificates && \
    python3 -m pip install --no-cache \
    ansible==${ANSIBLE_VERSION} \
    molecule==${MOLECULE_VERSION} \
    molecule-plugins[docker]==${MOLECULE_DOCKER_PLUGIN_VERESION} \
    hvac
