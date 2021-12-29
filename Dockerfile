FROM python:3.8-buster

ARG DEBIAN_FRONTEND=noninteractive
ARG working_directory
ENV WORKING_DIRECTORY=$working_directory
ENV TZ=Europe/Oslo

RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
RUN apt-get update
RUN apt-get install -y docker-ce-cli


RUN pip3 install --upgrade pip

RUN useradd -m -s /bin/bash arturo
USER arturo
ENV PATH "$PATH:/home/arturo/.local/bin"


COPY ./requirements.txt ./requirements.txt

RUN pip3 install -r requirements.txt

COPY entry_script.sh ./entry_script.sh
USER root

RUN ["chmod", "+x", "entry_script.sh"]
ENTRYPOINT ["/entry_script.sh"]

