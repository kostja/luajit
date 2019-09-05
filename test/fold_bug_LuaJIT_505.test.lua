#!/usr/bin/env tarantool

tap = require('tap')

test = tap.test("505")
test:plan(1)

-- Test file to demonstrate Lua fold machinery icorrect behavior, details:
--     https://github.com/LuaJIT/LuaJIT/issues/505

jit.opt.start(0, "hotloop=1")
require('jit.dump').start("+bti", "505.trace")
for _ = 1, 20 do
    local value = "abc"
    local pos_c = string.find(value, "c", 1, true)
    local value2 = string.sub(value, 1, pos_c - 1)
    local pos_b = string.find(value2, "b", 2, true)
    assert(pos_b == 2, "FAIL: position of 'b' is " .. pos_b)
end

test:ok("PASS")
