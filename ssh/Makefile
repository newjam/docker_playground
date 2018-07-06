
build:
	docker build . --tag ssh-example

stop:
	docker container stop ssh-example

rm:
	docker container rm ssh-example

run:
	docker run --publish 10000:22 --detach --hostname ssh-example --name ssh-example ssh-example:latest

connect:
	 ssh -p 10000 student@localhost

