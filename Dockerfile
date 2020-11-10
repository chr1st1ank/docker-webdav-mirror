FROM alpine:3.12

RUN apk add --update --no-cache bash inotify-tools rclone

RUN mkdir /local /remote

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENV POLL_INTERVAL_SECONDS=10
ENV REMOTE_WEBDAV_URL=https://example.com/remote.php/webdav/
ENV REMOTE_USER=user
ENV REMOTE_PASSWORD=secret

# HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 CMD [ "executable" ]
ENTRYPOINT /usr/bin/entrypoint.sh
