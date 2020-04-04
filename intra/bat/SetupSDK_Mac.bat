:user_configuration

:: Path to Flex SDK
echo In SetupSDK_MAC.bat 
:: This is wrong.
set FLEX_SDK=D:\programs\flashdevelop\Tools\flexsdk


:validation
if not exist "%FLEX_SDK%" goto flexsdk
goto succeed

:flexsdk
echo.
echo ERROR: incorrect path to Flex SDK in 'bat\SetupSDK.bat'
echo.
echo %FLEX_SDK%
echo.
if %PAUSE_ERRORS%==1 pause
exit

:succeed
set PATH=%PATH%;%FLEX_SDK%\bin;D:\Anodyne\Intra\bin

