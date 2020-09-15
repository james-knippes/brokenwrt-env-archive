#!/usr/bin/lua

local file = io.open("/ch/002/flag002", "r")
io.write("Speak, friend, and enter.\n")
io.flush()
local line = io.read()
if line == "Mellon" then
  io.write(file:read("*a"))
else
  io.write("You shall not pass!")
end
io.close()
