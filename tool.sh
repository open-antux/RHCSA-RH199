#!/usr/bin/env bash

case $1 in
  'reset') sudo vagrant destroy -f && sudo vagrant up
    ;;
  'start') sudo vagrant up
    ;;
  'stop') sudo vagrant destroy -f
    ;;
  'workstation') sudo vagrant ssh workstation
    ;;
  *)
    echo "ERROR: Not recognized. Available options: reset, start, stop and workstation"
    ;;
esac
