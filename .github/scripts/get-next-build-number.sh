#!/bin/bash

PREFIX='releases/'
LASTRELEASETAG=$(git tag -l $PREFIX* --sort=-creatordate | head -n 1)
LASTBUILD=${LASTRELEASETAG:9}
LASTBUILDBETTER=${LASTBUILD%??} #temp
NEXTBUILD=$((LASTBUILDBETTER + 1))
echo $NEXTBUILD
