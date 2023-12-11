# Postgres Extended

*** This repo is still in development. I'm still testing different things to find the best way to load/enable the extension. Expect breaking changes. ***

My custom Postgres Docker images with extensions that I need. Based on Cloudnative-PGs Postgres Docker images.

## A note about Semver

Cloudnative-PG requires the Docker image to be tagged with Postgres version, i.e. 16.1 and so on. So there is no way of updating the major version if I have to introduce breaking changes to this image.

## Added extensions:

### [pgvecto.rs](https://github.com/tensorchord/pgvecto.rs)

According to pgvecto.rs documentation we need to run the following on each database that will be using the vector extension.

```sql
DROP EXTENSION IF EXISTS vectors;
CREATE EXTENSION vectors;
```

Still unstested but if we need to upgrade the exstension the Postgres documentation mentions running:
```sql
ALTER EXTENSION vectors UPDATE
```

To check current exstension versions:
```sql
SELECT * FROM pg_extension;
```