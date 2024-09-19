#!/bin/sh

hmount /dev/sda2
hattrib -t tbxi -c UNIX :ofboot.b
hattrib -b :
humount

