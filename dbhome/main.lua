local display = require "tm1640"
local net = require "netmodule"

local dev_ID = "TEST" -- HOSTNAME
-- local OW_PIN = 5
-- local DHT_PIN = 7
-- local SDA, SCL = 2, 1  -- GPIO4, GIOP5

print("=== Main ===")
print("- devId: "..dev_ID)

happy = { 0x3C, 0x42, 0xA5, 0x81, 0xA5, 0x99, 0x42, 0x3C}
frown = { 0x3C, 0x42, 0xA5, 0x81, 0xBD, 0x81, 0x42, 0x3C}
sad =   { 0x3C, 0x42, 0xA5, 0x81, 0x99, 0xA5, 0x42, 0x3C}
diag  = { 0x1,   0x2,  0x4,  0x8, 0x10, 0x20, 0x40, 0x80}
diag2 = { 0x80, 0x40, 0x20, 0x10,  0x8,  0x4,  0x2,  0x1}
cross = { 0x81, 0x42, 0x24, 0x18, 0x18, 0x24, 0x42, 0x81}

display.init(7, 5)
display.brightness(0)
display.write(cross)

function foo(T)
    print(T.ip)
    display.write(happy)
end

net.init(nil, foo, nil)



-- data = { happy, diag, diag2, cross, sad}
-- while 1 do
--     for i = 1, #data, 1 do
--         display.write(data[i])
--         print(i)
--         tmr.delay(1000000)
--     end
-- end

-- local measures = {}

-- ds18b20.setup(OW_PIN)
-- i2c.setup(0, SDA, SCL, i2c.SLOW)
-- bmp085.setup()

-- tmr.alarm(0,2000, 1, function()
    -- ds18b20.read(
    --     function(ind, rom, res, temp, tdec, par)
    --         measures["temp"..ind] = temp
    --     end,{})

    -- local status, temp, humi, temp_dec, humi_dec = dht.read(DHT_PIN)
    -- if status == dht.OK then
    --    measures["humidity"]  = humi
    --    measures["humidityd"]  = humi_dec
    --    measures["temphumi"]  = temp
    --    measures["temphumid"]  = temp_dec
    -- else
    --     print(string.format("DHT error [%d] [%d]",  dht.ERROR_CHECKSUM, dht.ERROR_TIMEOUT))
    -- end

    -- -- measures["pressure"]  = bmp085.pressure()
    -- -- measures["temppress"]  = bmp085.temperature()

    -- for k,v in pairs(measures) do
    --     print(k,v)
    -- end
    -- print("------------")

-- end)


-- local m_dist = {}
-- function dispatch(m,t,pl)
--     if pl~=nil and m_dis[t] then
--         m_dis[t](m,pl)
--     end
-- end
--

--while true do
--    for k,v in pairs(measures) do
--        print(k,v)
--    end
--    print("------------")
--    tmr.delay(2000000)
--end


-- local m_dis = {}
-- local mqtt_status = false

--local cfg = require 'cfg'
-- local lib = require 'lib'

-- function dispatch(m,t,pl)
--     if pl~=nil and m_dis[t] then
--         m_dis[t](m,pl)
--     end
-- end
--
-- function cmdfunc(m,pl)
--     print("get1: "..pl)
-- end
--
-- m_dis["/radiolog/cmd"] = cmdfunc

-- m = mqtt.Client(HOSTNAME, 60)
-- m:on("connect", function(client) print ("connected") end)
-- m:on("offline", function(client) print ("offline") end)
-- m:on("message", dispatch)
-- m:on("overflow", function(client, topic, data)
--   print(topic .. " partial overflowed message: " .. data )
-- end)
--
-- m:connect(cfg.URL_MQTT, 1883, 0, function(client)
--   print("connected")
--   client:subscribe("/radiolog/cmd", 0, function(client) print("subscribe success") end)
--   client:publish("/radiolog/"..dev_ID.."/status", "hello", 0, 0)
--   mqtt_status = true
-- end,
-- function(client, reason)
--   print("failed reason: " .. reason)
-- end)
--
-- tmr.alarm(0,10000, 1, function()
--   if mqtt_status then
--     s = tmr.time() .. ";"
--     -- for i, v in ipairs(lib.temp()) do
--     --     s = s .. i .. ":" .. v .. ";"
--     -- end
--     m:publish("/radiolog/"..dev_ID.."/data", s, 0, 0)
--     m:publish("/radiolog/"..dev_ID.."/status", "bye", 0, 0)
--
--     tmr.alarm(0,1000, 1, function()
--       print("Go to sleep..")
--       node.dsleep(60000000)
--     end)
--   end
-- end)


