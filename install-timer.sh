#!/bin/bash -e

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

SD_PATH="/etc/systemd/system"

cp -f ${SCRIPT_DIR}/markdown-wiki.service ${SD_PATH}
cp -f ${SCRIPT_DIR}/markdown-wiki.timer ${SD_PATH}

systemctl daemon-reload
systemctl enable markdown-wiki.timer
systemctl start markdown-wiki.timer
