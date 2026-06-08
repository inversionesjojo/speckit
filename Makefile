SPECIFY_VERSION="v0.9.5"
TAG="v1.0.0"
PROJECT_NAME?=speckit
INTEGRATION?=agy
build:
	@docker build --build-arg SPECIFY_VERSION=$(SPECIFY_VERSION) -t spectkit:$(TAG) .
run:
	docker run --rm -it -w /app -v $(PWD):/app spectkit:$(TAG) specify init $(PROJECT_NAME) --integration $(INTEGRATION) --ignore-agent-tools
