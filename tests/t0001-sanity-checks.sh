#!/bin/bash

test_description='Sanity checks'
. ./setup.sh

test_expect_success 'Make sure we can run pass' '
	pass --help | grep "pass: the standard unix password manager"
'

test_expect_success 'Make sure we can initialize our test store' '
	pass init $KEY1 &&
	[[ -e "$PASSWORD_STORE_DIR/.gpg-id" ]] &&
	[[ $(cat "$PASSWORD_STORE_DIR/.gpg-id") == "$KEY1" ]]
'

test_done