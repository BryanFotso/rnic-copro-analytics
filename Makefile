SHELL := /bin/bash

DBT_PROJECT_DIR := rnic_dbt
DBT_PROFILES_DIR := rnic_dbt
SQLFLUFF_CONFIG := .sqlfluff
SQL_MODELS_PATH := rnic_dbt/models

.PHONY: help install precommit-install precommit-run precommit-run-all \
	sqlfluff-lint sqlfluff-fix dbt-deps dbt-parse dbt-run dbt-test dbt-build

help:
	@echo "Targets disponibles:"
	@echo "  make install            - Installe les dependances Python via uv"
	@echo "  make precommit-install  - Installe les hooks pre-commit"
	@echo "  make precommit-run      - Lance pre-commit sur les fichiers modifies"
	@echo "  make precommit-run-all  - Lance pre-commit sur tous les fichiers"
	@echo "  make sqlfluff-lint      - Lint SQL dbt avec sqlfluff"
	@echo "  make sqlfluff-fix       - Auto-fix SQL dbt avec sqlfluff"
	@echo "  make dbt-deps           - Installe les packages dbt"
	@echo "  make dbt-parse          - Verifie la compilation dbt"
	@echo "  make dbt-run            - Execute les models dbt"
	@echo "  make dbt-test           - Execute les tests dbt"
	@echo "  make dbt-build          - Execute run + test dbt"

install:
	uv sync

precommit-install:
	uvx pre-commit install

precommit-run:
	uvx pre-commit run

precommit-run-all:
	uvx pre-commit run --all-files

sqlfluff-lint:
	uv run sqlfluff lint $(SQL_MODELS_PATH) --config $(SQLFLUFF_CONFIG)

sqlfluff-fix:
	uv run sqlfluff fix $(SQL_MODELS_PATH) --config $(SQLFLUFF_CONFIG)

dbt-deps:
	uv run dbt deps --project-dir $(DBT_PROJECT_DIR) --profiles-dir $(DBT_PROFILES_DIR)

dbt-parse:
	uv run dbt parse --project-dir $(DBT_PROJECT_DIR) --profiles-dir $(DBT_PROFILES_DIR)

dbt-run:
	uv run dbt run --project-dir $(DBT_PROJECT_DIR) --profiles-dir $(DBT_PROFILES_DIR)

dbt-test:
	uv run dbt test --project-dir $(DBT_PROJECT_DIR) --profiles-dir $(DBT_PROFILES_DIR)

dbt-build:
	uv run dbt build --project-dir $(DBT_PROJECT_DIR) --profiles-dir $(DBT_PROFILES_DIR)
