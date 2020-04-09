#!/usr/bin/env bash

echo "      _                              _ _
     | |                            | (_)
     | | ___  _   _ _ __ _ __   __ _| |_
 _   | |/ _ \| | | | '__| '_ \ / _\` | | |
| |__| | (_) | |_| | |  | | | | (_| | | |
 \____/ \___/ \__,_|_|  |_| |_|\__,_|_|_|
"

BASE_COMMAND="docker-compose -f docker-compose.builder.yml run --rm"
API_REPOSITORY="git@github.com:WesleyKlop/journali-api.git"
API_FOLDER="journali-api"
FRONTEND_REPOSITORY="git@github.com:WesleyKlop/journali-frontend.git"
FRONTEND_FOLDER="journali-frontend"

case $1 in
init)
    echo " - Initializing repository"
    git clone $API_REPOSITORY $API_FOLDER
    git clone $FRONTEND_REPOSITORY $FRONTEND_FOLDER
    ;;
install)
    echo " - Installing frontend dependencies for the frontend"
    eval "$BASE_COMMAND" install
    ;;
migrate)
    echo " - Migrating database"
    # TODO
    ;;
start)
    echo " - Starting development environment"
    docker-compose up -d
    ;;
stop)
    echo " - Stopping development environment"
    docker-compose down
    ;;
yarn | cargo)
    echo "- Running: $BASE_COMMAND ${*:1}"
    eval "$BASE_COMMAND" "${*:1}"
    ;;
help)
    echo "Available commands:
 - init: Initialize the child repositories
 - install: Intall frontend node dependencies
 - migrate: Migrate the database
 - start: Start the development environment
 - stop: Stop the development environment
 - yarn [command]: Run any yarn command on the frontend environment
 - cargo [command]: Run any cargo command on the api environment
 - help: This command"
    ;;
*)
    echo "Unknown command \"$1\"" 1>&2
    exit 1
    ;;
esac
