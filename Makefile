# Env
export PYTHONDONTWRITEBYTECODE=1

# Python version (e.g., make init PY=3.12)
PY ?=

ifdef PY
  UV_PYTHON = --python $(PY)
else
  UV_PYTHON =
endif

.PHONY: help init test check build-binary clean clean-pyc clean-build clean-test publish

help: ## Show this help message.
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make <target>\n\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "\033[32m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Init environment for ros-tran. Use PY=3.x to specify Python version via uv.
	uv venv $(UV_PYTHON) --clear
	uv pip install -e ".[dev]"
	uv run pre-commit install

test: ## Run tests.
	uv run pytest tests

check: ## Run pre-commit to check code style and auto format.
	uv run pre-commit run --all-files

build-binary: ## Build standalone rostran binary using PyInstaller.
	uv run --extra binary python build.py

clean: clean-pyc clean-build clean-test ## Remove python, build, and test artifacts.

clean-pyc: ## Remove python artifacts.
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*.log' -exec rm -f {} +
	find . -name '*~' -exec rm -f  {} +
	find . -name '__pycache__' -exec rm -rf {} +

clean-build: ## Remove build artifacts.
	rm -rf build dist *.egg-info .eggs

clean-test: ## Remove test artifacts.
	find . -name '.pytest_cache' -exec rm -rf {} +
	find . -name '.log' -exec rm -rf {} +

publish: clean ## Build and publish the package.
	uv run python setup.py bdist_wheel
	uv run python setup.py sdist
	uv run twine check dist/*
	uv run twine upload -r pypiantfin dist/*
	make clean
