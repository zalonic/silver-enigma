# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM quay.io/centos-bootc/centos-bootc:stream10

ARG CLEAN_VERSION=${CLEAN_VERSION}
ARG BUILD_VERSION=${BUILD_VERSION}

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

# Make '/opt' writable
RUN rm -rf /opt && ln -s /var/opt /opt 

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
