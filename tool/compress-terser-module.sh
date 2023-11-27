#!/usr/bin/env bash

[[ -f "$MODULE_BUILD_DIRECTORY_PATH/$MODULE_NAMESPACE_VALUE.bundle.js" ]] &&	\
npx --yes																		\
terser "$MODULE_BUILD_DIRECTORY_PATH/$MODULE_NAMESPACE_VALUE.bundle.js"			\
--compress defaults=false,dead_code=false,side_effects=false,unused=false		\
--keep-classnames																\
--keep-fnames																	\
--comments '/^\;\!/'															\
--output "$MODULE_BUILD_DIRECTORY_PATH/$MODULE_NAMESPACE_VALUE.js";
