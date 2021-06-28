FROM nginx:1.16-alpine

COPY rootfs /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]
