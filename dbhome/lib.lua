local Lib = {}

local function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
 end

local function board_id(mac)
  d = split(mac, ':')
  if #d < 6 or d == {} then
    print("Error wrong mac address: "..mac)
    return "Noid"
  end
  return d[4]..d[5]..d[6]
end

Lib.board_id = board_id
Lib.split = split

return Lib
