#!/bin/bash
folderName=$1
executeble=$2
curentLocation=`pwd`
cd $folderName
num=0
make &>/dev/null
secssesfullMake=$?
if [ $secssesfullMake -gt 0 ];then
   echo "compilation
   fail"
    exit 7
fi 

valgrind --tool=memcheck --leak-check=full --error-exitcode=3  ./$executeble shift 2 "$@" &>/dev/null
sucseesfullmemory=$?
if [ $sucseesfullmemory -gt 0 ];then 
  smemory="fail"
  num=$(($num+2))
  else
  smemory="pass"
fi

valgrind --tool=helgrind  --error-exitcode=3  ./$executeble shift 2 "$@" &>/dev/null
sucseesfullthread=$?
if [ $sucseesfullthread -gt 0 ];then 
  sthread="fail"
  num=$(($num+1))
  else
  sthread="pass"
fi

  echo "compilation      memory leak       thread race
     pass           $smemory           $sthread "

cd $curentLocation  &>/dev/null
exit $num  
        
