#!/bin/bash
# Helpers to more easily work with Docker

# 'attempt to remove the most recent container from docker ps -a'
function docker-remove-most-recent-container() {
  docker ps -ql | xargs docker rm
}

# 'attempt to remove the most recent image from docker images'
function docker-remove-most-recent-image() {
  docker images -q | head -1 | xargs docker rmi
}

# 'attempt to remove exited containers and dangling images'
function docker-remove-stale-assets() {
  docker ps --filter status=exited -q | xargs docker rm --volumes
  docker images --filter dangling=true -q | xargs docker rmi
}

# enter the specified docker container using bash'
# example 'docker-enter oracle-xe'
function docker-enter() {
  docker exec -it "$@" /bin/bash;
}

# 'attempt to remove images with supplied tags or all if no tags are supplied'
function docker-remove-images() {
  if [ -z "$1" ]; then
    docker rmi $(docker images -q)
  else
    DOCKER_IMAGES=""
    for IMAGE_ID in $@; do DOCKER_IMAGES="$DOCKER_IMAGES\|$IMAGE_ID"; done
    # Find the image IDs for the supplied tags
    ID_ARRAY=($(docker images | grep "${DOCKER_IMAGES:2}" | awk {'print $3'}))
    # Strip out duplicate IDs before attempting to remove the image(s)
    docker rmi $(echo ${ID_ARRAY[@]} | tr ' ' '\n' | sort -u | tr '\n' ' ')
 fi
}

# 'attempt to list the environmental variables of the supplied image ID'
function docker-runtime-environment() {
  docker run "$@" env
}