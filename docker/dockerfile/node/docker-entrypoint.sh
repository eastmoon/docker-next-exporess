cd /repo
if [ ${DOCKER_MODE} ] && [ ${DOCKER_MODE} = "dev" ]
then
    yarn install
    tail -f /dev/null
else
    yarn install
    yarn build
    yarn start
fi
