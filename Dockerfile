FROM nginx:latest
WORKDIR /usr/share/html/
RUN echo "Hello EKS" > /usr/share/nginx/html/index.html
EXPOSE 80