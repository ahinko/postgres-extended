# syntax=docker/dockerfile-upstream:master
# renovate: datasource=docker depName=ghcr.io/cloudnative-pg/postgresql
ARG CNPG_TAG="16.3-5"

FROM ghcr.io/cloudnative-pg/postgresql:$CNPG_TAG

# renovate: datasource=github-releases depName=tensorchord/pgvecto.rs
ARG PGVECTORS_TAG="v0.2.1"
ARG CNPG_TAG

# To install any package we need to be root
USER root

# Download pgvecto.rs
ADD https://github.com/tensorchord/pgvecto.rs/releases/download/${PGVECTORS_TAG}/vectors-pg${CNPG_TAG%.*}_${PGVECTORS_TAG#"v"}_amd64.deb ./pgvectors.deb

# Copy pgvecto.rs from previous stage, install, then remove
RUN apt-get install -y --no-install-recommends ./pgvectors.deb && \
  rm -rf /download

# Change to the uid of postgres (26)
USER 26
