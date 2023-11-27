#!/usr/bin/env bash

[[ -d "$TRASH_DIRECTORY" ]] &&				\
[[ -d "$MODULE_BUILD_DIRECTORY_PATH" ]] &&	\
mv --force "$MODULE_BUILD_DIRECTORY_PATH" "$TRASH_DIRECTORY";

[[ -d "$TRASH_DIRECTORY" ]] &&				\
[[ -d "$MODULE_TEST_DIRECTORY_PATH" ]] &&	\
mv --force "$MODULE_TEST_DIRECTORY_PATH" "$TRASH_DIRECTORY";

[[ -d "$TRASH_DIRECTORY" ]] &&					\
[[ -d "$MODULE_PACKAGE_DIRECTORY_PATH" ]] &&	\
mv --force "$MODULE_PACKAGE_DIRECTORY_PATH" "$TRASH_DIRECTORY";

[[ -d "$TRASH_DIRECTORY" ]] &&					\
[[ -f "$MODULE_PACKAGE_LOCK_FILE_PATH" ]] &&	\
mv --force "$MODULE_PACKAGE_LOCK_FILE_PATH" "$TRASH_DIRECTORY";

npm cache clean --force --loglevel=error;

return 0;
