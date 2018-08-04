FROM homeassistant/home-assistant:latest

RUN apt-get -y update && \
    apt-get -y install socat git && \
    rm -fr /var/lib/apt/lists/*

# Supervisord v3.2+ needed, can only be installed with python 2.7, so some jumping around to get it. 
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    /usr/bin/python2.7 get-pip.py
COPY pip2 /usr/local/bin/pip2
RUN pip install --upgrade pip==9.0.3
RUN pip2 install supervisor requests datetime
COPY supervisord.conf /etc/supervisord.conf
COPY start_socat.sh /usr/local/bin/start_socat.sh
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]
