#!/usr/bin/env bash

cd "$(dirname "$0")"

if [ "$1" = clean ]
then
	git clean -dqfX -- .
	exit
fi

c=IT
o='Brainplot CA'
cn=brainplot.io

# Prepare certs directory
mkdir -p -- certs
touch index.txt
[ ! -e serial ] && echo 1000 >serial

create_ca_crt() {
	local cn="$1"
	local key="$cn.key"
	local csr="$cn.csr"
	local crt="$cn.crt"

	[ ! -e "$csr" ] && [ ! -e "$key" ] &&
	openssl req \
		-config openssl.cnf \
		-new \
		-newkey ec \
		-pkeyopt ec_paramgen_curve:P-256 \
		-nodes \
		-subj "/CN=$cn/C=$c/O=$o" \
		-addext "subjectAltName=DNS:$cn" \
		-keyout "$key" \
		-out "$csr"

	[ ! -e "$crt" ] &&
	openssl ca \
		-batch \
		-notext \
		-config openssl.cnf \
		-extensions v3_intermediate_ca \
		-days 3650 \
		-notext \
		-cert ca.crt \
		-keyfile ca.key \
		-in "$csr" \
		-out "$crt"
}

create_ca_crt kubernetes-ca
create_ca_crt etcd-ca
create_ca_crt kubernetes-front-proxy-ca
