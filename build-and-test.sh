#!/bin/bash

VERSION=$(cat VERSION)

docker build . -t cpoolerun/geolambda:${VERSION}
docker run --rm -v $PWD:/home/geolambda -it cpoolerun/geolambda:$VERSION package.sh

cd python
docker build . --build-arg VERSION=${VERSION} -t cpoolerun/geolambda:${VERSION}-python
docker run -v ${PWD}:/home/geolambda -it cpoolerun/geolambda:${VERSION}-python package-python.sh

docker run --rm -v ${PWD}/lambda:/var/task -v ${PWD}/../lambda:/opt lambci/lambda:python3.7 lambda_function.lambda_handler '{}'
