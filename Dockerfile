#FROM node:10-alpine as build-stage
#WORKDIR /usr/src/app
#COPY package*.json ./
#RUN apk update
#RUN apk add --no-cache git
#RUN npm install --only=prod
#COPY . .
#RUN npm run build

# production stage
#FROM nginx:stable-alpine as production-stage
#RUN rm /etc/nginx/conf.d/default.conf
#COPY default.conf /etc/nginx/conf.d/default.conf
#COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]

FROM node:10.19.0-alpine

# create destination directory
RUN mkdir -p /usr/src/nuxt-app
WORKDIR /usr/src/nuxt-app

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git

# copy the app, note .dockerignore
COPY . /usr/src/nuxt-app/
RUN npm install

# build necessary, even if no static files are needed,
# since it builds the server as well
RUN npm run build
#RUN npm run generate
# expose 5000 on container
EXPOSE 5000

# set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0
# set app port
ENV NUXT_PORT=5000

# start the app
CMD [ "npm", "start" ]