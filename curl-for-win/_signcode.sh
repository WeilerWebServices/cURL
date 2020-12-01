#!/bin/sh

# Copyright 2016-present Viktor Szakats <https://vsz.me/>
# See LICENSE.md

if [ -f "${CODESIGN_KEY}" ] && \
   ls "$(dirname "$0")/osslsigncode-local"* >/dev/null 2>&1; then

  _ref="$1"
  shift

  case "${_OS}" in
    bsd|mac) unixts="$(TZ=UTC stat -f '%m' "${_ref}")";;
    *)       unixts="$(TZ=UTC stat --format '%Y' "${_ref}")";;
  esac

  # Add code signature
  for file in "$@"; do
  (
    echo "Code signing: '${file}'"
    set +x
    # -ts 'https://freetsa.org/tsr'
    "$(dirname "$0")/osslsigncode-local" sign -h sha256 \
      -in "${file}" -out "${file}-signed" \
      -st "${unixts}" \
      -pkcs12 "${CODESIGN_KEY}" -pass "${CODESIGN_KEY_PASS}"
    mv -f "${file}-signed" "${file}"
  )
  done
fi
