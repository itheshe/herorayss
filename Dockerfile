FROM alpine:3.5

ENV TLS_PORT=4433 PORT=8080
ADD configure.sh /configure.sh

RUN apk add --no-cache ca-certificates unzip wget \
 && chmod +x /configure.sh
 
EXPOSE ${TLS_PORT} $PORT
 
CMD /configure.sh
