#!/bin/bash

SCRIPT_SRC=$(readlink -f "$0" || echo "$0")
RUN_PATH=$(dirname "${SCRIPT_SRC}" || echo .)

BS="\033[1m"
BE="\033[0m"

BIN_PATH='/usr/local/bin'

echo -e "Source path: ${BS}${RUN_PATH}${BE}"
echo -e "Target path: ${BS}${BIN_PATH}${BE}"
echo ''

sudo find -L ${BIN_PATH}/git-* -xtype l -delete

find "${RUN_PATH}" -name 'git-*' -print0 | sort -z | while read -rd $'\0' item
do
    FILE=$(basename "${item}")

    sudo ln -s "${RUN_PATH}/${FILE}" "${BIN_PATH}/${FILE}"
    TEXT="Created link: ${BS}${FILE}${BE}"

    if [[ "${FILE}" = git-flow-* ]]; then
      SHORT='git-'

      IFS='-' read -ra ADDR <<< "${FILE}"
      for i in "${ADDR[@]}"; do
        if [ "${i}" != "git" ]; then
          SHORT="${SHORT}${i:0:1}"
        fi
      done

      sudo ln -s "${BIN_PATH}/${FILE}" "${BIN_PATH}/${SHORT}"
      TEXT="${TEXT} \t\t With short link: ${BS}${SHORT}${BE}"
    fi

    echo -e "${TEXT}"
done
