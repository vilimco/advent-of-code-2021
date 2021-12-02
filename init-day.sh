#! /usr/local/bin/bash

git checkout main
git pull

cp -rf blank-day day-$1
git checkout -b feature/day-$1
git add .
