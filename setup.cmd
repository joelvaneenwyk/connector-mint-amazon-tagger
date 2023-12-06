@echo off
call py -3 -m pip install --upgrade pip
call py -3 -m pip install -r "%~dp0requirements\base.txt"
call py -3 -m pip install -r "%~dp0requirements\dev.txt"
call py -3 -m pip install -r "%~dp0requirements\windows.txt"
call py -3 "%~dp0setup.py"
