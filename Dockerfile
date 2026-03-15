FROM node:24

RUN npm install -g openclaw

WORKDIR /root

CMD ["openclaw", "gateway"]