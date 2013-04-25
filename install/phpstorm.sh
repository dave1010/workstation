

# phpstorm
if ! which /usr/local/phpstorm/bin/phpstorm.sh > /dev/null; then
    echo "Installing PhpStorm"
    PHPSTORM=$(curl -s -d 'os=linux' http://www.jetbrains.com/phpstorm/download/download_thanks.jsp|grep -o 'http[^"]*PhpStorm[^"]*tar.gz'|head -n 1)
    wget $PHPSTORM
    #wget http://download.jetbrains.com/webide/PhpStorm-6.0.tar.gz
    tar xvf PhpStorm*
    rm PhpStorm-*.tar.gz
    mv /usr/local/phpstorm /tmp/
    mv PhpStorm* /usr/local/phpstorm
else
    echo "PhpStorm already installed"
fi
