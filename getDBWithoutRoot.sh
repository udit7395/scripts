#!/bin/bash

##For More Information:http://blog.shvetsov.com/2013/02/access-android-app-data-without-root.html
##Script is Written By udit7395
##HOW TO USE: ./getDBWithoutRoot.sh <packagename>

#NOTE: This method doesn't work if application developer has explicitly disabled ability 
#to backup his app by setting android:allowBackup="false" in the application manifest.

if [ -z "$1" ]
  then
    echo "No packagename supplied"
    echo "Input as ----> ./getDBWithoutRoot.sh <packagename>"
else
 	file_name=data.ab
	path=`pwd`/Databases
	mkdir backup
	cd backup
	echo "Do not enter any Password"
	adb backup -f data.ab -noapk $1
	if [ -f data.ab ]; then
	    echo "File found!"
	fi
	dd if=data.ab bs=1 skip=24 | python -c "import zlib,sys;sys.stdout.write(zlib.decompress(sys.stdin.read()))" | tar -xvf -
	cd ..
	echo $path
	rsync --progress backup/apps/$1/db/*.db $path
	rm -rf backup
fi
