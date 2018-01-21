FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget libglu1-mesa libpcre3 \
                       libpcre3-dev libsm6 qt5-default

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/tibia && \
    echo "tibia:x:${uid}:${gid}:Tibia,,,:/home/tibia:/bin/bash" >> /etc/passwd && \
    echo "tibia:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/tibia

USER tibia
ENV HOME /home/tibia
WORKDIR $HOME
RUN wget http://download.tibia.com/tibia.x64.tar.gz
RUN tar -zxvf tibia.x64.tar.gz --strip-components=1
RUN ln -s /usr/lib/x86_64-linux-gnu/libpcre16.so.3 $HOME/bin/libpcre16.so.0
RUN chmod +x start-tibia.sh
CMD ["./start-tibia.sh"]
