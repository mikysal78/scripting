#!/bin/bash

DOM="$1";

if [ -z "${DOM}" ]; then
    echo "Non hai specificato il dominio"
    echo "usa: ./check-dns.sh dominio.tld"
    exit 0 
fi

dig "$DOM" ANY +nostat +nocmd +nocomments
