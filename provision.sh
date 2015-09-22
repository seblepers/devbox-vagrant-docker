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
if ( docker --version ) < /dev/null > /dev/null 2>&1; then
    echo "Docker already installed"
else
    curl -sSL https://get.docker.com/ | sh
    usermod -aG docker vagrant
fi

# Install Docker Compose
if ( docker-compose --version ) < /dev/null > /dev/null 2>&1; then
    echo "Docker Compose already installed"
else
    echo "Installing Docker Compose..."
    curl -sSL https://github.com/docker/compose/releases/download/1.4.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    # Install Docker Compose command completion
    su vagrant <<HEREDOC
mkdir -p ~/.zsh/completion
curl -sSL https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
HEREDOC

fi
