FROM nginx:1.17.0-alpine
COPY index.html /usr/share/nginx/html/index.html
COPY background.png /usr/share/nginx/html/background.png
