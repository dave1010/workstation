if ! which java > /dev/null; then
    echo "Installing Oracle Java"
    # license needs confirming
    add-apt-repository -y ppa:webupd8team/java
    apt-get update
    apt-get install -y oracle-java7-installer
else
    echo "Java already installed"
fi