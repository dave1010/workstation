# sublime text
if ! which sublime-text-2 > /dev/null; then
    echo "Installing Sublime Text"
    add-apt-repository -y ppa:webupd8team/sublime-text-2
    apt-get update
    apt-get install -y sublime-text
else
    echo "Sublime Text already installed"
fi
