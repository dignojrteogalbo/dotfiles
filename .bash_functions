cd() {  
    builtin cd "$@" && ls
}

up() {
    ups=""
    for i in $(seq 1 $1)
    do
        ups=$ups"../"
    done
    cd $ups
}

back() {
    echo "Returned to $(tput setaf 6)$(tput bold)$OLDPWD$(tput sgr0)"
    cd $OLDPWD
}

mkcd() {
  case "$1" in
    */..|*/../) cd -- "$1";; # that doesn't make any sense unless the directory already exists
    /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
    /*) mkdir -p "$1" && cd "$1";;
    */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
    ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
    *) mkdir -p "./$1" && cd "./$1";;
  esac
}