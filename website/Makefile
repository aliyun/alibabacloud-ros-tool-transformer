.PHONY: help dev serve build generate clean

help: ## Show this help message.
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make <target>\n\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "\033[32m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

dev: ## Start the Docusaurus development server.
	npm start

serve: build ## Build and serve the generated website locally.
	npm run serve

build: generate ## Generate supported-types docs and build the website.
	npm run build

generate: ## Generate supported-types docs.
	python scripts/generate_supported_types.py

clean: ## Remove Docusaurus generated artifacts.
	rm -rf build .docusaurus .cache-loader
