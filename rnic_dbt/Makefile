SHELL := /bin/bash

.PHONY: help

help:
	@$(MAKE) -C .. help

# Forward any target to the root Makefile so commands work from rnic_dbt/.
%:
	@$(MAKE) -C .. $@
