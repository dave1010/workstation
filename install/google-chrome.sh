

# google-chrome
if ! which google-chrome > /dev/null; then
    echo "Installing Google Chrome"
    #apt-get install libgconf2-4 libnss3-1d libxss1
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome*
    apt-get -f install -y
else
    echo "Google Chrome already installed"
fi
