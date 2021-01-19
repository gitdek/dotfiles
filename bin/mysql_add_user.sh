#!/bin/bash

MaxChars=10
MinChars=8

#MAKEPASSWD_BIN="`perl -le 'print map {(0..9,A..Z,a..z)[rand 62] } map {(0..9)[rand 10]} 0..($MinChars + rand($MaxChars - $MinChars))'`"
MAKEPASSWD_BIN="/usr/bin/makepasswd --maxchars=$MaxChars --minchars=$MinChars" # apt-get install makepasswd. or use perl one-liner.

display_help() {
    echo "Usage: $0 [option...]" >&2
    echo
    echo "   -R,   --randpasswd          generate a strong password to use."
    echo "   -db=, --database=           specify db to give privileges on. can specify '*' or 'all' for every db."
    echo "   -u=,  --user=               myql user to which we can modify users"
    echo "   -v,   --verbose             verbose output"
    echo "   --maxchars=N                generate passwords with at most N characters (default=$MaxChars)."
    echo "   --minchars=N                generate passwords with at least N characters (default=$MinChars)."
    echo
    exit 1
}

# deref Var "arg"
deref(){
    eval "$1=\"$2\""
}

# x=lowercase Arg
lowercase() {
    {
        echo $1
    } | tr  '[:upper:]' '[:lower:]'
}


for i in "$@"
do
    case $i in
        -v|--verbose)
            VERBOSE="y"
            shift
            ;;
        -db=*|--database=*)
            DATABASE="${i#*=}"
            shift
            ;;
        -u=*|--user=*)
            MYSQL_USER="${i#*=}"
            shift
            ;;
        -R|--randpasswd)
            RANDPASSWD="y"
            shift
            ;;
        -h|--help)
            display_help
            ;;
        *)
            # unknown option
            ;;
    esac
done

# echo "verbose='$VERBOSE', randpasswd='$RANDPASSWD', username='$MYSQL_USER', database='$DATABASE', misc: $@"

# Make sure binary exists.
if [ "$RANDPASSWD" == "y" ]; then
    # [ -f "$MAKEPASSWD_BIN" ] || { echo >&2 ERROR: $MAKEPASSWD_BIN does not exists. ; exit 1; }
    [ -f "$MAKEPASSWD_BIN" ] || { echo >&2 ERROR: $MAKEPASSWD_BIN does not exists You must specify a password. ; deref RANDPASSWD "n"; }
fi


if [ ! $DATABASE ]; then
    read -p "Please Enter Database Name:" DATABASE
fi

# Check if given database exists, unless a wildcard is supplied.

if [[ "$DATABASE" =~ ^(\*|all)$ ]] || [[ $( mysql -Bse 'use $DATABASE' > /dev/null 2>&1 ) -eq 0 ]]; then
    echo "Database [$DATABASE] is OK."
else
    echo >&2 "Error: The Database: $DATABASE does not exist, please specify a database that exists."
    exit 1
fi

# Username...
read -p "Please enter the username you wish to create: " username

# Allowed host...
read -p "Please Enter Host To Allow Access:[%, ip, or hostname]: " host


if [ "$RANDPASSWD" == "y" ]; then

    # generate password.
    password=$($MAKEPASSWD_BIN)

    echo $password
    # do not mask the password since it is generated.
    HIDDEN="$password"

else
    #ask user about password
    echo -n "Please Enter the Password for User [$username]: "
    read -s password
    echo

    # mask the password for stdout
    HIDDEN=$(echo $password | sed -r 's/[a-z]{1,4}/\*\*\*\*/g')
fi

query="GRANT ALL PRIVILEGES ON $DATABASE.* TO $username@'$host' IDENTIFIED BY '$HIDDEN'";

read -p "Executing Query : $query , Please Confirm (Y/n) : " Confirm

deref Confirm $(lowercase $Confirm)

if [[ $Confirm =~ ^(y|yes)$ ]]; then

    mysql -e "$query"
    mysql -e "FLUSH PRIVILEGES"

else

    echo >&2 "Aborted."
    exit 1;

fi

echo "Done."

