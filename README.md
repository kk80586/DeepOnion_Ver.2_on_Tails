# DeepOnion_Ver.2_on_Tails
Super easy way to install DeepOnion Wallet Ver. 2.0.2+ on Tails O.S.

The Unofficial Totally Awesome DeepOnion on Tails Install Script :)

The scripts executed below are used to install DeepOnion Wallet V2.0.2+ on Tails O.S.

Using USD$7.00 16GB SanDisk Cruzer Glide retractible slider USB 2.0/3.0 with a fresh install of the 
latest version of Tails (V3.14). I believe you only need 'Personal Data' and 
'Additional Software' turned on in Pesistent volume configuration. I turn on more than that so if
you find something else needs to be on please let me know.

NOTE:At the beginning of the video I say you will not have prep.zip . You will have it and do exactly what I do on the video. Let me know if I should just remove sound from the video.
***************************************************************************************

START HERE:
Open 'Applications' --> 'Favorites' --> 'Terminal'.
Execute these 2 lines:
[CODE]
cd Persitent

wget https://www.dropbox.com/s/sxq88j1jw0b3v3f/prep.zip?dl=0 -O prep.zip
[/CODE]

Double click 'Home' folder (on Desktop) and then 'Persistent' folder.
Right click on prep.zip and click "Extract Here".

Open 'Applications' --> 'Favorites' --> 'Terminal'.
Execute these 3 lines:
[CODE]
chmod +x prep.sh
./prep.sh
./install-DeepOnion.sh
[/CODE]

When blockchain is done downloading (and after every reboot), execute: 
[CODE]
./config-DeepOnion.sh
[/CODE]

You need to keep config-DeepOnion.sh in your Persistent folder. You can delete all other files if you wish.
You may want to delete the blockchain zip file in the .DeepOnion folder. I did not delete it automatically because I like to keep it until I know every thing is working good. In case you did also I left it.


References:
https://deeponion.org/community/threads/official-tails-debian-and-ubuntu-install-guide.39319/    

ferm.conf                  
     [img]https://i.imgur.com/ei3b3Ak.png[/img]
     
wallet-works :)
     [img]https://i.imgur.com/VChCOB8.png[/img]

YOUTUBE:   (video from start to DeepOnion)
part 1  https://youtu.be/T9QqPymUcIY
part 2  https://youtu.be/Cw9UGXxpxlo

PASTEBIN: (To look at scripts)
install-DeepOnion.sh https://pastebin.com/3qUuRzTw
config-DeepOnion.sh  https://pastebin.com/vpjBi93R 
 
If you have any suggestions for improvement on the scripts please voice them below.
If the scripts fail for you please let me know. I have had instances where the connection failed when connecting to a source (so install would fail). If that happens, stop --> take snapshot of terminal showing where it failed --> post it on this thread, and I will try to talk you through steps to continue or post an edited script. 
     
***************************************************************************************     
Special Thanks to @Dragononcrypto @nezero @Bykardinal and many others in the community who have provided instuctions and feedback over the past year. I couldn't have done it without you :) (Seriously)


