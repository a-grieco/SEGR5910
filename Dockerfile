FROM ubuntu

ADD . /application

RUN apt-get update && \
    apt-get install -y wget npm && \
	wget http://download.redis.io/releases/redis-4.0.8.tar.gz && \
	tar xzf redis-4.0.8.tar.gz && \
	cd redis-4.0.8 && \
	make install && \
	cd utils && \
	./install_server.sh

EXPOSE 3000 3000

CMD ["bash", "/application/initialization_script"]