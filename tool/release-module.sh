#!/usr/bin/env bash

npm run reset-hard-module;

[[ -f "$MODULE_ROOT_DIRECTORY_PATH/tool/transform-context-module.sh" ]] &&	\
npm run transform-context-module;

npm run setup-module &&	\
npm run build-module &&	\
npm run test-module;

[[ -f "$MODULE_ROOT_DIRECTORY_PATH/tool/reset-context-module.sh" ]] &&	\
npm run reset-context-module;

npm run clean-module;

return 0;
