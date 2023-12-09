# Postgres Extended

My custom Postgres Docker images with extensions that I need. Based on Cloudnative-PGs Postgres Docker images.

## Added extensions:

### [pgvecto.rs](https://github.com/tensorchord/pgvecto.rs)

> [!IMPORTANT]
> If you are using this image on an existing database, the postgres configuration needs to be
> altered to enable the extension. You can do this by setting shared_preload_libraries in your Cluster spec:
> ```yaml
> apiVersion: postgresql.cnpg.io/v1
> kind: Cluster
> spec:
>   (...)
>   postgresql:
>     shared_preload_libraries:
>       - "vectors.so"
>   ```

According to pgvecto.rs documentation we also need to run the following on each database that should have vectors enabled.

```sql
DROP EXTENSION IF EXISTS vectors;
CREATE EXTENSION vectors;
```

Still unstested but if we need to upgrade the exstension the Postgred documentation mentions running:
```sql
ALTER EXTENSION vectors UPDATE
```

To check current exstension versions:
```sql
SELECT * FROM pg_extension;
```