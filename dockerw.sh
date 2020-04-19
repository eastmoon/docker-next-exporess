#!/usr/bin/env bash
set -e

# declare variable
shellDir=${PWD}
PROJECT_NAME=${PWD##*/}
DOCKERW_COMMAND=""
DOCKERW_BC_AGRS=()
DOCKERW_AC_AGRS=()
PROJECT_ENV="dev"

#------------------- declare function -------------------

function help() {
    echo "This is a docker control script with project ${PROJECT_NAME}"
    echo "If not input any command, at default will"
    echo "Options:"
    echo "    --prod            Set with Production environment."
    echo ""
    echo "Command:"
    echo "    up                Startup container with docker-compose."
    echo "    down              Close down all container with docker-compose."
    echo ""
    echo "Run 'dockerw COMMAND --help' for more information on a command."
}

function setting-with-args() {
    for arg in ${@}
    do
        IFS='=' read -ra ADDR <<< "${arg}"
        key=${ADDR[0]}
        value=${ADDR[1]}
        case ${key} in
            "--help")
                DOCKERW_COMMAND="HELP"
                ;;
            "-h")
                DOCKERW_COMMAND="HELP"
                ;;
            "--prod")
                PROJECT_ENV="prod"
                ;;
        esac
    done
}

function docker-prepare() {
    echo "> `date` Create .env for project"
    echo TAG=${PROJECT_NAME} > .env

    echo "> `date` Build docker image by dockerfile"
    docker build --rm -t mongo:${PROJECT_NAME} ./docker/dockerfile/mongo
    docker build --rm -t node:${PROJECT_NAME} ./docker/dockerfile/node
}

function docker-up() {
    docker-prepare

    echo "> `date` Startup docker container instance by docker-compose"
    docker-compose -f ./docker/docker-compose-${PROJECT_ENV}.yml up -d
    if [[ ${PROJECT_ENV} == "dev" ]]
    then
        echo "> `date` Run next deveopment with stdout"
        docker exec -ti node_service_${PROJECT_NAME} bash -l -c "cd /repo && yarn install && yarn development"
    fi
}

function docker-down() {
    echo "> `date` Close docker container instance by docker-compose"
    docker-compose -f ./docker/docker-compose-${PROJECT_ENV}.yml down
}
#------------------- execute script -------------------

# Command Parser
beforeCommand=0
for arg in ${@}
do
    if [ ${beforeCommand} -eq 0 ]
    then
        if [[ ${arg} =~ -+[a-zA-Z1-9]* ]]
        then
            DOCKERW_BC_AGRS+=(${arg})
        else
          DOCKERW_COMMAND=${arg}
          beforeCommand=1
        fi
    else
        DOCKERW_AC_AGRS+=(${arg})
    fi
done
# Execute command
setting-with-args ${DOCKERW_BC_AGRS[@]}
echo "> `date` Execute command : ${DOCKERW_COMMAND}"
case ${DOCKERW_COMMAND} in
    "up")
        docker-up
        ;;
    "down")
        docker-down
        ;;
    "HELP")
        help
        ;;
    *)
        help
        ;;
esac
