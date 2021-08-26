source test-helpers.sh

MY_BASEPATH=$HOME/dotfiles
GUIX_LOADPATH_MY="$MY_BASEPATH/guix"
GUIX_LOADPATH_QZDL="$GUIX_LOADPATH_MY/qzdl"

cd $MY_BASEPATH

while getopts ":h" option; do
    case $option in
        h)
            help
            exit;;
        l)
            LINT=1 run_test
            exit;;
        \?) # unknown opt
            echo "ERROR: unknown option"
            exit 1;;
    esac
done
help() {
    echo "Test guix config"
    echo
    echo "usage: 'bash test-system.sh'"
    echo "options: -[h|l]"
    echo "h     print this help"
    echo "l     lint $GUIX_LOADPATH_QZDL"

}

test-load-file() {
    FILE=$1
    (
      echo "...TESTING $FILE"
      echo "......LOADING 'GUIX REPL -L $GUIX_LOADPATH_MY $FILE'"
      guix repl -L $GUIX_LOADPATH_MY $FILE \
          && echo "......PASSED: $FILE"
    )
}

run_test() {
  headline "TESTING SYSTEM CONFIGURATION"

  block "BEGIN: GUIX SYSTEM DESCRIBE"
  guix system describe
  block "END: GUIX SYSTEM DESCRIBE"
  delim

  block "BEGIN: GUIX LINT"
  echo "...LINTING $GUIX_LOADPATH_QZDL"
  guix lint -L $GUIX_LOADPATH_QZDL
  block "END: GUIX LINT"
  delim
}

test-load-file .config/guix/qzdl/system/base.scm

test-load-file .config/guix/qzdl/system/minimal.scm

test-load-file $HOME/dotfiles/.config/guix/qzdl/qzdl.scm

test-load-file $HOME/dotfiles/.config/guix/qzdl/services.scm

test-load-file .config/guix/qzdl/rules.scm
