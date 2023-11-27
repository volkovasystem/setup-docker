#!/usr/bin/env bash

[[ -f "$MODULE_BUNDLE_SETTING_FILE_PATH" ]] &&	\
npm install --global --silent webpack &&		\
npm install --global --silent webpack-cli  &&	\
webpack build --config "$MODULE_BUNDLE_SETTING_FILE_PATH";
