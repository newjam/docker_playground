FROM phusion/baseimage:0.10.1

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/sshd/down

RUN sed -i "s/PasswordAuthentication\ *no/PasswordAuthentication yes/g" /etc/ssh/sshd_config

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN service ssh reload

EXPOSE 22

RUN apt-get update
RUN apt-get install -y sudo
RUN apt-get install -y net-tools

RUN useradd \
      --home-dir /home/student \
      --create-home \
      --shell /bin/bash \
      --groups sudo \
      --password $(echo supersecret | openssl passwd -1 -stdin) \
      student

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

