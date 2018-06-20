
# Installing Docker

Following [this guide on installing docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04) and [this guide on docker containers](https://docs.docker.com/get-started/part2/).

Add docker key and add docker apt-get repository

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

Update apt-get, verify docker-ce will be downloaded from correct repository, install docker-ce, and verify docker is installed

```
sudo apt-get update
sudo apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker
```

Add current user to docker group, to allow using docker without sudo prefixed, log in again to apply changes, and verify user is in docker group

```
sudo usermod --append --groups docker ${USER}
su - ${USER}
```

# Containerizing a challenge

Our goal is to run a challenge inside of a docker container.
The hope is that this makes building and running challenges reproducible and standardized, at the cost of additional complexity surrounding docker.
Clone hm4c challenge

```
git clone https://github.com/newjam/hm4c/
cd hm4c
```

Using socat we can set up a server to listen on a port and run hm4c.py on each clients connect.

```
socat tcp-l:31337,crlf,fork system:"python hm4c.py"
```

Then we can connect using netcat

```
nc 127.0.0.1 31337
```

Our goal is to create a docker image that has this all set up.
Check out [Dockerfile], where the instructions to docer to build the docker image are found.
We can build the image thusly:

```
docker build -t hm4c .
```

And see it listed

```
docker image ls
```

Then we can run our image

```
docker run -t -p 31337:31337 hm4c
```

and again connect to it over netcat!

