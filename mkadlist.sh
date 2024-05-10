#!/usr/bin/env bash

# specify which lists to use
hosts=(hosts StevenBlack/hosts)
label=unified
file=ip-dns-static-$label-$(date +%Y%m%d-%H%M).auto.rsc
script='BEGIN { printf("%s", ":do { :local hosts {") } /(127|0).0.0.(1|0)/ { printf("\"%s\";", $2); ++c } END { printf("%s", "}; :foreach host in=$hosts do={ :do { /ip/dns/static add name=$host type=NXDOMAIN comment=" l " } on-error={ :nothing }; }; }") } END { print(c, f) > "/dev/stderr" } '

ls -all ${hosts[*]} && sort ${hosts[*]} | uniq | awk -v l=$label -v f=$file "${script}" > $file
