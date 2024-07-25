::@echo off
call cd C:\workspace\chromium\src
call gn clean out\Release
call git pull --rebase
call gclient sync -D
call ninja -C out\Release services_unittests chrome mini_installer

call git rev-parse HEAD > commitid
call set /p wholecommitid=<commitid
call set currentcommitid=%wholecommitid:~0,7%

call set srcfolder=C:\Users\webnn\Desktop\%currentcommitid%\win_x64
call mkdir %srcfolder%
call set cw32folder=C:\Users\webnn\Desktop\%currentcommitid%\chrome-win32
call mkdir %cw32folder%
call copy out\Release\services_unittests.exe %cw32folder%
call copy out\Release\ui_test.pak %cw32folder%

call "C:\Program Files\7-Zip\7z.exe" x out\Release\chrome.7z -y -o%cw32folder%
call cd  %cw32folder%
call "C:\Program Files\7-Zip\7z.exe" a %srcfolder%\chrome-win32.zip *
call cd ..
call rmdir /s /q %cw32folder%

call "c:\Program Files\nodejs\node.exe" c:\workspace\daifeng\gen_md5\main.js %srcfolder%\chrome-win32.zip

call scp -r C:\Users\webnn\Desktop\%currentcommitid% webnn@xxxxx:~/project/webnn/nightly_chromium/

