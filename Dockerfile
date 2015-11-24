FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y python-dev \
  python-pip \
  git \
  zip

RUN pip install --upgrade pip
RUN pip install virtualenv

RUN mkdir listener_root
ADD scripts/* /listener_root/scripts/
ADD config/* /listener_root/config/

RUN chmod 755 -R /listener_root

RUN /listener_root/scripts/installvenv.sh
RUN /listener_root/scripts/setupssh.sh

ADD listener.py /listener_root/
RUN chmod +x /listener_root/listener.py

EXPOSE 5000
#CMD ["/bin/bash"]
CMD ["/listener_root/scripts/startenv.sh"]
