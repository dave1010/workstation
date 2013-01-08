

##adobe air
#if ! dpkg -l adobeair > /dev/null; then
#    echo "Installing Adobe Air"
#    #wget "http://airdownload.adobe.com/air/lin/download/latest/AdobeAIRInstaller.bin"
#    #chmod u+x AdobeAir*
#    #./AdobeAir*
#    wget "http://update.devolo.com/linux/apt/pool/main/a/adobeair/adobeair_2.6.0.19170_amd64.deb"
#    dpkg -i adobeair*
#else
#    echo "Adobe Air already installed"
#fi
#
##balsamiq
#if ! dpkg -l balsamiq* > /dev/null; then
#    echo "Installing Balsamiq"
#    wget "http://builds.balsamiq.com/b/mockups-desktop/MockupsForDesktop64bit.deb"
#    dpkg -i Mockups*
#else
#    echo "Balsamiq already installed"
#fi
