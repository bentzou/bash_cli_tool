#!/usr/bin/env bash

function public_method_no_args () {
   # public_method_no_args
   echo "This method is displayed in the menu."
}

function public_method_args () {
   # public_method_args arg1 arg2
   echo "This method is displayed in the menu and has args."
}

private_method () {
   # private_method
   echo "This method is not displayed in the menu."
}

###############################################################################

function usage () {
   # usage
   echo -e "Usage: $(basename $0) [command] [args...]\n"
   awk '/^function/ && !/main/ {getline; $1=""; print "  "$0}' $0 | sort
}

function main () {
   if (( $# == 0 )); then
      usage
   else
      for fxn in $(awk '/^function/ && !/main/ {print $2}' $0); do
         if [[ $fxn = "$1" ]]; then $@; return $?; fi
      done

      usage
      return 1
   fi
}

[ "$(basename $0 2>/dev/null)" = "$(basename $0)" ] && main "$@"
