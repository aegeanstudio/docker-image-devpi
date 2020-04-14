#!/bin/sh

env | grep -i devpi | xargs -I {} echo [ENV] {}

devpi_init() {

  task='devpi-init'

  if [ 'None' != "$DEVPI_INIT_CONFIGFILE" ]; then
    task="$task --configfile=$DEVPI_INIT_CONFIGFILE"
  fi

  task="$task --role=$DEVPI_INIT_ROLE"

  if [ 'None' != "$DEVPI_INIT_MASTER_URL" ]; then
    task="$task --master-url=$DEVPI_INIT_MASTER_URL"
  fi

  task="$task --serverdir=$DEVPI_INIT_SERVERDIR"

  if [ 'None' != "$DEVPI_INIT_STORAGE" ]; then
    task="$task --storage=$DEVPI_INIT_STORAGE"
  fi

  task="$task --keyfs-cache-size=$DEVPI_INIT_KEYFS_CACHE_SIZE"

  if [ 'False' != "$DEVPI_INIT_NO_ROOT_PYPI" ]; then
    task="$task --no-root-pypi"
  fi

  if [ '' != "$DEVPI_INIT_ROOT_PASSWD" ]; then
    task="$task --root-passwd=$DEVPI_INIT_ROOT_PASSWD"
  fi

  if [ 'None' != "$DEVPI_INIT_ROOT_PASSWD_HASH" ]; then
    task="$task --root-passwd-hash=$DEVPI_INIT_ROOT_PASSWD_HASH"
  fi

  echo "[INIT] Running Command:"
  echo "[INIT] $task"
  ${task}
}

if [ ! -f "$DEVPI_INIT_SERVERDIR"/.serverversion ]; then
  devpi_init
else
    echo "[INIT] Skipped Task devpi-init. (File \"$DEVPI_INIT_SERVERDIR/.serverversion\" Already Existed)"
fi

echo "[READY] Running Command:"
echo "[READY] $@"
exec "$@"
