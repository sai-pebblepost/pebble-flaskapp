FROM ubuntu:18.04
RUN apt-get update -y
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install python3.7 -y
RUN apt install python3-pip -y
RUN pip3 install flask
RUN apt-get install nginx -y
RUN apt-get install gunicorn3 -y

WORKDIR /app

ADD . /app
COPY flaskapp /etc/nginx/sites-enabled/
RUN chmod 777 startup.sh && ls -al
EXPOSE 80

CMD ["/app/startup.sh"]