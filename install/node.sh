
# http://nodejs.org/ (also includes https://npmjs.org/ )

if ! which node > /dev/null; then
    echo "Installing Node"
	sudo apt-get install -y python-software-properties python g++ make
	sudo add-apt-repository -y ppa:chris-lea/node.js
	sudo apt-get update
	sudo apt-get install -y nodejs
else
    echo "Node already installed"
fi

which jshint > /dev/null || npm install -g jshint

