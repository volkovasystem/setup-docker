#!/usr/bin/env bash

set-template( ){
	local MODULE_FILE_PATH="$1";
	local TEMPLATE_FILE_PATH="$MODULE_FILE_PATH.template";

	local MODULE_FILE_SHASUM="$(sha256sum "$MODULE_FILE_PATH" | cut -d ' ' -f 1)";
	local TEMPLATE_FILE_SHASUM="$(sha256sum "$TEMPLATE_FILE_PATH" | cut -d ' ' -f 1)";

	[[ "$MODULE_FILE_SHASUM" != "$TEMPLATE_FILE_SHASUM" ]] &&	\
	[[ -f "$MODULE_FILE_PATH" ]] &&								\
	cp --force "$MODULE_FILE_PATH" "$TEMPLATE_FILE_PATH";
};

export -f set-template;

find *.module.* -type f ! \( -name '*.template' \) 2>/dev/null |	\
xargs -n1 -I {} bash -c 'set-template {}';

find *.run.* -type f ! \( -name '*.template' \) 2>/dev/null |	\
xargs -n1 -I {} bash -c 'set-template {}';

return 0;
