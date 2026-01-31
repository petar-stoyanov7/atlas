#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
no='\033[0m'

script_dir="$(cd "$(dirname -- "$0")" && pwd)"
cd $script_dir

function echo_g() {
  echo -e "${green}$1${no}"
}
function echo_y() {
  echo -e "${yellow}$1${no}"
}
function echo_r() {
  echo -e "${red}$1${no}"
}

function atlas_help() {
  echo -e "Command syntax atlas.sh <option>"
  echo -e "Options:"
  echo -e "${green}init${no} - Initializes the project, creating an alias for the script"
  echo -e "${green}start (up)${no} - Starts the containers"
  echo -e "${red}stop (down)${no} - Stops the containers"
  echo -e "${yellow}exec(x)${no} [web|mysql] [command] - execute command on a container"
  echo -e "${yellow}connect(c)${no} [web|mysql] [command] - execute command on a container"
}

function atlas_init() {
  echo_g "Initializing project"
  if grep -q atlas ~/.bashrc; then
    echo_r "Removing existing alias"
    sed -i '/atlas/d' ~/.bashrc
  fi
  echo "Creating an alias for the script"
  echo "alias atlas=$script_dir/atlas.sh" >> ~/.bashrc
}

function atlas_start() {
  echo_g "Starting project"
  if [ "$1" == "debug" ] || [ "$1" == "-v" ]; then
    docker-compose up
  else
    docker-compose up -d
  fi
}

function get_container() {
  if [ "$1" == "mysql" ]; then
    container_name=$(grep "MYSQL_NAME" $script_dir/.env |cut -d'=' -f2)
  elif [ "$1" == "web" ]; then
    container_name=$(grep "WEB_NAME" $script_dir/.env |cut -d'=' -f2)
  elif [ "$1" == "elastic" ]; then
    container_name=$(grep "ES_NAME" $script_dir/.env |cut -d'=' -f2)
  elif [ "$1" == "kibana" ]; then
    container_name=$(grep "KIB_NAME" $script_dir/.env |cut -d'=' -f2)
  else
    container_name="$1"
  fi

  docker ps |grep $container_name |cut -d' ' -f1
}

function atlas_connect() {
  container_id=$(get_container "$1")

  docker exec -it "$container_id" /bin/bash
}

function atlas_exec() {
  container_id=$(get_container "$1")

  docker exec -it "$container_id" "$2"
}

if [ "$1" == "init" ]; then
  atlas_init
elif [ "$1" == "up" ] || [ "$1" == "start" ]; then
  atlas_start "$2" "$3" "$4" "$5"
elif [ "$1" == "down" ] || [ "$1" == "stop" ]; then
  docker-compose down --remove-orphans
elif [ "$1" == "connect" ] || [ "$1" == "c" ]; then
  atlas_connect "$2" "$3" "$4" "$5"
elif [ "$1" == "exec" ] || [ "$1" == "x" ]; then
  atlas_exec "$2" "$3" "$4" "$5"
else
  atlas_help
fi