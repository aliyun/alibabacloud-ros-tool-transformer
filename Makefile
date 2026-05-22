# Env
export PYTHONDONTWRITEBYTECODE=1

# Python version (e.g., make init PY=3.12)
PY ?=

ifdef PY
  UV_PYTHON = --python $(PY)
else
  UV_PYTHON =
endif

# Func
.PHONY: docs

help:
	@echo "\033[32minit\033[0m"
	@echo "    Init environment for ros-tran."
	@echo "\033[32mtest\033[0m"
	@echo "    Run tests."
	@echo "\033[32mcheck\033[0m"
	@echo "    Run pre-commit to check code style and auto format."
	@echo "\033[32mclean\033[0m"
	@echo "    Remove python and build artifacts."
	@echo "\033[32mclean-pyc\033[0m"
	@echo "    Remove python artifacts."
	@echo "\033[32mclean-build\033[0m"
	@echo "    Remove build artifacts."
	@echo ""
	@echo "\033[33mUse PY=3.x to specify Python version via uv:\033[0m"
	@echo "    make init PY=3.12"
	@echo "    make test PY=3.13"

init:
	uv venv $(UV_PYTHON) --clear
	uv pip install -e ".[dev]"
	uv run pre-commit install

test:
	uv run pytest tests

check:
	uv run pre-commit run --all-files

clean: clean-pyc clean-build clean-test

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*.log' -exec rm -f {} +
	find . -name '*~' -exec rm -f  {} +
	find . -name '__pycache__' -exec rm -rf {} +

clean-build:
	rm -rf build dist *.egg-info .eggs

clean-test:
	find . -name '.pytest_cache' -exec rm -rf {} +
	find . -name '.log' -exec rm -rf {} +

publish: clean
	uv run python setup.py bdist_wheel
	uv run python setup.py sdist
	uv run twine check dist/*
	uv run twine upload -r pypiantfin dist/*
	make clean
