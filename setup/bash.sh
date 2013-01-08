
echo "Setting up bash stuff"

if [ ! -d ~/bin ]; then
    # bash adds stuff in ~/bin to your path, which is nice
    mkdir ~/bin
fi

if [ ! -d ~/scripts ]; then
    echo "Getting ~/scripts/"
    # this is with write access. could do read only
    sudo -u $SUDO_USER git clone git@github.com:$GITHUB_USERNAME/scripts.git ~/scripts
fi

if [ ! -e ~/.bash_aliases ]; then
    echo "Setting up bash aliases"
    ln -s ~/scripts/aliases.sh ~/.bash_aliases
fi

if ! grep bash_extras ~/.bashrc > /dev/null; then
    # add custom stuff to .bashrc easily
    echo "source ~/scripts/bash_extras" >> ~/.bashrc
fi

if [ ! -d ~/.scm_breeze ]; then
    echo "Setting up scm_breeze"
    sudo -u $SUDO_USER git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
    sudo -u $SUDO_USER ~/.scm_breeze/install.sh
fi
