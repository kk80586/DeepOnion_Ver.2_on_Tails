# install-DeepOnion.sh
# If you download from pastebin you need to install and run dos2unix on the files.
# This file should be placed in /home/amnesia/Persistent/ and run by user amnesia.
#
# This script automatically installs DeepOnion Wallet Ver.2.0.2 (DV) .deb package from
# the DeepOnion repository. The only interaction required is sudo password about 14 times and
# 2 copy/pastes I started Tails with a very short password for the setup. Your choice.
# 
# I used a 16Gb SanDisk Cruzer Glide slider type USB2.0/3.0 (~$7). A fresh install of 
# latest version of Tails (3.14). 'Personal Data' and 'Additional software' should be 
# turned on in "Configure persistent volume" setup.
# NOTE: I will be testing this with 'Additional software' not turned on as that always worked in the past.
# You should read and somewhat understand this script before running it. Not so much the code
# but the text will help you understand when and why the script will stop and wait for action.
# First section is the commands from: 
# https://deeponion.org/community/threads/official-tails-debian-and-ubuntu-install-guide.39319/
# The next 2 commands sometimes fail to connect and download. Watch output in terminal window
# and if one or both fail just <CTRL-C> and run them manually in the terminal window.
# You can then comment out the 2 lines if you want. Then restart the script. 
read -p " IF EITHER OF THE NEXT 2 COMMANDS FAIL THEN <CRTL-C>.  Press ENTER to continue."
#  
wget http://ppa.deeponion.org.uk/bitcoin.gpg
wget http://ppa.deeponion.org.uk/pgp.key

read -p " <CTRL-C> to quit  OR   Press ENTER to continue."

sudo install -d -m 755 /live/persistence/TailsData_unlocked/apt-sources.list.d
echo "/etc/apt/sources.list.d source=apt-sources.list.d,link" | sudo tee --append /live/persistence/TailsData_unlocked/persistence.conf
echo "deb tor+http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu xenial main" | sudo tee --append /live/persistence/TailsData_unlocked/apt-sources.list.d/deeponion.list
echo "deb [arch=amd64] tor+http://ppa.deeponion.org.uk/debian stretch main" | sudo tee --append /live/persistence/TailsData_unlocked/apt-sources.list.d/deeponion.list
sudo chown root:root /live/persistence/TailsData_unlocked/apt-sources.list.d/deeponion.list
sudo chmod 644 /live/persistence/TailsData_unlocked/apt-sources.list.d/deeponion.list
sudo ln -s /live/persistence/TailsData_unlocked/apt-sources.list.d/deeponion.list /etc/apt/sources.list.d/deeponion.list
echo "deeponion-qt-dv" | sudo tee --append /live/persistence/TailsData_unlocked/live-additional-software.conf
echo "deeponiond-dv" | sudo tee --append /live/persistence/TailsData_unlocked/live-additional-software.conf
## wget http://ppa.deeponion.org.uk/bitcoin.gpg
sudo apt-key add bitcoin.gpg
## wget http://ppa.deeponion.org.uk/pgp.key
sudo apt-key add pgp.key
sudo apt-get update
sudo apt-get install unzip
sudo apt-get install deeponion-qt-dv deeponiond-dv -y
# This section creates directories, DeepOnion.conf, firewall conf and downloads/unzips blockchain.
# **********************************************************************************************
cd /home/amnesia/Persistent/
mkdir /home/amnesia/.config/DeepOnion
mkdir /home/amnesia/Persistent/.DeepOnion/
mkdir /home/amnesia/Persistent/.DeepOnion/wallets/
mkdir /home/amnesia/Persistent/.DeepOnion/conf_files/
mkdir /home/amnesia/Persistent/.DeepOnion/conf_files/ferm/
mkdir /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config
mkdir /home/amnesia/Persistent/.DeepOnion/conf_files/desktop

cd /home/amnesia/Persistent/.DeepOnion/
#  ******** This command does not work yet so we'll do it differently *********
#  Get Fresh Nodes:
#  curl -o DeepOnion.conf https://deeponion.org/conf_file/DeepOnion.conf
#  ****************************************************************************
#  Tor browser will start and open https://deeponion.org/DeepOnion.conf.php
#  
#  Copy (select->right-click->copy) Then close browser. DeepOnion.conf will open. Paste.
read -p " CLOSE BROWSER after selecting required text.  Press ENTER to continue."
/usr/local/lib/tor-browser/firefox.real -allow-remote --class Tor Browser -profile /home/amnesia/.tor-browser/profile.default https://deeponion.org/conf_file/DeepOnion.conf
#  https://deeponion.org/DeepOnion.conf.php
#  download it or copy/paste by executing next 2 lines:
touch DeepOnion.conf
#  
read -p " AFTER COPY/PASTE <CTRL=X> THEN 'y'.       Press ENTER to continue."
nano DeepOnion.conf

