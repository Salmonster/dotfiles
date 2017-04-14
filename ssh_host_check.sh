#!/bin/bash
NON_WORKING_HOSTS="github.com rax-root"
HOSTS="rax"

for h in $HOSTS
do
  echo
  echo $h
  ssh $h '/bin/true'
  echo $?
done
