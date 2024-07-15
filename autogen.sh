#!/bin/sh
if test -f isl/autogen.sh; then
	(cd isl; ./autogen.sh)
fi
if test -f pet/autogen.sh; then
	(cd pet; ./autogen.sh)
fi

echo -e "\n*** Running autotools on osl ***"
if test -f osl/autogen.sh; then
	(cd osl; ./autogen.sh)
fi

echo -e "\n*** Running autotools on cJSON ***"
if test -f cjson/autogen.sh; then
	(cd cjson; ./autogen.sh)
fi

autoreconf -i
