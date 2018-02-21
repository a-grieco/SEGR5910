FROM ubuntu

RUN apt-get update && \
    apt-get install -y wget npm && \
	wget https://raw.githubusercontent.com/michaeljon/SU_SEGR_5910_18WQ/master/webapp.tar.gz && \
	tar xzf webapp.tar.gz && \
	wget http://download.redis.io/releases/redis-4.0.8.tar.gz && \
	tar xzf redis-4.0.8.tar.gz && \
	cd redis-4.0.8 && \
	make install && \
	cd utils && \
	./install_server.sh
	
COPY initialization_script /webapp/initialization_script

EXPOSE 3000 3000

CMD ["bash", "/webapp/initialization_script"]