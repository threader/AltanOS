@echo off
set path=A:\;A:\DOS;Q:\SONY
REM ●● MSCDEX.EXE の行を加えてください ●●
mscdex.exe /d:usbcd /l:q
cd \SONY
INSTALL4.EXE
