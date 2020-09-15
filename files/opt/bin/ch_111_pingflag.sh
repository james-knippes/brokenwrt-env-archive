#!/bin/sh

CH110FLAG=$(cat /ch/111/flag111)
nping --icmp --icmp-type 8 --data-string $CH110FLAG --count 1 --interface eth0.111 10.1.11.100
