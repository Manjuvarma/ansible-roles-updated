#!/bin/bash

SOURCE_DIR=/opt/app                                        # Source project directory
DJANGO_DIR="${SOURCE_DIR}/src"                             # Django project directory
DJANGO_SETTINGS_MODULE=hydrostats_api.settings             # which settings file should Django use
VIRTUALENV_DIR="${SOURCE_DIR}/env"                         # VirtualEnv Path
CELERY_BIN=$VIRTUALENV_DIR/bin/celery                      # Celery Binary

CELERY_APP="hydrostats_api"                                # Application Name
CELERY_AUTOSCALE="9,5"                                     # max_concurrency,min_concurrency

# Activate the virtual environment
cd $DJANGO_DIR
source $VIRTUALENV_DIR/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGO_DIR:$PYTHONPATH

echo "Starting CELERY Worker"
OPTS=" -A ${CELERY_APP} worker -l info --pool solo"
echo "${OPTS}"
$CELERY_BIN $OPTS
