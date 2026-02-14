FROM nginx:alpine
ARG BUILD_SHA=latest
COPY . /usr/share/nginx/html
RUN cd /usr/share/nginx/html && for f in *.html; do \
  sed -i "s|\.css\"|.css?v=${BUILD_SHA}\"|g" "$f" && \
  sed -i "s|\.js\"|.js?v=${BUILD_SHA}\"|g" "$f"; \
done
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/lib/nginx && chown -R nginx:nginx /var/cache/nginx /var/lib/nginx /usr/share/nginx/html && \
    sed -i 's|pid /run/nginx.pid;|pid /var/cache/nginx/nginx.pid;|' /etc/nginx/nginx.conf

# Run as non-root user (listen on 8080, not 80)
USER nginx
EXPOSE 8080
