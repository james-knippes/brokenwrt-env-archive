#!/bin/sh
uci set wireless.wifinet1.disabled='1'
uci set wireless.wifinet2.disabled='0'
uci commit
/etc/init.d/network reload
