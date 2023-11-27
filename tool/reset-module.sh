#!/usr/bin/env bash

npm run clean-module;

npx --yes @volkovasystem/format-package-json-file;

[[ $HARD_RESET_STATUS = true ]] &&						\
[[ -f "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" ]] &&	\
mv --force "$MODULE_ROOT_DIRECTORY_PATH/setup.lock" "$TRASH_DIRECTORY";

[[ $HARD_RESET_STATUS = true ]] &&						\
[[ -f "$MODULE_ROOT_DIRECTORY_PATH/boot.lock" ]] &&		\
mv --force "$MODULE_ROOT_DIRECTORY_PATH/boot.lock" "$TRASH_DIRECTORY";

[[ -d "$TRASH_DIRECTORY" ]] &&											\
[[ -f "$MODULE_ROOT_DIRECTORY_PATH/$MODULE_NAMESPACE_VALUE.js" ]] &&	\
mv --force "$MODULE_ROOT_DIRECTORY_PATH/$MODULE_NAMESPACE_VALUE.js" "$TRASH_DIRECTORY";

reset-backup( ){
	local BACKUP_FILE_PATH="$1";
	local RESTORE_FILE_PATH="$(echo $BACKUP_FILE_PATH | sed s/.backup//g)";

	[[ ! -f "$RESTORE_FILE_PATH" ]] &&	\
	mv --force "$BACKUP_FILE_PATH" "$RESTORE_FILE_PATH";

	[[ -d "$TRASH_DIRECTORY" ]] &&	\
	[[ -f "$BACKUP_FILE_PATH" ]] &&	\
	mv --force "$BACKUP_FILE_PATH" "$TRASH_DIRECTORY";
};

export -f reset-backup;

find *.backup -type f 2>/dev/null |	\
xargs -n1 -I {} bash -c 'reset-backup {}';

reset-template( ){
	local TEMPLATE_FILE_PATH="$1";
	local RESTORE_FILE_PATH="$(echo $TEMPLATE_FILE_PATH | sed s/.template//g)";

	[[ ! -f "$RESTORE_FILE_PATH" ]] &&	\
	cp --force "$TEMPLATE_FILE_PATH" "$RESTORE_FILE_PATH";
};

export -f reset-template;

find *.template -type f 2>/dev/null |	\
xargs -n1 -I {} bash -c 'reset-template {}';

return 0;
