FROM ubuntu:18.04

COPY install_mongodb.sh /install_mongodb.sh
RUN chmod 0777 /install_mongodb.sh
RUN /install_mongodb.sh

RUN apt-get install -y mongodb-server ruby-full ruby-bundler build-essential git
RUN git clone -b monolith https://github.com/express42/reddit.git

RUN cd /reddit && rm Gemfile.lock && bundle install

COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh

RUN chmod 0777 /start.sh

CMD ["/start.sh"]
