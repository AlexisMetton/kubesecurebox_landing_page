# Image épinglée pour reproductibilité et moindre surface d’attaque (Trivy)
FROM nginx:1.27-alpine
ARG BUILD_SHA=latest
COPY . /usr/share/nginx/html
RUN cd /usr/share/nginx/html && for f in *.html; do \
  sed -i "s|\.css\"|.css?v=${BUILD_SHA}\"|g" "$f" && \
  sed -i "s|\.js\"|.js?v=${BUILD_SHA}\"|g" "$f"; \
done
COPY nginx.conf /etc/nginx/conf.d/default.conf
