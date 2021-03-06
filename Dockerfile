FROM ubuntu:20.04


RUN mkdir ./app
RUN chmod 777 ./app
WORKDIR /app

#RUN apt -qq update

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

#RUN apt-get update --fix-missing
#RUN apt-get -qq install -y git aria2 wget curl busybox unzip unrar tar python3 ffmpeg python3-pip
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update&&apt-get install -y --no-install-recommends git aria2 wget curl busybox unzip unrar tar python3 ffmpeg python3-pip
RUN wget https://rclone.org/install.sh
RUN bash install.sh

RUN mkdir /app/gautam
RUN wget -O /app/gautam/gclone.gz https://git.io/JJMSG
RUN gzip -d /app/gautam/gclone.gz
RUN chmod 0775 /app/gautam/gclone

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt --upgrade youtube-dl
COPY . .
CMD ["bash","start.sh"]
