#From base image
FROM node:14-alpine as build

#Make working directory
WORKDIR /app

#Copy package json
COPY package.json /app

#Install all the dependencies
RUN npm install

#Update entire code
COPY . .
#above copy means . /app

#Install ng
RUN npm install -g @angular/cli

#Build the code
RUN ng build

#Now copy the build code in httpd
FROM httpd:2.4.48-alpine

#Copy the build code in httpd
COPY --from=build /app/dist/angularCalc/ /usr/local/apache2/htdocs/
