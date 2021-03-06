#
# lib.d/main_source.sh for dex -*- shell-script -*-
#

main_source(){
  local operand="display_help"
  local operand_args=

  __force_flag=false

  if [ $# -eq 0 ]; then
    display_help 2
  else
    set -- $(normalize_flags_first "" "$@")
    while [ $# -ne 0 ]; do
      case $1 in
        -f|--force)       __force_flag=true ;;
        -h|--help)        display_help ;;
        --)               shift ; operand_args="$@" ; break ;;
        -*)               unrecognized_flag $1 ;;
        add)              operand="dex-source-add"
                          __lookup_name="$2"
                          __lookup_url="$3"
                          shift 2
                          ;;
        ls|pull)          operand="dex-source-$1"
                          if [ -z "$2" ]; then
                            __sourcestr='*'
                          else
                            __sourcestr="$2"
                            shift
                          fi
                          ;;
        rm)               operand="dex-source-rm"
                          operand_args="$2"
                          shift
                          ;;
        *)                unrecognized_arg "$1" ;;
      esac
      shift
    done
  fi

  dex-init
  $operand $operand_args
  exit $?
}
