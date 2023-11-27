#!/usr/bin/env bash

[[ ! -d "$MODULE_BUILD_DIRECTORY_PATH" ]] &&	\
mkdir -p "$MODULE_BUILD_DIRECTORY_PATH";

npm run bundle-module &&	\
npm run compress-module &&	\
npm run resolve-module;

return 0;
