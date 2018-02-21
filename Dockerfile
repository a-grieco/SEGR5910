FROM tempubuntu

RUN apt-get update && \
    apt-get install -y wget npm && \
	mkdir application && \
	cd application && \
	wget https://s3-us-west-2.amazonaws.com/techops-interview-webapp/webapp.tar.gz && \
	tar xzf webapp.tar.gz && \
	cd .. && \
	wget http://download.redis.io/releases/redis-4.0.8.tar.gz && \
	tar xzf redis-4.0.8.tar.gz && \
	cd redis-4.0.8 && \
	make install && \
	cd utils && \
	./install_server.sh
	
COPY initialization_script /application/initialization_script

EXPOSE 3000 3000

CMD ["bash", "/application/initialization_script"]