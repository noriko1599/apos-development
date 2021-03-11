FROM node:14
ENV APOS_MINIFY=1
ENV NODE_ENV=production
WORKDIR /app
COPY package* ./
RUN npm ci
RUN mkdir scripts
# Use "m" to temporarily install mongod in a lightweight way so
# the asset build task does not encounter problems initializing modules
# that expect a database. We do not actually need this database in the
# container, so uninstall it at the end
RUN apt-get -y update
RUN apt-get -y install scons
RUN npm install -g pm2
COPY . ./
EXPOSE 3000
# Load balance at least 2 copies
CMD ["pm2-runtime", "-i", "2", "start", "app.js" ]
