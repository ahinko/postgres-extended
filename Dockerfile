# renovate: datasource=docker depName=ghcr.io/cloudnative-pg/postgresql
ARG CNPG_TAG="16.1-5"

FROM curlimages/curl:7.72.0 AS download

# renovate: datasource=github-releases depName=tensorchord/pgvecto.rs
ARG PGVECTORS_TAG="v0.1.11"
ARG CNPG_TAG

# Download pgvecto.rs
WORKDIR /download
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN PG_MAJOR=$(echo $CNPG_TAG | cut -d'.' -f1) \
  && curl -o pgvectors.deb -sSL "https://github.com/tensorchord/pgvecto.rs/releases/download/$PGVECTORS_TAG/vectors-pg${PG_MAJOR}-$PGVECTORS_TAG-x86_64-unknown-linux-gnu.deb"


FROM ghcr.io/cloudnative-pg/postgresql:$CNPG_TAG

WORKDIR /

# To install any package we need to be root
USER root

# Copy pgvecto.rs from previous stage, install, then remove
COPY --from=download /download/pgvectors.deb ./pgvectors.deb
RUN apt-get install -y --no-install-recommends ./pgvectors.deb && \
  rm -rf /download

# Change to the uid of postgres (26)
USER 26

# From https://stackoverflow.com/a/42508925
# Note that this way of enabling the plugin only works on database init
# We should investigate alternative ways of enabling it that will always work
COPY install-pgvectors.sql /docker-entrypoint-initdb.d/
