#!/usr/bin/env bash

set -Eeo pipefail

OPTS=':n:v:'
SCRIPT_NAME=$(basename $(readlink -nf $0) ".sh")
SCRIPT_DIR=$(dirname $(readlink -f "$0"))
NAME=jenkins-slave
VERSION=latest

show_help()
{
    cat << EOF
Usage: ${SCRIPT_NAME}.sh -n <image_name> -v <image_version> [-h]
Run the installer, with following options:
  -n  image name [default: jenkins-slave]
  -v  image version
  -h  display help

EOF
}

OPTIND=1
while getopts ${OPTS} OPT
do
  case "${OPT}" in
    h)  show_help
        exit 1;;
    n)  NAME=$OPTARG;;
    v)  VERSION=$OPTARG;;
    \?)	# unknown flag
    	show_help
        exit 1;;
  esac
done

shift $(($OPTIND - 1))

trap show_help INT

docker build --no-cache -t "kevinedwards/${NAME}:${VERSION}" ${SCRIPT_DIR}
