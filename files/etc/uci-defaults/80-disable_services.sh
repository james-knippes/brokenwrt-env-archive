#!/bin/sh

/etc/init.d/snmpd disable
/etc/init.d/lldpd disable
/etc/init.d/miniupnpd disable

/etc/init.d/snmpd stop
/etc/init.d/lldpd stop
/etc/init.d/miniupnpd stop

return 0
