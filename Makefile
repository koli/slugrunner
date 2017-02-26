SHORT_NAME = slugrunner

include versioning.mk

# It's necessary to set this because some environments don't link sh -> bash.
SHELL := /bin/bash

build: docker-build

all:
	@echo "Use a Makefile to control top-level building of the project."

check-docker:
	@if [ -z $$(which docker) ]; then \
	  echo "Missing \`docker\` client which is required"; \
	  exit 2; \
	fi

docker-build: check-docker
	docker build --rm -t ${IMAGE} rootfs
	docker tag ${IMAGE} ${MUTABLE_IMAGE}

deploy: docker-build docker-push

# make clean
clean: check-docker
	docker rmi $(IMAGE)

# make test
test: test-style test-unit test-functional

test-style:
	@echo "Implement test-style"

test-unit:
	@echo "Implement unit tests"

test-functional:
	@echo "Implement functional tests"

.PHONY: all docker-build docker-push test
