#!/bin/bash
# Helpers to more easily work with Docker

# attempt to remove the most recent container from docker ps -a
function docker-remove-most-recent-container() {
  docker ps -ql | xargs docker rm
}

# attempt to remove the most recent image from docker images
function docker-remove-most-recent-image() {
  docker images -q | head -1 | xargs docker rmi
}

# attempt to remove exited containers and dangling images
function docker-remove-dangling-images() {
  docker images --filter dangling=true -q | xargs docker rmi
}

function docker-remove-exited-containers() {
  docker ps --filter status=exited -q | xargs docker rm --volumes
}

# enter the specified docker container using bash'
# example 'docker-enter oracle-xe'
function docker-enter() {
  docker exec -it "$@" /bin/bash;
}

# attempt to list the environmental variables of the supplied image ID
function docker-runtime-environment() {
  docker run "$@" env
}

# Shut down, remove and start again the docker-compose setup, then tail the logs
#   param '1: name of the docker-compose.yaml file to use (optional). Default: docker-compose.yaml'
#   example 'docker-compose-fresh docker-compose-foo.yaml'
function docker-compose-fresh() {
  local DCO_FILE_PARAM=""
  if [ -n "$1" ]; then
    echo "Using docker-compose file: $1"
    DCO_FILE_PARAM="--file $1"
  fi

  docker-compose $DCO_FILE_PARAM stop
  docker-compose $DCO_FILE_PARAM rm -f
  docker-compose $DCO_FILE_PARAM up -d
  docker-compose $DCO_FILE_PARAM logs -f --tail 100
}

# function git-delete-merged() {
#   MAIN=${1:-upstream/dev}
#   BRANCHES=$(git branch --merged $MAIN | grep -v develop | grep -v dev | grep -v master | grep -v '*')
#   echo Branches merged into $MAIN:
#   echo $BRANCHES | xargs -n 1
#   read -p "Delete these branches (y/n)? " answer

#   if [ "$answer" = "n" ]; then
#     echo "aborting..."
#   else
#     echo $BRANCHES | xargs -n 1 git branch -d;
#     echo $BRANCHES | xargs -n 1 git push -d origin;
#   fi
# }

function docker-no-restart() {
  docker update --restart=no $(docker ps -a -q)
}

function git-prune() {
  local branch_pattern=${1:-}
  local BRANCHES=$(git for-each-ref --format="%(refname:short)" refs/heads/$branch_pattern*)
  declare -a test_array=($BRANCHES)
  
  for branch in "${test_array[@]}"
  do
    read -p "Delete branch $branch? [Y/n] " answer
    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
      echo "skipping..."
    else
      echo "deleting..."
      __git-rm-branch "$branch"
    fi
    echo
  done
}

function __git-rm-branch() {
  # Assert there is at least one branch provided
  test -z $1 && echo "usage: git-rm-branch <branch> [<branch2> <branch3>...]" 1>&2 && return

  for branch in "$@"
  do
    remote=$(git config branch.$branch.remote || echo "origin")
    ref=$(git config branch.$branch.merge || echo "refs/heads/$branch")

    git branch -D $branch || true
    # Avoid deleting local upstream
    [ "$remote" == "." ] && continue
    git branch -d -r $remote/$branch || continue
    git push --no-verify $remote :$ref
  done
}

function random-string()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}
