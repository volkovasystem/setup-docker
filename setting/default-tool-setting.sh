#!/usr/bin/env bash

export MODULE_ROOT_DIRECTORY_PATH=$(dirname $(dirname $(realpath "${BASH_SOURCE[-1]}")));
export PLATFORM_ROOT_DIRECTORY_PATH=$(dirname $MODULE_ROOT_DIRECTORY_PATH);

export MODULE_BUNDLE_SETTING_FILE_PATH="$MODULE_ROOT_DIRECTORY_PATH/setting/bundle-webpack-setting.js";
export MODULE_BUNDLE_TOOL_FILE_PATH="$MODULE_ROOT_DIRECTORY_PATH/tool/bundle-webpack-module.sh";

export MODULE_COMPRESS_TOOL_FILE_PATH="$MODULE_ROOT_DIRECTORY_PATH/tool/compress-terser-module.sh";

export MODULE_PACKAGE_FILE_PATH="$MODULE_ROOT_DIRECTORY_PATH/package.json";
export MODULE_PACKAGE_LOCK_FILE_PATH="$MODULE_ROOT_DIRECTORY_PATH/package-lock.json";
export MODULE_PACKAGE_DIRECTORY_PATH="$MODULE_ROOT_DIRECTORY_PATH/node_modules";
export MODULE_BUILD_DIRECTORY_PATH="$MODULE_ROOT_DIRECTORY_PATH/.build";
export MODULE_TEST_DIRECTORY_PATH="$MODULE_ROOT_DIRECTORY_PATH/.test";

export MODULE_SETUP_LIST_FILE_PATH="$MODULE_ROOT_DIRECTORY_PATH/setting/setup.list";
export MODULE_DEPENDENCY_LIST_FILE_PATH="$MODULE_ROOT_DIRECTORY_PATH/setting/dependency.list";

export MODULE_ORGANIZATION="volkovasystem";
export MODULE_NAMESPACE_VALUE="setup-docker";
export MODULE_NAMESPACE_VARIABLE="setupDocker";

export MODULE_BUILD_TARGET_LIST="node";

export TRASH_DIRECTORY=$(mktemp -d);

load-local-environment-setting( ){
	set -o allexport;
	[[ -f "$MODULE_ROOT_DIRECTORY_PATH/.env" ]] &&	\
	source "$MODULE_ROOT_DIRECTORY_PATH/.env";
	set +o allexport;
};

[[ -f "$MODULE_ROOT_DIRECTORY_PATH/.env" ]] &&	\
load-local-environment-setting;

return 0;
