There are three steps to do to get things working:

0. Download the source code and assets here! Just clone the repo.
1. Get FlashDevelop running - IDE for editing the game
2. Compiling the game (Get Adobe AIR/Flex installed (for compiling the game))
3. (Optional) Compile + Install DAME (Level editor)

Note: I made most of these files available in a google drive folder (in case one of the companies decides to get rid of it in the future): https://drive.google.com/drive/folders/1Ge-tNBqgaz7ZUVeU9RxnWwNbr_JKN4en
Dropbox mirror: https://www.dropbox.com/s/gg8yv1zdip1i9sg/2022%20anodyne%201%20open%20source%20installation%20binaries.zip?dl=0 

----------
1. Get Flash Develop running (IDE for opening/editing the game files - FlashDevelop 5.3.3.exe)
Download here: https://www.flashdevelop.org/community/viewtopic.php?f=11&t=13028

Get Flash Player (flashplayer_32_sa.exe)
Download here: https://www.adobe.com/support/flashplayer/debug_downloads.html

Get Java (jre-8u241-windows-i586.exe)
You want the "Windows Offline" version here: https://java.com/en/download/manual.jsp
Direct link to that exe: https://javadl.oracle.com/webapps/download/AutoDL?BundleId=241534_1f5b5a70bf22433b84d0e960903adac8


---------------------
2. Compiling the Game

NOTE: Steps a, b, c, and e can be skipped by downloading my customized Flex folder (flex_sdk_4.6.zip- it already includes Adobe AIR 32)

NOTE: I downloaded all the libraries to a folder called "installation files"  which is in the same directory level as "intra/".

a. Get the Adobe Air SDK 

(Note there's a lot of stuff on this page - you want "Adobe AIR 32.0.0.116 SDK". NOT THE COMPILER)
https://helpx.adobe.com/air/kb/archived-air-sdk-version.html#
Direct download: http://download.macromedia.com/air/win/download/32.0/AdobeAIRSDK.zip


b. Get Flex Compiler (Anodyne uses some old action script that won't compile in the latest AIR compiler). Download 4.6 from here:
https://www.adobe.com/devnet/flex/flex-sdk-download.html

c. Copy paste the AIR SDK into the flex folder

- Just cut and paste the contents of AdobeAIRSDK into flex_sdk_4.6 

d. point FlashDevelop to this folder

Project > Properties > SDK > Custom SDK > click on the flex_sdk_4.6 folder

e. update java heap space

Edit jvm.config in bin/ of the flex SDK. update the line with java.args to this:

java.args=-Xms1024m -Xmx1024m -Dsun.io.useCanonCaches=false

f. Change the test mode to "Release" in flash develop and click the play button. If all goes well you should get an .swf in the bin/ folder of FlashDevelop. however the game won't run yet!

g. Update the run script paths in SetupSDK.bat (fill out FLEX_SDK with the folder to your flex install, e.g. C:\Users\yourname\Documents\Anodyne 1 Repo\installation files\flex_sdk_4.6

h. The game should work now! If you have issues you may need to verify the game is compiling to SWF version 20 or later or something.

----------
3. Install DAME (Level editor for .dam files that let you export CSV and XML files for the game's tilemap data and enemy placements)

Easy Way
--------
Download DAME_standalone.zip from my google drive folder.

Harder way (Compile from my modified DAME source)
---------- 

1. Download DAME-master-fixed.zip
2. Download flex 3.6 (from here https://www.adobe.com/devnet/flex/flex-sdk-download.html or from my folder as flex_sdk_3.6a.zip)
3. Open the DAME project in flashdevelop
4. hook up flex 3.6 to flashdevelop
5. compile the editor. you should be able to get a SWF. if you have errors see the DAME's README for fixes.
6. Run the PackageApplicationAsExe.bat script. if all is well, the game's exe should pop up under air/DAME 

---------------
Hardest way for cool kids (Compile from original DAME Source)

1. Get DAME source from 
https://github.com/XanderXevious/DAME
2-5. Follow steps 2-5 above.
6. We want to run PackageApplicationAsExe.bat but there's a few things we gotta do first
7. Open CreateCertificate.bat. change the RSA flag to 2048 from 1024. 
7.5 Set CreateCertificate.bat's Flex SDK path to the bin folder of flex 3.6. Run the bat file, it should give you a SelfSigned.pfx file
8. Open PackageApplicationAsExe.bat . Edit the flex path BUT POINT IT TO THE FLEX YOU USED FOR ANODYNE (4.6), with the newer version of AIR and stuff.
9. Update application.xml's xmlns to 3.0 (line 2)
10. Update <version> to <versionNumber> in application.xml
11. In the package script, add this in signing_options, afer "pkcs12":

-tsa "http://sha256timestamp.ws.symantec.com/sha256/timestamp"

12. remove "-C ../DAME samples" from the "set FILE_OR_DIR" line.
13. change AIR_FILE's value to "air/DAME"
14. after %SIGNING_OPTIONS% add "-target bundle"
15. run the packaging script. 
