#!/bin/bash -e

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

TOOL_PATH=${1:-${HOME}/.local/bin}

mkdir -p ${TOOL_PATH}
cp -f ${SCRIPT_DIR}/mdwiki.sh ${TOOL_PATH}
cp -f ${SCRIPT_DIR}/style.css ${TOOL_PATH}
cp -f ${SCRIPT_DIR}/template.html ${TOOL_PATH}
cp -f ${SCRIPT_DIR}/back.png ${TOOL_PATH}
