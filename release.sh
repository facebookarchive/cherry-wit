#!/bin/bash

set -x -e

coffee -c index.coffee
npm install -g .
npm publish
