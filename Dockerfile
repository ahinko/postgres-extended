# syntax=docker/dockerfile-upstream:master
# renovate: datasource=docker depName=ghcr.io/cloudnative-pg/postgresql
ARG CNPG_TAG="17.2-32"

FROM ghcr.io/cloudnative-pg/postgresql:$CNPG_TAG

ARG CNPG_TAG

# To install any package we need to be root
USER root



# Change to the uid of postgres (26)
USER 26
