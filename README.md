# rnic-copro-analytics
End-to-end data pipeline and BI project analyzing the evolution of French registered condominiums (RNIC data) using DuckDB and dbt

## Metabase + DuckDB setup (Docker)

This repository includes a Docker setup to run Metabase with the DuckDB community driver preinstalled.

### 1) Start Metabase

```bash
docker compose -f docker-compose.metabase.yml up -d --build
```

Metabase will be available at `http://localhost:3000` (or the port set with `MB_PORT`).

### 2) Connect Metabase to your DuckDB database

At first launch, complete Metabase onboarding, then add a new database:

- **Database type**: `DuckDB`
- **Database file path**: a file mounted inside the container, for example:
  - `/data/prod/dev.duckdb`
  - `/data/prod/prod.duckdb`

The compose file mounts your local `./data` directory into the container as `/data` (read-only).

### 3) Stop Metabase

```bash
docker compose -f docker-compose.metabase.yml down
```

Metabase metadata is persisted in `./metabase-data`.
