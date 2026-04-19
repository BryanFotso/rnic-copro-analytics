FROM metabase/metabase:v0.60.1.4

USER root

RUN apk add --no-cache libstdc++ ca-certificates curl

RUN mkdir -p /plugins \
  && chown -R 2000:2000 /plugins

ADD https://github.com/MotherDuck-Open-Source/metabase_duckdb_driver/releases/latest/download/duckdb.metabase-driver.jar \
  /plugins/duckdb.metabase-driver.jar

RUN chown 2000:2000 /plugins/duckdb.metabase-driver.jar

USER 2000
