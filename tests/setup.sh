# This file should be sourced by all test-scripts
#
# This scripts sets the following:
#   $PASS	Full path to password-store script to test
#   $GPG	Name of gpg executable
#   $KEY{1..5}	GPG key ids of testing keys
#   $TEST_HOME	This folder

. ./sharness.sh

TEST_HOME="$(cd "$(dirname "$SHARNESS_TEST_FILE")/.."; pwd)"

export PASSWORD_STORE_DIR="$SHARNESS_TRASH_DIRECTORY/test-store/"
rm -rf "$PASSWORD_STORE_DIR"
mkdir -p "$PASSWORD_STORE_DIR"
if [[ ! -d $PASSWORD_STORE_DIR ]]; then
	echo "Could not create $PASSWORD_STORE_DIR"
	exit 1
fi

export GIT_DIR="$PASSWORD_STORE_DIR/.git"
export GIT_WORK_TREE="$PASSWORD_STORE_DIR"
git config --global user.email "Pass-Automated-Testing-Suite@zx2c4.com"
git config --global user.name "Pass Automated Testing Suite"


PASS="$TEST_HOME/../src/password-store.sh"
if [[ ! -e $PASS ]]; then
	echo "Could not find password-store.sh"
	exit 1
fi
alias pass="command \"$PASS\""

# Note: the assumption is the test key is unencrypted.
export GNUPGHOME="$TEST_HOME/gnupg/"
chmod 700 "$GNUPGHOME"
GPG="gpg"
which gpg2 &>/dev/null && GPG="gpg2"
alias gpg="command $GPG"

# We don't want to use any running agent.
# We want an agent to appear to pass to be running.
# We don't need a real agent. Hence:
[[ $GPG == "gpg2" ]] && export GPG_AGENT_INFO=" " || unset GPG_AGENT_INFO

KEY1="CF90C77B"  # pass test key 1
KEY2="D774A374"  # pass test key 2
KEY3="EB7D54A8"  # pass test key 3
KEY4="E4691410"  # pass test key 4
KEY5="39E5020C"  # pass test key 5