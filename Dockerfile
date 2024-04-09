FROM node:21-alpine

WORKDIR /app
COPY app/. ./
RUN npm install 

EXPOSE 3000
ENTRYPOINT ["node","./index.js"]