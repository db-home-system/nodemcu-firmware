local Lib = {}
local ow_temp_pin = 4 -- GPIO2 D4
local dht_pin = 3 -- GPIO0 D3
local sda, scl = 1, 2  -- GPIO4, GIOP5

local bmp180 = require("bmp180")
local measures = {}

local function init()
--    i2c.setup(0, sda, scl, i2c.SLOW)
    bmp180.init(sda, scl)
    ds18b20.setup(ow_temp_pin)
end

local function temperature()
  ds18b20.read(
    function(ind, rom, res, temp, tdec, par)
        measures["temp"..ind] = temp
    end,{}, 0x28);
end

local function humidity()
    local status, temp, humi, temp_dec, humi_dec = dht.read(dht_pin)
    if status == dht.OK then
       measures["humidity"]  = humi
       measures["humidityd"]  = humi_dec
       measures["humiditytemp"]  = temp
       measures["humiditytempd"]  = temp_dec
    else
        print(string.format("DHT error [%d] [%d]",  dht.ERROR_CHECKSUM, dht.ERROR_TIMEOUT))
    end
end

local function pressure()
    bmp180.read(1)
    local t = bmp180.getTemperature()
    local p = bmp180.getPressure()
    --local p = bmp085.pressure()
    --local t = bmp085.temperature()
    measures["pressure"]  = p
    measures["pressuretemp"]  = t
end

Lib.measInit = init
Lib.measTemp = temperature
Lib.measHumi = humidity
Lib.measPress = pressure

Lib.measures = measures

return Lib
