#!/usr/bin/env bash

[[ -f "$MODULE_SETUP_LIST_FILE_PATH" ]] &&	\
cat "$MODULE_SETUP_LIST_FILE_PATH" | xargs -n1 -I {} bash -c "{}";

[[ ! -z "$MACHINE_GRASS" ]] &&							\
[[ ! -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
echo -e "$MACHINE_GRASS\n" | sudo -S apt-get update;

[[ ! -z "$MACHINE_GRASS" ]] &&							\
[[ ! -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
[[ ! -x $(which jq) ]] &&								\
echo -e "$MACHINE_GRASS\n" | sudo -S apt-get install jq --yes;

[[ ! -z "$MACHINE_GRASS" ]] &&							\
[[ ! -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
[[ ! -x $(which sponge) ]] &&							\
echo -e "$MACHINE_GRASS\n" | sudo -S apt-get install moreutils --yes;

[[ ! -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
jq 'del(.dependencies)' "$MODULE_PACKAGE_FILE_PATH" |	\
sponge "$MODULE_PACKAGE_FILE_PATH";

[[ -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
[[ -f "$MODULE_DEPENDENCY_LIST_FILE_PATH" ]] &&			\
[[ -f "$MODULE_PACKAGE_FILE_PATH" ]] &&					\
cp "$MODULE_PACKAGE_FILE_PATH" "$MODULE_PACKAGE_FILE_PATH.backup";

install-dependency( ){
	local MODULE=$1;

	[[ -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
	[[ ! -z "$MODULE" ]] &&									\
	npm install "$MODULE" --no-save --force;

	[[ ! -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
	[[ ! -z "$MODULE" ]] &&									\
	npm install "$MODULE" --save-exact --force;
};

export -f install-dependency;

[[ -f "$MODULE_DEPENDENCY_LIST_FILE_PATH" ]] &&	\
cat "$MODULE_DEPENDENCY_LIST_FILE_PATH" | xargs -n1 -I {} bash -c "install-dependency {}";

npx --yes @volkovasystem/format-package-json-file;

[[ -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
[[ -f "$MODULE_PACKAGE_FILE_PATH.backup" ]] &&			\
mv --force "$MODULE_PACKAGE_FILE_PATH.backup" "$MODULE_PACKAGE_FILE_PATH";

[[ -d "$TRASH_DIRECTORY" ]] &&					\
[[ -f "$MODULE_PACKAGE_LOCK_FILE_PATH" ]] &&	\
mv --force "$MODULE_PACKAGE_LOCK_FILE_PATH" "$TRASH_DIRECTORY";

[[ ! -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] && \
touch "$MODULE_ROOT_DIRECTORY_PATH/setup.lock";

return 0;
