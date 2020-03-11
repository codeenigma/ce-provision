#!/bin/sh
#
# This script finds and prints authorized SSH public keys in LDAP for the
# username specified as the first argument.
# Forked from https://gist.githubusercontent.com/jirutka/b15c31b2739a4f3eab63/raw/52eab26bf17cf6b01a2b3cd3ee26f034c8cf7ee6/ssh-getkey-ldap
#
set -eu

log() {
	logger -s -t sshd -p "auth.$1" "$2"
}

uid="$1"

if ! expr "$uid" : '[a-zA-Z0-9._-]*$' 1>/dev/null; then
	log err "bad characters in username: $uid"
	exit 2
fi

keys=$(ldapsearch -x -LLL -o ldif-wrap=no "(&(uid=$uid)(sshPublicKey=*))" \
	'sshPublicKey' | sed -n 's/^sshPublicKey:\s*\(.*\)$/\1/p')
keys_count=$(echo "$keys" | grep '^ssh' | wc -l)

log info "Loaded $keys_count SSH public key(s) from LDAP for user: $uid"

echo "$keys"
