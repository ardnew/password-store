#!/bin/bash

# See "INSTALL" for description and possible values, as well as other recognized
# environment variables you may want to configure.
PREFIX="/usr/local/password-store"
WITH_BASHCOMP="yes"
BASHCOMPDIR="${PREFIX}/share/bash"

export PREFIX WITH_BASHCOMP BASHCOMPDIR

fail() { c=${1}; shift; echo "${@}" >&2; exit ${c}; };

# Always make both targets install and test, but invoke them separately for 
# clearer error reporting.
make install || fail $? "error (${?}): install failed"
make test    || fail $? "error (${?}): test failed"
