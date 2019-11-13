#!/bin/bash
let abspath
let files

exit_on_processing(){
    echo "exit while processing, function.${1}"
    exit 0
}

check_is_dir(){
    echo "dirname? ${1}"
    if [ -d ${1} ]
    then
        cd ${1}
        abspath=`pwd`
        return 0
    else
        while :;do
        read dirname
        if [ -z $dirname ] || [ $dirname == "q" ] 
        then
            exit_on_processing $FUNCNAME
        fi
        if [ -d $dirname ]
        then
            cd $dirname
            abspath=`pwd`
            return 0
        else
            echo "not folder. type again,"
        fi
    done
fi
}

find_files(){
    founds=`find ${1} -iname "*${2}*"`
    files=($founds)
    while :;do
        echo "$files founds and ${3} to be modded. go on?(y, n)"
        read check
        if [ ${check} == "y" ]
        then
            return 0
        elif [ ${check} == "n" ]
        then
            exit_on_processing $FUNCNAME
        else
            continue
        fi
    done 
}

chmod_files(){ 
    for file in ${files[@]}
    do
        echo $file
        sudo chmod ${1} $file 
    done
    echo "all done."
}

pre_error_handler(){
    echo "$*, $# arguments provided." #all argument from inside
    if [ $# == 4 ] && [ ${4} == "fin" ]
    then
        return 0
    else
        exit_on_processing $FUNCNAME
    fi
}

main(){
    # pre-error handler
    pre_error_handler $* "fin"
    check_is_dir $*
    echo "path: $abspath"
    find_files ${abspath} ${2} ${3} 
    chmod_files ${3}
}
#main $* "fin" #all arguments from command line
main $*
exit 0
