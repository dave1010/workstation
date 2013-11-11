# sublime text


if ! which /usr/bin/subl > /dev/null; then
    echo "Installing Sublime Text"
    	add-apt-repository -y ppa:webupd8team/sublime-text-3
    	apt-get update
    	apt-get install -y sublime-text-installer
    
	# install from http://www.sublimetext.com/3
	#wget $(curl -s http://www.sublimetext.com/3 | grep 'Ubuntu 64 bit' | grep -Po 'ht[^"]+' | grep deb)
	#dpkg -i sublime-text*.deb

	# old PPA only has ST2
    #add-apt-repository -y ppa:webupd8team/sublime-text-2
    #apt-get update
    #apt-get install -y sublime-text
else
    echo "Sublime Text already installed"
fi
