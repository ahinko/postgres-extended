# Postgres Extended
My custom Postgres Docker images with extensions that I need. Based on Cloudnative-PGs Postgres Docker images.

## A note about Semver

Cloudnative-PG requires the Docker image to be tagged with Postgres version, i.e. 16.1 and so on. So there is no way of updating the major version if I have to introduce breaking changes to this image. Read the release notes carefully before updating.

## Added extensions:

### [TimescaleDB](https://github.com/timescale/timescaledb)

> [!IMPORTANT]
> Enable the extension to both existing and new databases by adding the following to your Cluster spec.
> Note that the extension is only enabled. You still need to create it on each database you want to use it on (see below).
> ```yaml
> apiVersion: postgresql.cnpg.io/v1
> kind: Cluster
> spec:
>   (...)
>   postgresql:
>     shared_preload_libraries:
>       - timescaledb
> ```

According to TimescaleDB documentation we need to run the following on each database that will be using the TimescaleDB extension. 

```sql
CREATE EXTENSION IF NOT EXISTS timescaledb;
```

We need to run these statements after each update of the TimescaleDB extension.

```sql
ALTER EXTENSION timescaledb UPDATE;
```

To check current exstension versions:
```sql
SELECT * FROM pg_extension;
```





> [!Important]
> **BREAKING CHANGE, pgvecto.rs has been removed**
>
> If you rely on this Docker image to run the Immich database on you should NOT upgrade to this version. pgvecto.rs has not published a Postgres 17 compatible package that this image used to install pgvecto.rs. Adding to that, it seems like Immich is moving away from pgvecto.rs, (see https://github.com/immich-app/immich/discussions/14280). Please keep using the 16.6.29 version of this image. 
> 
> I will add whatever extension and version Immich decides to use as soon as possible.
