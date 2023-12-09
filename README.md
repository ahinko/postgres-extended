# Postgres Extended

My custom Postgres Docker images with extensions that I need. Based on Cloudnative-PGs Postgres Docker images.

## Added extensions:

### [pgvecto.rs](https://github.com/tensorchord/pgvecto.rs)

According to pgvecto.rs documentation we need to run the following on each database that will be using the vector extension.

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