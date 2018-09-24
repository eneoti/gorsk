#!/usr/bin/env bash

set -e
echo "" > coverage.txt

for d in $(go list ./... | grep -v -e internal  -e cmd/api/server -e cmd/api/mw -e cmd/api/request -e cmd/api/swagger -e cmd/api/swaggerui -e cmd/migration); do
    go test -race -coverprofile=profile.out -covermode=atomic "$d" -v
    if [ -f profile.out ]; then
        cat profile.out >> coverage.txt
        rm profile.out
    fi
done