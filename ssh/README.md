

`Dockerfile` builds an image with a user named `student` with password `supersecret` and enables ssh login.

In the `ssh` directory run the command
```
docker build . -t ssh-example
```
to build the image.
We should be able to see the image
```
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ssh-example         latest              2bc03f04bef2        6 seconds ago       242MB
```
Next we can run the docker image as a container.
```
$docker run -publish 10000:22 --hostname ssh-example --detach ssh-example:latest
```
Then we can verify that the container is running
```
$ docker container ls
CONTAINER ID        IMAGE                COMMAND                  CREATED              STATUS              PORTS                      NAMES
d0d774b849d7        ssh-example:latest   "/sbin/my_init"          About a minute ago   Up About a minute   0.0.0.0:10000->22/tcp      xenodochial_sha
```
With the container now running, we can ssh into the service.
```
$ ssh -p 10000 student@localhost
student@localhost's password:
Last login: Fri Jul  6 00:36:54 2018 from 172.17.0.1
student@ssh-example:~$ echo "I used ssh to log in to a docker container!"
I used ssh to log in to a docker container
student@ssh-example:~$ exit
logout
Connection to localhost closed.
```

Great!
Next we will need to figure out how to create networks and private subnets so hosts can talk to eachother in the subnet.

