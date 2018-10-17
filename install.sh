#!/bin/bash

SD_PATH="/etc/systemd/system"

cp -f markdown-wiki.service ${SD_PATH}
cp -f markdown-wiki.timer ${SD_PATH}

systemctl daemon-reload
systemctl enable markdown-wiki.timer
systemctl start markdown-wiki.timer


TOOL_PATH="/opt/clang/markdown-wiki/"

mkdir -p ${TOOL_PATH}
cp -f mdwiki.sh ${TOOL_PATH}
cp -f style.css ${TOOL_PATH}
cp -f template.html ${TOOL_PATH}
cp -f back.png ${TOOL_PATH}
