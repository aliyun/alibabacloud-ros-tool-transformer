.PHONY: dev serve build generate

dev:
	npm start

serve: build
	npm run serve

build: generate
	npm run build

generate:
	python scripts/generate_supported_types.py
