FROM nginx

RUN rm -rf /usr/share/html/*
RUN cp . /usr/share/html/

EXPOSE "80"
