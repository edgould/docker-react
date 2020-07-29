#tag as builder. THIS IS A BUILD PHASE
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN  npm install
COPY . . 
RUN npm run build

#THIS IS THE RUN PHASE. nginx automatically runs at the end of this
#Also, once the data is copied from the previous phase,
#the data is deleted
FROM nginx
#COPY fromm build phase to nginx directory for web pages
COPY --from=builder /app/build /usr/share/nginx/html