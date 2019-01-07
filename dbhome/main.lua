local cfg = require 'cfg'
local lib = require 'lib'

local m_dis = {}
local mqtt_status = false
local dev_ID = lib.board_id(MAC_ADDRESS)


function dispatch(m,t,pl)
    if pl~=nil and m_dis[t] then
        m_dis[t](m,pl)
    end
end

function cmdfunc(m,pl)
    print("get1: "..pl)
end

m_dis["/radiolog/cmd"] = cmdfunc

print("=== Main ===")

print("devId: "..dev_ID)

m = mqtt.Client("nodemcu1", 60)
m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)
m:on("message", dispatch)
m:on("overflow", function(client, topic, data)
  print(topic .. " partial overflowed message: " .. data )
end)

print(cfg.URL_MQTT)
m:connect(cfg.URL_MQTT, 1883, 0, function(client)
  print("connected")
  client:subscribe("/radiolog/cmd", 0, function(client) print("subscribe success") end)
  mqtt_status = true
end,
function(client, reason)
  print("failed reason: " .. reason)
end)

tmr.alarm(0,10000, 1, function()
  local pl = "time: "..tmr.time()
  if mqtt_status then
    m:publish("/radiolog/"..dev_ID.."/status", "hello", 0, 0)
    m:publish("/radiolog/"..dev_ID.."/timestamp", pl, 0, 0)
  end
end)
