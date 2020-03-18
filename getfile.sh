#!/usr/bin/env bash

set -eu

URI=$* # eg: https:://source.datanerd.us/rad/helm-charts/releases/download/argo-cd-1.8.7/argo-cd-1.8.7.tgz
#PROVIDER=$(echo "$URI" | cut -d/ -f1 | cut -d: -f1) # eg: https
URLPATH=$(echo "$URI" | cut -d: -f3 | cut -c2-) # eg: /fqdn/username/project
HOSTNAME=$(echo "$URLPATH" | cut -d/ -f2) # eg: ghe.example.com
FILE=$(echo "$URLPATH" | rev | cut -d/ -f1 | rev) # eg: kubernetes/helm-chart

# echo $URI -- $PROVIDER -- $HOSTNAME -- $URLPATH -- $HOSTNAME -- $FILE; exit 1

# make a temporary dir
TMPDIR="$(mktemp -q -d /tmp/helm-ghe.XXXXXX)"
cd "$TMPDIR"

if [[ "${HOSTNAME}" == "${HELM_GHE_HOSTNAME}" ]]; then
  curl -sLJO -H "Authorization: token ${HELM_GHE_TOKEN}" "${URI}"
else
  curl -sLJO "${URI}"
fi

if [ -f "$FILE" ]; then # if a file named $FILEPATH exists
  cat "$FILE"
else
  echo "Error in plugin 'helm-ghe': Could not download $FILE" >&2
  exit 1
fi

# remove the temporary dir safely
cd "$TMPDIR"
rm -f ./*
DIR=$(basename "$TMPDIR")
cd /tmp
rmdir "${DIR}"
