# syntax=docker/dockerfile-upstream:master
# renovate: datasource=docker depName=ghcr.io/cloudnative-pg/postgresql
ARG CNPG_TAG="17.4-14"

FROM ghcr.io/cloudnative-pg/postgresql:$CNPG_TAG

# renovate: datasource=github-releases depName=timescale/timescaledb
ARG TIMESCALE_VERSION="2.19.3"
ARG CNPG_TAG
ARG POSTGRES_VERSION=${CNPG_TAG%.*}

# To install any package we need to be root
USER root

RUN <<EOT
  set -eux

  # Install dependencies
  apt-get update
  apt-get install -y --no-install-recommends curl

  # Add Timescale apt repo
  . /etc/os-release 2>/dev/null
  echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $VERSION_CODENAME main" >/etc/apt/sources.list.d/timescaledb.list
  curl -Lsf https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor >/etc/apt/trusted.gpg.d/timescale.gpg

  # Install Timescale
  apt-get update
  apt-get install -y --no-install-recommends "timescaledb-2-postgresql-$POSTGRES_VERSION=$TIMESCALE_VERSION~debian$VERSION_ID"

  # Cleanup
  apt-get purge -y curl
  rm /etc/apt/sources.list.d/timescaledb.list /etc/apt/trusted.gpg.d/timescale.gpg
  rm -rf /var/cache/apt/*
EOT

# Change to the uid of postgres (26)
USER 26
