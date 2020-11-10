#!/bin/bash

cat << EOF > /etc/rclone.conf 
[remote]
type = webdav
url = ${REMOTE_WEBDAV_URL}
vendor = other
user = ${REMOTE_USER}
bearer_token =
EOF
echo password=$(echo "$REMOTE_PASSWORD"|base64) >> /etc/rclone.conf

function sync() {
    echo "Synchronizing files"
    rclone sync --config /etc/rclone.conf --create-empty-src-dirs /local remote:
}

while [ true ]; do
    sync
    inotifywait -t $POLL_INTERVAL_SECONDS --recursive -e modify -e move -e create -e delete /local
done
