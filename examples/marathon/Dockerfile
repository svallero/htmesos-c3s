FROM svallero/htmesos-centos

#RUN useradd -m -d /home/guest guest
RUN useradd guest

# setup ssh for user guest
RUN mkdir -p /home/guest/.ssh
RUN chmod 700 /home/guest/.ssh
RUN chown guest:guest /home/guest/.ssh

COPY id_rsa.pub /home/guest/.ssh/authorized_keys
RUN chmod 600 /home/guest/.ssh/authorized_keys
RUN chown guest:guest /home/guest/.ssh/authorized_keys

VOLUME /home/guest/scratch

