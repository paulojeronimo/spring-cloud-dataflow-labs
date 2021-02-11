#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")"

# Exported variables:
export SCDF_LABS=$PWD

cd "$OLDPWD"

# Functions:
scdf-labs() {
	cd "$SCDF_LABS"
}

lab1-dir() {
	scdf-labs
}

# Main:
which wget &> /dev/null || {
	echo "Install wget!"
	return 1
}
case "$OSTYPE" in
  darwin*)
    which gsed &> /dev/null || {
      echo -e "Install gsed!\n$ brew install gnu-sed"
      return 1
    }
    sed() { gsed "$@"; }
    which ggrep &> /dev/null || {
      echo -e "Install ggrep!\n$ brew install grep"
      return 1
    }
    function grep { ggrep "$@"; }
esac
type jdk &> /dev/null && jdk 11
profile=~/.bash_profile
[[ $OSTYPE =~ ^linux ]] && profile=~/.bashrc
functions_sh=$SCDF_LABS/functions.sh
if ! [ -f $profile ] || ! grep -q "^source \"$functions_sh\"$" $profile; then
  echo "source \"$functions_sh\"" >> $profile
  echo "'source \"$functions_sh\"' added to $profile"
fi
