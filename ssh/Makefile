
build:
	docker build . --tag first-stop
	docker build . --tag second-stop

stop:
	docker container stop first-stop
	docker container stop second-stop
	docker network rm my-network

start:
	docker network create \
	  --driver bridge \
	  --subnet=192.168.2.0/24 \
	  --gateway=192.168.2.1 \
	  my-network
	docker run \
    --publish 2222:22 \
    --detach \
    --rm \
    --hostname first-stop \
    --name first-stop \
    --network my-network \
	  --ip=192.168.2.2 \
    first-stop:latest
	docker run \
    --detach \
    --rm \
    --hostname second-stop \
    --name second-stop \
    --network my-network \
	  --ip=192.168.2.3 \
    second-stop:latest

connect:
	ssh -o UserKnownHostsFile=/dev/null -p 2222 student@localhost

