FROM metabase/metabase:v0.52.16

USER root

RUN mkdir -p /plugins \
    && chown -R 2000:2000 /plugins

ADD https://github.com/MotherDuck-Open-Source/metabase_duckdb_driver/releases/latest/download/duckdb.metabase-driver.jar /plugins/duckdb.metabase-driver.jar

RUN chown 2000:2000 /plugins/duckdb.metabase-driver.jar

USER metabase
