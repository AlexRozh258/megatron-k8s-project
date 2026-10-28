FROM nginxinc/nginx-unprivileged:1.27-alpine-slim

LABEL maintainer="Dev Team"
LABEL description="Secure non-root Nginx static webpage"

COPY --chown=nginx:nginx html/ /usr/share/nginx/html/

USER 101

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
