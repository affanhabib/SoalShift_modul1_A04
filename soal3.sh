#!/bin/bash

    while [ 0 ]
    do
    while
            pass="$(dd if=/dev/urandom|tr -dc A-Za-z0-9|head -c 12)"
            low=0
            upp=0
            num=0
            for char in pass
            do
                if [[ $char == [A-Z] ]]
                    then
                    let upp=$upp+1;
                    fi
                if [[ $char == [a-z] ]]
                    then
                    let low=$low+1;
                    fi
                if [[ $char == [0-9] ]]
                    then
                    let num=$num+1;
                    fi
            done
            [ $upp -gt 0 ] && [ $low -gt 0] && [$num -gt 0]
    do :;done
        i=1
        file=/home/aku/Downloads/SoalShift/pass/password
        while [ -f "$file$i.txt" ]
        do
                value=$(<$file$i.txt)
                if test "$temp" = "$pass"
                then
                        break
                fi
                let i=$i+1
        done
        if test "$temp" = "$pass"
        then
                continue
        fi
        break
        done
        echo "$pass" >$file$i.txt
