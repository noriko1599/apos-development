FROM node:14
ENV NODE_ENV=production
WORKDIR /app
COPY package* ./
RUN npm i
RUN mkdir scripts
RUN apt-get -y update
RUN apt-get -y install scons
RUN npm install -g pm2
COPY . ./
EXPOSE 3000
CMD ["pm2-runtime", "-i", "2", "start", "app.js" ]
