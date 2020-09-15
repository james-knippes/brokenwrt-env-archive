#!/usr/bin/lua

local line = io.read()
if line == "..--.." then
  os.execute("/opt/bin/morse_led.lua /ch/121/flag121")
end
io.close()
