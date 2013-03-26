

# phpstorm
if ! which /usr/local/phpstorm/bin/phpstorm.sh > /dev/null; then
    echo "Installing PhpStorm"
    #PHPSTORM=$(curl http://confluence.jetbrains.net/pages/viewpage.action?pageId=41487696|grep -o 'http[^"]*PhpStorm[^"]*tar.gz'|head -n 1)
    #wget $PHPSTORM
    wget http://download.jetbrains.com/webide/PhpStorm-6.0.tar.gz
    tar xvf PhpStorm*
    rm PhpStorm-*.tar.gz
    mv PhpStorm* /usr/local/phpstorm
else
    echo "PhpStorm already installed"
fi
