#!/usr/bin/lua
require "socket"

-- set/caclulate delays
local t_dot = 0.6
local t_dash = t_dot * 3
local t_dins = t_dot
local t_dbtw = t_dot * 4 -- should be 3, but its easier do seperate chars this way
local t_dspc = t_dot * 6 -- should be 7, but there is always a t_dot pause after every morse character

-- configure led
local ledp_r = "/sys/class/leds/fritz4040\:red\:info/"
local ledp_g = "/sys/class/leds/fritz4040\:amber\:info/"

-- open fd's for both leds
local led_r_br = io.open(ledp_r .. "brightness","w")
local led_g_br = io.open(ledp_g .. "brightness","w")

-- use sleep from socket lib
local sleep = socket.sleep

-- morse lookup table
local m_trans = {
	a = '.-',
	b = '-...',
	c = '-.-.',
	d = '-..',
	e = '.',
	f = '..-.',
	g = '--.',
	h = '....',
	i = '..',
	j = '.---',
	k = '-.-',
	l = '.-..',
	m = '--',
	n = '-.',
	o = '---',
	p = '.--.',
	q = '--.-',
	r = '.-.',
	s = '...',
	t = '-',
	u = '..-',
	v = '...-',
	w = '.--',
	x = '-..-',
	y = '-.--',
	z = '--..',
	['1'] = '.----',
	['2'] = '..---',
	['3'] = '...--',
	['4'] = '....-',
	['5'] = '.....',
	['6'] = '-....',
	['7'] = '--...',
	['8'] = '---..',
	['9'] = '----.',
	['0'] = '-----',
	[' '] = '|',
}

--[[ morse format string specification
	'.' represents a dot
	'-' represents a dash
	' ' represents space between characters
	'|' represents space between words
	-- all other characters are invalid
--]]


-- funtion table for red led only
local m_send = {
	['.'] = function (n) return blink(n,t_dot,t_dins,led_r_br) end,
	['-'] = function (n) return blink(n,t_dash,t_dins,led_r_br) end,
	[' '] = function (n) return blink(n,nil,t_dbtw,nil) end,
	['|'] = function (n) return blink(n,nil,t_dspc,nil) end,
}

-- function table for red/green mixed mode
local m_send_rg = {
	['.'] = function (n) return blink(n,t_dot,t_dins,led_r_br) end,
    ['-'] = function (n) return blink(n,t_dash,t_dins,led_g_br) end,
    [' '] = function (n) return blink(n,nil,t_dbtw,nil) end,
    ['|'] = function (n) return blink(n,nil,t_dspc,nil) end,
}

-- led helper, whith led as fd
function led_on(led)
	led:write("1")
	led:flush()
end

function led_off(led)
	led:write("0")
	led:flush()
end

-- blink/delay specific led
function blink(n,t_on,t_off,led)
	for i = 1,n do
		if t_on then
			led_on(led)
			sleep(t_on)
			led_off(led)
		end
		if t_off then
			sleep(t_off)
		end
	end
end


-- send morse string in the previously specified format to led
function m_sendm(str)
	for c in str:gmatch"." do
		m_send[c](1)
	end
end

-- send in red/green
function m_sendm_rg(str)
    for c in str:gmatch"." do
        m_send_rg[c](1)
    end
end

-- convert ascii string to morse
function str_to_m(str)
	local out = ""
	for c in str:gmatch"." do
        -- bad code. just don't
		out = out .. m_trans[c] .. ' '
    end
	return out
end


-- init leds
led_off(led_r_br)
led_off(led_g_br)

-- test
flag = "0xmorseflag"
flag_m = str_to_m(flag)
sleep(2)
m_sendm_rg(flag_m)

