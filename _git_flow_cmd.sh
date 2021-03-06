#!/bin/bash

cd $PWD

git_flow_get_name() (   
    TYPE=$1
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    FIND="${TYPE}/"
    REPLACE=""

    echo "${BRANCH/${FIND}/${REPLACE}}"
)

git_flow_cmd_init() {
    TYPE=$1
    COMMAND=$2
    NAME=$3
    
    OPTIONS=""
    for i in $(seq 4 $#); do
        OPTIONS="${OPTIONS} ${!i}"
    done
    
    USAGE="Usage: git-flow-${TYPE} [command] [${TYPE} name] [options]"

    if [ "${COMMAND}" == "" ]; then
        echo "Error: empty command"
        echo ""
        echo "  Commads: list, start, finish, publish, checkout, pull, delete"
        echo ""    
        echo "  ${USAGE}"
        echo ""
    else
        if [ "${NAME}" == "" ] && [ "${COMMAND}" != "list" ]; then
            echo "Error: empty ${TYPE} name"
            echo ""
            echo "  ${USAGE}"
            echo ""
        else
            if [ "${COMMAND}" == "pull" ]; then
                NAME="origin ${NAME}"
            fi

            git flow ${TYPE} ${COMMAND} ${NAME}${OPTIONS}
        fi
    fi
}


