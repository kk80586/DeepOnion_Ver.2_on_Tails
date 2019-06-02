# config-DeepOnion.sh
# If you download this file from pastebin you need to install and run dos2unix on file.
# This script needs to be run after each reboot and before you start Wallet
# If Wallet is not connecting shutdown and run this script then start Wallet.
# If you lose your settings after reboot likely forgot to copy /home/amnesia/.config/DeepOnion-Qt.conf
# to /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/  after settings change.
# Execute next line after Settings changes.
# cp /home/amnesia/.config/DeepOnion-Qt.conf /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/
# *******************************************************************************************
mkdir /home/amnesia/.config/DeepOnion/
cp /home/amnesia/Persistent/.DeepOnion/conf_files/dot-config/DeepOnion-Qt.conf /home/amnesia/.config/DeepOnion/DeepOnion-Qt.conf
sudo cp /home/amnesia/Persistent/.DeepOnion/conf_files/ferm/ferm.conf /etc/ferm/
sudo ferm /etc/ferm/ferm.conf
sudo cp /home/amnesia/Persistent/.DeepOnion/conf_files/desktop/deeponion-qt-dv.desktop /usr/share/applications/deeponion-qt-dv.desktop
