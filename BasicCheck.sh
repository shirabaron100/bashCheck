#!/bin/bash

folderName=$1
executable=$2
makeAns="pass"
threadsAns="pass"
memLeakAns="pass"
curentLocation=`pwd`
number=0

cd $folderName
make 
secssesfullMake=$?
 if [ $secssesfullMake -gt 0 ];  #if there is no makefile or the compilation didnt work
  then
    makeAns="fail";
    echo -e "Compilation     Memory Leaks     Trhead race"
    echo       "fail          fail              fail "
    cd $curentLocation &>/dev/null
    exit 7 
else #if there is a makefile,and the compilation work
    makeAns="pass";

    #thread cheak 
    valgrind --tool=helgrind  --error-exitcode=1 ./$executable shift 2 "$@" &>/dev/null
    if [ $? -gt 0 ];
     then
        threadsAns="fail";
        number=$(($number+1));
        else
            threadsAns="pass";

    fi
    # memory leak chack
     valgrind --leak-check=full --error-exitcode=1 ./$executable shift 2 "$@" &>/dev/null
     if [ $? -gt 0 ] ;
     then
        memLeakAns="fail";
        number=$(($number+2));
        else  memLeakAns="pass";
    fi
fi
echo -e "Compilation     Memory Leaks     Trhead race"
echo  "      "     $makeAns  "    "     $memLeakAns "          "    $threadsAns       

cd $curentLocation &>/dev/null
exit $number
