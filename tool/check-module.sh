#!/usr/bin/env bash

[[ $(cat $MODULE_PACKAGE_FILE_PATH | jq '.private') != true ]] &&	\
npm dist-tag ls "@$MODULE_ORGANIZATION/$MODULE_NAMESPACE_VALUE";

return 0;
