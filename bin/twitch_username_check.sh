#!/bin/bash
# Check the availability of names on twitch
__TUCSH_VERSION=1
[ -z "$TUCSH_URL" ] && TUCSH_URL='https://gql.twitch.tv/gql#origin=twilight'
__TUCSH_MAX_WAIT=30
__TUCSH_SLEEP_EVERY=60
__TUCSH_SEARCH_STRING="isUsernameAvailable\":true"

lines=$(tput lines)

if command -v less >/dev/null; then
    defpager="less -R"
elif command -v more >/dev/null; then
    defpager="more"
else
    defpager="cat"
fi

for i in "$@"
do
case $i in
    -n=*|--names=*)
    NAMES_FILE="${i#*=}"
    ;;
    -p=*|--proxy=*)
    PROXY="${i#*=}"
    ;;
    -v|--verbose)
    VERBOSE=YES
    ;;
    -s=*|--speed=*)
    SPEED="${i#*=}"
    ;;
    --default)
    DEFAULT=YES
    ;;
    -h|--help)
    n=${0##*/}
    cat <<EOF
Usage:

    $n [OPTIONS|QUERY]

Options:

    QUERY                   process QUERY and exit

    --help                  show this help
    --names [FILE]
                            list of usernames to process
    --proxy [PROXY]         use proxy

    --verbose
                            verbosity level

    --speed
                            set processing mode of operation
                            * turbo - only used with proxies
                            * fast - barely any rate limiting
                            * safe - random long pauses

EOF
exit 0
;;
    *)
            # unknown option
    ;;
esac
done

prompt="twitch_username_check.sh"
opts=""
input=""

for o; do
    if [ x"$o" != x"${o#-}" ]; then
        opts="${opts}${o#-}"
    else
        input="$input $o"
    fi
done

query=$(echo "$input" | sed 's@ *$@@; s@^ *@@; s@ @/@; s@ @+@g')

installdir="$HOME/.tucsh"

if ! mkdir -p "$installdir"; then
    echo "ERROR: dont have perms to create $installdir"
    return 1
fi

mkdir -p "$installdir/log/"
LOG="$installdir/log/tucsh.log"

fatal() {
    echo "ERROR: $*" >&2
    exit 1
}

_say_what_i_do() {
    [ -n "$LOG" ] && echo "$(date '+[%Y-%m-%d %H:%M%S]') $*" >> "$LOG"

    local this_prompt="\033[0;1;4;32m>>\033[0m"
    printf "\n${this_prompt}%s\033[0m\n" " $* "
}

_say_available() {
    [ -n "$LOG" ] && echo "$(date '+[%Y-%m-%d %H:%M%S]') $*" >> "$LOG"

    local this_prompt="\033[0;3;4;36m[available]\033[0m"
    printf "\n${this_prompt}%s\033[0m\n" " $* "
}

do_query() {
    local query="$*"
    local b_opts=
    local postdata=
    local uri="${TUCSH_URL}"

    echo "Checking $query..."

    declare -a header=('-H' 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0'
        '-H' 'Accept-Language: en-US'
        '-H' 'Content-Type: text/plain;charset=UTF-8'
        '-H' 'Client-Id: kimne78kx3ncx6brgo4mv6wki5h1ko'
        '-H' 'X-Device-Id: hhPXzh14i1FQGbOLzUYTe8xzDFapuQWK'
        '-H' 'Origin: https://www.twitch.tv'
        '-H' 'DNT: 1'
        '-H' 'Referer: https://www.twitch.tv/downloads?no-reload=true'
        '-H' 'Connection: keep-alive'
        '-H' 'Accept: */*')

    postdata='[{"operationName":"UsernameValidator_User","variables":{"username":"'
    postdata+=$query
    postdata+='"},"extensions":{"persistedQuery":{"version":1,"sha256Hash":"fd1085cf8350e309b725cf8ca91cd90cac03909a3edeeedbd0872ac912f3d660"}}}]'

    curl "$b_opts" -s "$uri" "${header[@]}" "--data" "$postdata" > "$TMP1"


    if [ -z "$lines" ] || [ "$(wc -l "$TMP1" | awk '{print $1}')" -lt "$lines" ]; then
        local buff=$(cat "$TMP1")
    else
        ${PAGER:-$defpager} "$TMP1"
    fi

    if [ -z "$buff" ]; then
        _say_what_i_do Error no response returned
        return 0
    else
        if stringinstring "$__TUCSH_SEARCH_STRING" "$buff"; then
            _say_available $query
            return 1
        else
            return 0
        fi
    fi

}

function stringinstring() {
    case "$2" in
       *"$1"*)
          return 0
       ;;
    esac
    return 1
}

TMP1=$(mktemp /tmp/twitch_username_check.sh.XXXXXXXXXXXXX)
trap 'rm -f $TMP1' EXIT

if [ -s "$NAMES_FILE" ]; then
    _say_what_i_do Processing names file
else
    fatal Cannot read names file
fi

sleep_every=$((RANDOM % __TUCSH_SLEEP_EVERY))

declare -i R; R+=1

while read -r line; do
    size=${#line}
    if [ $size -lt 4 ]; then
        continue
    fi

    do_query $line

    R+=1

    if [ $R -gt $sleep_every ] ; then
        sleep_time=$((RANDOM % __TUCSH_MAX_WAIT))
        _say_what_i_do Sleeping for $sleep_time
        sleep $sleep_time
        R=0
        sleep_every=$((RANDOM % __TUCSH_SLEEP_EVERY))
        _say_what_i_do Next sleep is in $sleep_every requests
    fi


done < $NAMES_FILE

_say_what_i_do Done

exit 0
