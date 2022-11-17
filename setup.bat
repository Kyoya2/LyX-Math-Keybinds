@echo off
Setlocal EnableDelayedExpansion

set BINDS_FILE_DEST="%appdata%\LyX2.3\bind\user.bind"
set BINDS_FILE_SRC="%~dp0user.bind"

echo Choose a setup type
echo [1] - Replace `user.bind` with the new `user.bind`. Use this if you didn't clone the repository and don't want updates on pull.
echo [2] - Replace `user.bind` with a hardlink to the new `user.bind`. Use this if you cloned the repository and want the file to be automatically updated on pull.
choice /c 12
set setup_type=%errorlevel%

REM Try to delete the current keybind file if it exists
if exist %BINDS_FILE_DEST% (
    choice /c yn /m "Are you sure you want to delete the current keybinds file?"
    if !errorlevel!==2 goto EOF
    del %BINDS_FILE_DEST% /q /f
)

if %setup_type%==1 (
    copy %BINDS_FILE_SRC% %BINDS_FILE_DEST%
) else (
    mklink %BINDS_FILE_DEST% %BINDS_FILE_SRC%
)

echo Please restart LyX for the changes to take effect.