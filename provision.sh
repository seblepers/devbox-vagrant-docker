#!/usr/bin/env bash

apt-get update

apt-get install -y language-pack-fr \
                vim \
                git \
                htop \
                tmux \
                zsh \
                git-core \
                wget \
                curl \
                tree

# Install oh my zsh!
su vagrant <<HEREDOC
wget --no-check-certificate -q https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
sed -i "s/plugins=(git)/plugins=(git rsync docker dirhistory vagrant  n98-magerun composer)/" ~/.zshrc
HEREDOC
chsh -s `which zsh` vagrant


# Install Docker
curl -sSL https://get.docker.com/ | sh
usermod -aG docker vagrant

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/VERSION_NUM/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Docker Compose command completion
su vagrant <<HEREDOC
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
HEREDOC
