
# phpstorm
if ! which sass > /dev/null; then
    echo "Installing Sass"
    gem install sass
else
    echo "Sass already installed"
fi

#Note: If there is an error you probably need to add the following line 
#export PATH=$PATH:/var/lib/gems/1.8/bin  at the end of your ./bashrc
