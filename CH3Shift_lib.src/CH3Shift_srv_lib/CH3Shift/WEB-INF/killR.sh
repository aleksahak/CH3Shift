#!/bin/sh
parent_proc=`ps -w -C BATCH -o "%p %a" | grep $1`
if [ $? == 0 ]; then
echo $parent_proc > par_proc
parent_pid=`gawk -F" " '{ print $1 }' par_proc`
child_proc=`ps h -w -C R -o "%p %P %a" | grep "$parent_pid"`
echo $child_proc > chi_proc
child_pid=`gawk -F" " '{ print $1 }' chi_proc`
kill -9 $child_pid
fi

