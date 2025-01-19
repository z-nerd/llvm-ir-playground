include config.mk

.PHONY: all clean

build:
	@$(call optZ, 1)

build-o2:
	@$(call optZ, 2)

build-o3:
	@$(call optZ, 3)

run:
	if make build; then \
		clear; \
		cd $(OUT_DIR); \
		exec ./$(TARGET); \
	fi

clean:
	rm -rf $(OUT_DIR)

docker-build:
	make docker-stop
	if docker image inspect "$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" > /dev/null 2>&1; then \
		docker rmi -f $(DOCKER_IMAGE_NAME):${DOCKER_IMAGE_TAG}; \
	fi
	export DOCKER_BUILDKIT=1
	export BUILDKIT_PROGRESS=tty
	docker build \
		-t $(DOCKER_IMAGE_NAME):${DOCKER_IMAGE_TAG} .

docker-run:
	make docker-stop
	if ! docker image inspect "$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" > /dev/null 2>&1; then \
		make docker-build; \
	fi
	docker run \
		--name ${DOCKER_IMAGE_NAME}-container \
		-v .:/app \
		$(DOCKER_IMAGE_NAME):${DOCKER_IMAGE_TAG}

docker-debug:
	make docker-stop
	if ! docker image inspect "$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" > /dev/null 2>&1; then \
		make docker-build; \
	fi
		docker run \
		-it \
		--name ${DOCKER_IMAGE_NAME}-container \
		-v .:/app \
		--entrypoint /bin/bash \
		$(DOCKER_IMAGE_NAME):${DOCKER_IMAGE_TAG}
	
docker-stop:
	docker stop $(DOCKER_IMAGE_NAME)-container 2> /dev/null || true
	docker rm $(DOCKER_IMAGE_NAME)-container 2> /dev/null || true

docker-clean:
	make docker-stop
	docker builder prune -af
