FROM node:24

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN npm install -g openclaw

WORKDIR /root

ENTRYPOINT ["/entrypoint.sh"]