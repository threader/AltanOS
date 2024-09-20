@echo off

ramd 2037

a:sysrst > NUL
subst r: \ > NUL

rem DLOAD OAKCDROM.SYS /D:MSCD001
mscdex /D:USBCD /L:Q

SMARTDRV /X

ramlbl

a:
copy sysrestv.* r: > NUL

r:
SENSEHD
if errorlevel 65 goto over84
HDOptSet
goto END
:over84
HDOptSet /GE
:END
