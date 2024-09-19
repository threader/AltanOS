#!/bin/bash
# This is just an initial example
function help() {
cat <<EOF
Usage: inst.osx.sh /Volumes/Install-location /Volumes/Install-source minimal|small|normal|full
Minimal is the base system, and safari, you would be lucky if this works. 
Small has just the things that are probably required to have a functional "Minimal". 
Normal consists of every package you would expect, iChat iTunes Automator, mediafiles etc. 
Full is Normal with the x11 package. 

EOF
}  


TARGET="$1"
SOURCE="$2"

if [ "$TARGET" = "" ]; then
	echo "No target given!"
	help
exit 0 
elif [ ! -d "$TARGET" ]; then
	echo "$TARGET Not a valid target!"
	help
exit 0
fi 
if [ "$SOURCE" = "" ]; then
	echo "No source given!"	
	help
exit 0
	elif [ ! -d "$SOURCE" ]; then
	echo "$SOURCE Not a valid source!"	
	help
exit 0
fi
if [ "$3" = "" ]; then
	echo "Not a valid selection!"
	help
	exit 0
fi

if [ ! -z ""$SOURCE"/BaseSystem.dmg" ]; then
	echo "Could not find BaseSystem.dmg in path given "$SOURCE"" 
	exit 0
fi 

if [ ! -z ""$SOURCE"/System/Installation/Essentials.pkg" ]; then
	echo "Could not find required package in given path "$SOURCE"/System/Installation/Essentials.pkg"
	exit 0
fi 

inst

while test -n "$3"; do 
 case "$3" in
	minimal|min)
		minimal
		shift
		;;
	small|sml)
		small
		shift
		;;
	normal|norm)
		normal
		shift
		;;
	full|ul)
		all
		shift
		;;
		*)
		echo "$3 Not a valid selection"
	help
	exit 0
	;;	
 esac
echo "You have selected to install $3"
$3
done

function inst()
{
# This will not work from an already created usb installer. 
# Todo? Create list of files and cp $list to target? 
asr restore --source ""$SOURCE"/BaseSystem.dmg" --target "$TARGET" 

# After BaseSystem is copied or restored to target
function minimal()
{
installer -pkg "$SOURCE"/System/Installation/BaseSystemBinaries.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/BSD.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/Essentials.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/BaseSystemResources.pkg	-target "$TARGET"
installer -pkg "$SOURCE"/System/Installation/Safari.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/OSInstall.pkg	-target "$TARGET" # Wonder if this can be removed
installer -pkg "$SOURCE"/System/Installation/OSUpgrade.pkg	-target "$TARGET" # Think this can be removed
installer -pkg "$SOURCE"/System/Installation/SIUResources.pkg	-target "$TARGET" 
}
function small()
{
minimal
installer -pkg "$SOURCE"/System/Installation/AdditionalEssentials.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/JavaEssentials.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/JavaTools.pkg	-target "$TARGET" 
}
function normal()
{
small
installer -pkg "$SOURCE"/System/Installation/iCal.pkg	-target "$TARGET"
installer -pkg "$SOURCE"/System/Installation/iChat.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/iTunes.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/Mail.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/AdditionalSpeechVoices.pkg -target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/MediaFiles.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/AddressBook.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/MigrationAssistant.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/Automator.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/DVDPlayer.pkg	-target "$TARGET" 
installer -pkg "$SOURCE"/System/Installation/OxfordDictionaries.pkg	-target "$TARGET" 
}
function full()
{
normal 
installer -pkg "$SOURCE"/System/Installation/X11User.pkg	-target "$TARGET" 
# Add Keka here? 
}
 

#installer -pkg "$SOURCE"/System/Installation/Catalan.pkg	-target "$TARGET" 






# Move files out of the way
mkdir "$TARGET"/System/Library/LaunchDaemons/dis 
mv "$TARGET"/System/Library/LaunchDaemons/com.apple.install.cd.plist "$TARGET"/System/Library/LaunchDaemons/dis 
mv "$TARGET"/System/Library/LaunchDaemons/com.apple.HeadlessStartup.plist "$TARGET"/System/Library/LaunchDaemons/dis 
#Probably not nessesary? 
mkdir "$TARGET"/etc/dis 
mv "$TARGET"/etc/rc.cdrom "$TARGET"/etc/rc.install "$TARGET"/etc/dis
echo "done"
}
