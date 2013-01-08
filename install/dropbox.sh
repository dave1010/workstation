# dropbox
if ! which dropbox > /dev/null; then
    echo "Installing Dropbox"
    wget "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.4.0_amd64.deb"
    dpkg -i *dropbox*.deb
else
    echo "Dropbox already installed"
fi

#wget -O - "http://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
#add-apt-repository "deb http://linux.dropbox.com/ubuntu precise main"
#apt-get update
#apt-get install -y nautilus-dropbox

