#!/bin/bash

if [ $# -gt 0 ]; then
    for USER in "$@"; do
        EXISTING_USER=$(grep -i -w "${USER}" /etc/passwd | cut -d':' -f1)

        if [ "${EXISTING_USER}" = "${USER}" ]; then
            echo "$USER is already present on the machine. Please try another name."
        else
            sudo useradd -m "$USER" --shell /bin/bash
            spec=$(echo '!@#$%^&*()_+' | fold -w1 | shuf | head -1)
            PASSWORD="companyname@${RANDOM}${spec}"

            echo "$USER:$PASSWORD" | sudo chpasswd
            echo "The temporary password for $USER is $PASSWORD"

            sudo passwd -e "$USER"
        fi
    done
else
    echo "Please enter valid parameters."
fi