#  Copy ferm.conf and edit:
#  !!!!!!!!      BE CAREFUL!! THIS IS THE FIREWALL CONFIG!!     !!!!!!!!!
#  !!  If you make a mistake do not abort install. you can edit later. !! 
cp /etc/ferm/ferm.conf /home/amnesia/Persistent/.DeepOnion/conf_files/ferm/
read -p " CLOSE BROWSER after selecting required text.  Press ENTER to continue."
/usr/local/lib/tor-browser/firefox.real -allow-remote --class Tor Browser -profile /home/amnesia/.tor-browser/profile.default https://deeponion.org/conf_file/DeepOnion.conf https://deeponion.org/community/threads/official-tails-debian-and-ubuntu-install-guide.39319/
#
#  !!!!!!!!    BE CAREFUL!! THIS IS THE FIREWALL CONFIG!!    !!!!!!
read -p " AFTER COPY/PASTE <CTRL=X> THEN 'y'.       Press ENTER to continue."
nano /home/amnesia/Persistent/.DeepOnion/conf_files/ferm/ferm.conf
# # *********************************************************************************************
# This section creates files needed after every reboot in the config-DeepOnion.sh script.
# *********************************************************************************************
echo "[Desktop Entry]" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Version=2.0" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Name=DeepOnion Core" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Comment=Connect to the DeepOnion Tor P2P Network" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Comment[de]=Verbinde mit dem DeepOnion Tor peer-to-peer Netzwerk" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Comment[fr]=DeepOnion, monnaie virtuelle cryptographique pair à pair" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Comment[tr]=DeepOnion, eşten eşe kriptografik sanal para birimi" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Exec=torsocks DeepOnion-qt -datadir=/home/amnesia/Persistent/.DeepOnion" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Terminal=false" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Type=Application" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Icon=deeponion128" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "MimeType=x-scheme-handler/DeepOnion;" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "Categories=Office;Finance;" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
echo "StartupWMClass=DeepOnion-qt" >> /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop
# ******************************************************************************************
cd /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/
touch DeepOnion-Qt.conf
echo "[General]" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo 'addrProxy="127.0.0.1:9050"' >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "bDisplayAddresses=true" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "bImportFinished=true" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "detachDB=false" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "fCoinControlFeatures=true" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "fMinimizeOnClose=true" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "fMinimizeToTray=true" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "fPrintDebugLog=true" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "fUseProxy=false" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "fUseUPnP=true" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "language=" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "nDisplayUnit=0" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "nReserveBalance=0" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "nSocksVersion=5" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "nTransactionFee=0" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
echo "theme=@Invalid()" >> /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
#  
read -p "Blockchain download next. <CTRL-C> to skip.  Press ENTER to continue."
#  Get DeepOnion legacy chain:
#  https://deeponion.org/blockchainlegacy
#  Get V2+ blockchain
cd /home/amnesia/Persistent/.DeepOnion/
wget https://www.dropbox.com/s/dl/pjqmyl6q32g9g56/blockchain_rebased.zip
#  Be sure it is placed in .DeepOnion folder.
#  Execute next line:
unzip -o blockchain_rebased.zip
# ********************************************************************************************
# ***********                     RUN config-DeepOnion.sh SCRIPT                          *************
# 
#

read -p "Congratulations!! You should be ready to start DeepOnion Wallet Ver. 2.0.2-DV on Tails. . Run config-DeepOnion.sh in a terminal. Locate the start icon in the Tails menu, 'Applications' --> 'Office' --> 'DeepOnion Core'.  Press ENTER to continue."
#************************************************************************************************* 
#  
#  ************************************************************************************
#
#  ***                          GENERAL INSTRUCTIONS                                           ***
#
# These instructions are done in the script now but I left then in for reference.
#   ***************************  EDIT FIREWALL FOR DeepOnion   *********************************
#  This is ONE TIME only:
#  Copy pre-edited ferm.conf to allow DeepOnion and execute ferm to take effect
#  Put copy of edited ferm.conf in /home/amnesia/Persistent/.DeepOnion/conf-files/ferm/
#  
#  
#   Insert the following lines into ferm.conf:
#   See Official Instructions: 
#   reference:https://deeponion.org/community/threads/official-tails-debian-and-ubuntu-install-guide.39319/
#
#   *********  below here **************  The first line is a comment. Leave one (#).
#     # White-list access to DeepOnion
#     daddr 127.0.0.1 proto tcp syn dport 9081 {
#         mod owner uid-owner \$amnesia_uid ACCEPT;
#     }
#   **********  above here *************
#   ***************************************************************************************************
#***************                                                   **************** 
#   ****************   SAVE WALLET SETTINGS FOR AFTER REBOOT   ******************
#  This is ONE TIME only:
#  If you make changes to configuration you want to save, you'll need to execute the 
#   command again before rebooting.
#  Copy Wallet configuration of your preferred settings to backup. 
#   cp /home/amnesia/.config/DeepOnion/DeepOnion-Qt.conf /home/amnesia/Persistence/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
#    The first time you run, do setup configuation (coin control, language, theme, etc.) THEN:
#   ************************************************************************************************
#
#***********************  WHEN EVERYTHING ABOVE IS DONE   **************************************
#   START WALLET!! :)
#   ******   Execute ./config-DeepOnion.sh after reboot and BEFORE starting DeepOnion wallet  *******
#   DO NOT START WALLET BEFORE ALL SETUP IS FINISHED!!
#
#    *******************      PUBLIC SERVICE ANNOUNCEMENT    ******************
#    IF YOU MAKE CHANGES TO YOUR PREFERENCES:
#  DON'T FORGET TO SET PREFERENCES AND COPY FILE from /home/amnesia/.config/DeepOnion/DeepOnion-Qt.conf to  /home/amnesia/Persistence/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf
#
#            !!!!!!!!!!!!!!!!!!!!! FINALLY!!!  HERE IT IS !!!!!!!!!!!!!!!!!
###############################################################################################
#**********************************************************************************************
##############          CLICK 'Applications' --> 'Office' --> 'DeepOnion Core'  ###############
#**********************************************************************************************
###############################################################################################
