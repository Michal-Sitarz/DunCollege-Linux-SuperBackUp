#!/bin/bash

# |===============================================================|
# | This bash script creates and restores backups of directories. |
# | It is menu driven.                                            |
# | The menu options can be run by parameters as well.            |
# | See [H]elp page for more info!                                |
# |===============================================================|
# | Author:  Michal Sitarz       				                  |
# | Contact: me@michalsitarz.com                                  |
# |===============================================================|

echo
echo "Welcome in SuperBackUp app"
echo

# ===============
# functions below
# ===============

# HELP page
function helpPage ()
{
    echo
    echo " ===================================================================="
    echo "            This is the HELP PAGE of SuperBackUp software            "
    echo " ===================================================================="
    echo 
    echo " Use the MENU options to create backup of the directory" 
    echo " of your choice or to restore it in the chosen destination."
    echo
    echo " To create backup, press [C] key in the menu screen. "
    echo " To restore existing backup, press [R] key in the menu screen. "
    echo " To display this Help Page, press [H] key in the menu screen."
    echo ""
    echo " The user have the ability to create or restore the backup"
    echo " without running whole software with menu displayed."
    echo " To do that run the program (SuperBackUp.sh) with proper PARAMETER:"
    echo
    echo " -c to create backup, -r to restore it, -help to display this page."
    echo " Example: ./SuperBackUp.sh -help"
    echo 
    echo " ===================================================================="
    echo "        Copyrights: Michal Sitarz @ SuperSoftWorkS team 2016         "
    echo " ===================================================================="
    echo
}

# CREATE backup script
function createBackup () 
{

echo
echo "==== ===================="
DATE=$(date "+%d-%b-%Y_%H-%M-%S")
echo "Date: $DATE"
echo "==== ===================="
ls
echo "========================================="
echo "Please enter the directory of your choice"
read directory
echo "========================================="
if [ -d $directory ]
then

    tar -czf backup-$directory-$DATE.tar.gz $directory

    ls -R $directory > backup-$directory-$DATE-log.txt

    cd $directory

    i=1
    for item in *

        do
        echo "Item $((i++)) : $item"
        done
    echo

    cd ..
    ls -l *$DATE*.*
    echo "====="
    echo "Done!"
    echo "====="
    echo
else
    echo
    echo "*******************************************"
    echo "!!! -> $directory <- is not a Directory !!!"
    echo "*******************************************"
    echo
fi
}

# RESTORE backup script
function restoreBackup ()
{
    echo
ls
echo "================================"
echo "Please enter filename to restore"
echo "================================"
read fileName
echo

if [ -f $fileName.tar.gz ]
then
    echo "==================================="
    echo "Where you want to extract the file?"
    echo "==================================="    
    read newDirectory
    if [ -d $newDirectory ]
    then
        echo
        echo "Extracting files..."
        echo "..."
        echo "..."
        echo "..."
        echo
    else
        mkdir $newDirectory
        echo
        echo "Creating new directory..."
        echo
        echo "Extracting files..."
        echo "..."
        echo "..."
        echo "..."
        echo
    fi
    
    tar -xzf $fileName.tar.gz -C $newDirectory
    echo "Extracting completed!"
    echo
    find $newDirectory/*
    echo
    echo "====="
    echo "Done!"
    echo "====="
    echo
else
    echo
    echo "******************************************"
    echo "!!! There is no such a file to restore !!!"
    echo "******************************************"
    echo
fi
}

# ================
# end of functions
# ================

# parameter passing for common functionality

if [ "$1" = "-help" ]
then
    helpPage

elif [ "$1" = "-c" ]
then
    createBackup

elif [ "$1" = "-r" ]
then
    restoreBackup

else

# MENU

exit="no"
until [ "$exit" = "yes" ]
do
# displaying MENU
    echo "===================="
    echo "+++  M  E  N  U  +++"
    echo "===================="
    echo " [C]reate Backup"
    echo " [R]estore Backup"
    echo " [Q]uit "
    echo " [H]elp Page"
    echo "===================="
    
    read menuChoice

# choosing MENU option
case "$menuChoice" in

c|C ) 
    createBackup
    exit="no"
    ;;

r|R )
    restoreBackup
    exit="no"
    ;;

h|H ) 
    helpPage
    exit="no"
    ;;

q|Q ) echo
    echo "Thank you for choosing SuperBackUp software"
    echo "                      - SuperSoftWorkS team"
    echo
    exit="yes"
    ;;
    
* ) echo
    echo "**********************************"
    echo "!!! Wrong key pressed !!!"
    echo "Please press the right key of"
    echo "your choice highlighted inside [ ]"
    echo "**********************************"
    echo
    exit="no"
    ;;
    
esac
done
fi