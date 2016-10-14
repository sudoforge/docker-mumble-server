.PHONY: build rebuild run debug remove-all remove-containers remove-image stop-containers
.DEFAULT:
IMAGE_NAME="bddenhartog/docker-murmur:dev"

build:
	@docker build -t ${IMAGE_NAME} .

run:
	@docker run -d -p 64738/udp -p 64738/tcp ${IMAGE_NAME}

debug:
	@docker run --rm -it \
		-p 64738/udp \
		-p 64738/tcp \
		-e DEBUG_MODE=1 -e MUMBLE_ICE=potatofarm \
		-v ${PWD}/script/docker-murmur:/usr/bin/docker-murmur:Z \
		--entrypoint=sh \
		${IMAGE_NAME}

stop-containers:
	@docker ps -a 2>&1 | grep ${IMAGE_NAME} | awk '{print $$1}' | xargs --no-run-if-empty docker stop

remove-containers: stop-containers
	@docker ps -a 2>&1 | grep ${IMAGE_NAME} | awk '{print $$1}' | xargs --no-run-if-empty docker rm

remove-image: remove-containers
	@docker rmi ${IMAGE_NAME}

rebuild: remove-image build