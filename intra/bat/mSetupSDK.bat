:user_configuration

:: Path to Flex SDK
:: 	set FLEX_SDK=D:\programs\flashdevelop\Tools\flex4.6_air_3.8
:: set FLEX_SDK=D:\programs\flashdevelop\Tools\flex4.6_newair	
set FLEX_SDK=C:\Users\hantani\Documents\Anodyne 1 Repo\installation files\flex_sdk_4.6

:: Path to Android SDK
set ANDROID_SDK=D:\programs\flashdevelop\Tools\android


:validation
if not exist "%FLEX_SDK%\bin" goto flexsdk
::if not exist "%ANDROID_SDK%\platform-tools" goto androidsdk
goto succeed

:flexsdk
echo.
echo ERROR: incorrect path to Flex SDK in 'bat\mSetupSDK.bat'
echo.
echo Looking for: %FLEX_SDK%\bin
echo.
if %PAUSE_ERRORS%==1 pause
exit

:androidsdk
echo.
echo ERROR: incorrect path to Android SDK in 'bat\mSetupSDK.bat'
echo.
echo Looking for: %ANDROID_SDK%\platform-tools
echo.
if %PAUSE_ERRORS%==1 pause
exit

:succeed
set PATH=%PATH%;%FLEX_SDK%\bin
set PATH=%PATH%;%ANDROID_SDK%\platform-tools

