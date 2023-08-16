ARG BUILDKIT_INLINE_CACHE
ARG PYTHON_BASE_IMAGE_VERSION

FROM dimaliv/ansible:6 as molecule
ARG MOLECULE_VERSION
ARG MOLECULE_DOCKER_PLUGIN_VERESION
ARG DOCKER_VERSION
RUN apk add --no-cache \
        docker=~${DOCKER_VERSION} && \
    python3 -m pip install --no-cache \
        molecule==${MOLECULE_VERSION} \
        molecule-plugins[docker]==${MOLECULE_DOCKER_PLUGIN_VERESION} \
        hvac
