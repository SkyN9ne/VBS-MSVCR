@echo off
set "Path=%ProgramFiles%\7-Zip;%Path%"
cd /d "%~dp0"
set "_d="
if exist "2005\x64\*.msi" set "_d=%_d% 2005\"
if exist "2008\x64\*.msi" set "_d=%_d% 2008\"
if exist "2010\x64\*.msi" set "_d=%_d% 2010\"
if exist "2012\x64\*.msi" set "_d=%_d% 2012\"
if exist "2013\x64\*.msi" set "_d=%_d% 2013\"
if exist "2022\x64\*.msi" set "_d=%_d% 2022\"
if exist "vbc\*.msi" set "_d=%_d% vbc\"
if exist "vstor\*x64.msi" set "_d=%_d% vstor\"
if exist "ucrt\*x64.mum" set "_d=%_d% ucrt\"
if not defined _d (
echo Error: None of the required directories is found
pause
exit /b
)
if exist "ARP.cmd" set "_d=%_d% ARP.cmd"
if exist "Installer.cmd" set "_d=%_d% Installer.cmd"
if exist "Uninstaller.cmd" set "_d=%_d% Uninstaller.cmd"
set /a rnd=%random%
if exist VisualCppRedist_AIO_x86_x64.exe ren VisualCppRedist_AIO_x86_x64.exe zVisualCppRedist_AIO_x86_x64_%rnd%.exe
attrib -A .\* /S /D
7z.exe a VisualCppRedist_AIO_x86_x64.7z ^
-mqs -mx -m0=BCJ2 -m1=LZMA:d26 -m2=LZMA:d19 -m3=LZMA:d19 -mb0:1 -mb0s1:2 -mb0s2:3 -bso0 ^
%_d%
copy /b 7zSfxMod.sfx + 7zSfxConfig.txt + VisualCppRedist_AIO_x86_x64.7z VisualCppRedist_AIO_x86_x64.exe && (
attrib -A .\VisualCppRedist_AIO_x86_x64.exe
del /f /q VisualCppRedist_AIO_x86_x64.7z
)
pause
exit /b
