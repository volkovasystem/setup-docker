#!/usr/bin/env bash

#	 @license:module:
#	 	MIT License
#
#	 	Copyright (c) 2023-present Richeve S. Bebedor <richeve.bebedor@gmail.com>
#
#	 	@license:copyright:
#	 		Richeve S. Bebedor
#
#	 		<@license:year-range:2023-present;>
#
#	 		<@license:contact-detail:richeve.bebedor@gmail.com;>
#	 	@license:copyright;
#
#	 	Permission is hereby granted, free of charge, to any person obtaining a copy
#	 	of this software and associated documentation files (the "Software"), to deal
#	 	in the Software without restriction, including without limitation the rights
#	 	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#	 	copies of the Software, and to permit persons to whom the Software is
#	 	furnished to do so, subject to the following conditions:
#
#	 	The above copyright notice and this permission notice shall be included in all
#	 	copies or substantial portions of the Software.
#
#	 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#	 	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#	 	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#	 	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#	 	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#	 	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#	 	SOFTWARE.
#	 @license:module;

set +o history;

SHELL_STATE="$(set +o)";

#; @todo-note: Modify parameter to include flow for optional and required.;
#; @todo-note: Modify to add fallback and handler for optional and required parameter.;

SHORT_PARAMETER_LIST=(	\
	r:					\
	h:					\
);

LONG_PARAMETER_LIST=(	\
	resetStatus:,		\
	reset:,				\
	help:				\
);

SHORT_PARAMETER_LIST=$(echo $(IFS='';echo "${SHORT_PARAMETER_LIST[*]// /}";IFS=$' \t\n'));
LONG_PARAMETER_LIST=$(echo $(IFS='';echo "${LONG_PARAMETER_LIST[*]// /}";IFS=$' \t\n'));

PARAMETER="$(						\
getopt								\
--quiet								\
--alternative						\
--options $SHORT_PARAMETER_LIST		\
--longoptions $LONG_PARAMETER_LIST	\
-- "$@"								\
)";

[[ $? > 0 ]] && \
exit 1;

HELP_PROMPT_STATUS=false;
RESET_STATUS=true;

eval set -- "$PARAMETER";

while true;
do
	case "$1" in
		-h | --help )
			HELP_PROMPT_STATUS=true;
			shift 2
			;;
		-r | --reset | --resetStatus )
			[[ "${2,,}" == "false" ]] &&	\
			[[ ! -x $(which docker) ]] &&	\
			RESET_STATUS=false;
			shift 2
			;;
		-- )
			shift;
			break
			;;
		* )
			break
			;;
	esac
done

set +vx; eval "$SHELL_STATE";

TARGET_WORKING_DIRECTORY="$(pwd)";

load-setting( ){
	set -o allexport;
	[[ -f "$TARGET_WORKING_DIRECTORY/.env" ]] &&	\
	source "$TARGET_WORKING_DIRECTORY/.env";
	set +o allexport;
};

[[ -f "$TARGET_WORKING_DIRECTORY/.env" ]] &&	\
load-setting;

[[ -n "$MACHINE_GRASS" ]] &&	\
echo -e "$MACHINE_GRASS\n" | sudo -S apt-get update;

[[ "$RESET_STATUS" = true ]] &&			\
[[ -x $(which docker) ]] &&				\
[[ -n $(echo $(docker ps -aq)) ]] &&	\
docker ps -aq | xargs docker stop | xargs docker rm;

[[ "$RESET_STATUS" = true ]] &&	\
[[ -x $(which docker) ]] &&		\
docker system prune --all --volumes --force;

[[ "$RESET_STATUS" = true ]] &&	\
sudo apt-get purge				\
containerd						\
containerd.io					\
docker-engine					\
docker							\
docker-ce						\
docker.io						\
docker-ce-cli					\
docker-compose-plugin			\
runc							\
--autoremove					\
--yes;

[[ "$RESET_STATUS" = true ]] &&	\
[[ -x $(which snap) ]] &&		\
sudo snap remove docker --purge;

[[ "$RESET_STATUS" = true ]] &&					\
sudo rm -rf										\
/var/lib/docker									\
/var/lib/containerd								\
/etc/docker										\
/etc/apparmor.d/docker							\
/var/run/docker.sock							\
/usr/local/bin/docker-compose					\
/etc/docker										\
~/.docker										\
/usr/share/keyrings/docker-archive-keyring.gpg	\
/etc/apt/keyrings/docker.gpg					\
/etc/apt/sources.list.d/docker.list;

[[ "$RESET_STATUS" = true ]] &&	\
sudo groupdel docker;

[[ "$RESET_STATUS" = true ]] &&	\
sudo apt-get autoremove --yes;

[[ "$RESET_STATUS" = true ]] &&	\
sudo apt-get autoclean;

[[ ! -x $(which docker) ]] &&	\
sudo apt-get install			\
ca-certificates					\
curl							\
gnupg;

[[ ! -x $(which docker) ]] &&	\
sudo install -m 0755 -d /etc/apt/keyrings;

[[ ! -x $(which docker) ]] &&								\
curl -fsSL https://download.docker.com/linux/debian/gpg |	\
sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg;

[[ ! -x $(which docker) ]] &&	\
sudo chmod a+r /etc/apt/keyrings/docker.gpg;

[[ ! -x $(which docker) ]] &&	\
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

[[ ! -x $(which docker) ]] &&	\
sudo apt-get update;

[[ ! -x $(which docker) ]] &&	\
sudo apt-get install			\
docker-ce						\
docker-ce-cli					\
containerd.io					\
docker-buildx-plugin			\
docker-compose-plugin			\
--yes;

sudo usermod -aG docker $USER;

sudo chown -R $USER:docker /var/run/docker.sock;

sudo chmod 660 /var/run/docker.sock;

sudo systemctl restart docker;

set -o history;
