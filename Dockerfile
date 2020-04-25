FROM node:alpine as builder
WORKDIR 'app/'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# elasticbeanstalk has a bug where it fails to take named build in a multi step build
# COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=0 /app/build /usr/share/nginx/html