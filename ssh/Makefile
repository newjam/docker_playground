
build:
	docker build . --tag ssh-example

stop:
	docker container stop ssh-example

start:
	docker run \
    --publish 10000:22 \
    --detach \
    --rm \
    --hostname ssh-example \
    --name ssh-example \
    ssh-example:latest

connect:
	ssh -o UserKnownHostsFile=/dev/null -p 10000 student@localhost

