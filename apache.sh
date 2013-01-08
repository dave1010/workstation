
echo "Setting up Apache"

if [ ! -e /etc/apache2/conf.d/name ]; then
    # stop apache erroring when restarting
    echo "ServerName localhost" >> /etc/apache2/conf.d/name
fi

if [ ! -d /var/www/projects ]; then
    mkdir /var/www/projects
    chmod 777 /var/www/projects
    chown $SUDO_USER:$SUDO_USER /var/www/projects
fi
if [ ! -h ~/projects ]; then
    ln -s /var/www/projects ~/projects
    chown $SUDO_USER:$SUDO_USER ~/projects
fi

# apache mods
a2enmod ssl
a2enmod rewrite
a2enmod headers
a2enmod expires
a2enmod vhost_alias

if [ ! -h /etc/apache2/sites-enabled/projects ]; then
    cp $WS/apache/projects /etc/apache2/sites-available/projects 
    a2ensite projects
fi

service apache2 restart

# TODO
# add user to apache group
# setup umask?
# sed -i "s/@@SERVERNAME@@/$SERVERNAME/" /etc/apache2/sites-available/projects

echo "Apache setup complete"
