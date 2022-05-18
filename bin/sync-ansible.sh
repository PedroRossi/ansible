#!/bin/sh
cd $1
git pull
make ansible/$2
exit 0
