build:
	docker build -t docker-murmur .

rebuild:
	make remove; make build; make run

run:
	docker run -d -p 64738:64738/udp -p 64738:64738/tcp --name murmur-001 docker-murmur

debug:
	docker run --rm -it -p 64738:64738/udp -p 64738:64738/tcp --entrypoint=sh docker-murmur

remove:
	make stop-containers; make remove-containers; make remove-image

remove-containers:
	docker ps -a | grep 'docker-murmur' | awk '{print $1}' | xargs --no-run-if-empty docker rm

remove-image:
	docker rmi docker-murmur

stop-containers:
	docker ps -a | grep 'docker-murmur' | awk '{print $1}' | xargs --no-run-if-empty docker stop
