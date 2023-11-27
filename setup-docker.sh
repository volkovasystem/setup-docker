#!/usr/bin/env bash

set +o history;

SHELL_STATE="$(set +o)";

#; @todo-note: Modify parameter to include flow for optional and required.;
#; @todo-note: Modify to add fallback and handler for optional and required parameter.;

SHORT_PARAMETER_LIST=(	\
	h:					\
);

LONG_PARAMETER_LIST=(	\
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

eval set -- "$PARAMETER";

while true;
do
	case "$1" in
		-h | --help )
			HELP_PROMPT_STATUS=true;
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

[[ -x $(which docker) ]] &&	\
docker ps -aq | xargs docker stop | xargs docker rm;

[[ -x $(which docker) ]] &&	\
sudo docker system prune --all --volumes --force;

sudo apt-get purge		\
containerd				\
containerd.io			\
docker-engine			\
docker					\
docker-ce				\
docker.io				\
docker-ce-cli			\
docker-compose-plugin	\
runc					\
--autoremove			\
--yes;

sudo snap remove docker --purge;

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

sudo groupdel docker;

sudo apt-get autoremove --yes;

sudo apt-get autoclean;

sudo apt-get update;

sudo apt-get install	\
ca-certificates			\
curl					\
gnupg;

sudo install -m 0755 -d /etc/apt/keyrings;

curl -fsSL https://download.docker.com/linux/debian/gpg | \
sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg;

sudo chmod a+r /etc/apt/keyrings/docker.gpg;

echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

sudo apt-get update;

sudo apt-get install	\
docker-ce				\
docker-ce-cli			\
containerd.io			\
docker-buildx-plugin	\
docker-compose-plugin	\
--yes;

sudo usermod -aG docker $USER;

sudo chown -R $USER:docker /var/run/docker.sock;
sudo chmod 660 /var/run/docker.sock;

sudo systemctl restart docker;

set -o history;
