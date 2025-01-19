target=hello
enteryPoint=main.ll
outDir=dist
srcDir=src

DOCKER_IMAGE_NAME=clang
DOCKER_IMAGE_TAG=19.1.4-r0

###############  ###############
rootDir=${PWD}
outDirPath=$(rootDir)/$(outDir)
srcDirPath=$(rootDir)/$(srcDir)

define optimizeBuild
	$(eval oNumber = $(1))
	mkdir -p $(outDirPath)
	opt -O$(oNumber) -S $(srcDirPath)/$(enteryPoint) -o $(outDirPath)/o$(oNumber).ll 
	clang $(outDirPath)/o$(oNumber).ll -o $(outDirPath)/$(target)-o$(oNumber)
endef

.PHONY: all clean
###############  ###############

build:
	mkdir -p $(outDirPath)
	clang $(srcDirPath)/$(enteryPoint) -o $(outDirPath)/$(target)

o1:
	@$(call optimizeBuild, 1)

o2:
	@$(call optimizeBuild, 2)

o3:
	@$(call optimizeBuild, 3)

run:
	if make build; then \
		clear; \
		cd $(outDirPath); \
		exec ./$(target); \
	fi

clean:
	rm -rf $(outDirPath)

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
		--entrypoint /bin/sh \
		$(DOCKER_IMAGE_NAME):${DOCKER_IMAGE_TAG}
	
docker-stop:
	docker stop $(DOCKER_IMAGE_NAME)-container 2> /dev/null || true
	docker rm $(DOCKER_IMAGE_NAME)-container 2> /dev/null || true

docker-clean:
	make docker-stop
	docker builder prune -af
