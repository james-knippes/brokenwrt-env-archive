#!/usr/bin/lua

local line = io.read()
if line == "plsmorseflag" then
  dofile('/opt/bin/morse_flag.lua')
end
io.close()
