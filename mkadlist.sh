#!/usr/bin/env bash

# specify which lists to use
HOSTS=(hosts/data/adaway.org/hosts hosts/alternates/social-only/hosts)
LABEL=unified
SCRIPT=ip-dns-static-${LABEL}-$(date +%Y%m%d-%H%M) # .auto

# process source lists into script formatted file
FMT='NF {print "add name="$2" type=NXDOMAIN comment=" l}'
for file in ${HOSTS[@]}; do
  [[ -f $file ]] && echo "file: $file: Merged"; grep -e "0\.0\.0\.0" -e "127\.0\.0\.1" $file | awk -v l=${LABEL} "${FMT}" >> ${SCRIPT}
done
(sort ${SCRIPT} | uniq | { echo '/ip/dns/static'; cat; } >> ${SCRIPT}.rsc); wc -lc ${SCRIPT}.rsc; rm ${SCRIPT}
