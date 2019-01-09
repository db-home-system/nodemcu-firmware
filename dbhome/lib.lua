local Lib = {}
local ow_temp_pin = 1
local devs = {}
local function temp()
  ds18b20.setup(ow_temp_pin)
  ds18b20.read(
    function(ind, rom, res, temp, tdec, par)
        devs[ind] = temp
    end,{}, 0x28);
  return devs;
end

Lib.temp = temp

return Lib
