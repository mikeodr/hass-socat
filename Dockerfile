FROM homeassistant/home-assistant:latest

RUN apt-get -y update && \
    apt-get -y install socat && \
    rm -fr /var/lib/apt/lists/*

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    /usr/bin/python2.7 get-pip.py
COPY pip2 /usr/local/bin/pip2
#RUN apt-get install python2.7 && \
#    easy_install supervisor && \
#    rm -fr /var/lib/apt/lists/*
RUN pip2 install supervisor
COPY supervisord.conf /etc/supervisord.conf
COPY start_socat.sh /usr/local/bin/start_socat.sh
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]