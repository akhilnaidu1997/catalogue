FROM node:20.19.6-alpine3.22 AS build
WORKDIR /app
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20.19.5-alpine3.22
WORKDIR /app
COPY --from=build /app /app
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop 
RUN chown -R roboshop:roboshop /app
EXPOSE 8080
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
USER roboshop
CMD ["node","server.js"]