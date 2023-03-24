print("Making folder.")
makefolder(game.PlaceId)
print("Collecting scripts.")
local scripts = getscripts()
local Coros = 0
local Count = 0
local Time = tick()
print("Decompiling scripts.")
for k,v in pairs(scripts) do
   if Coros == 5 then
       repeat
           wait()
       until Coros ~= 5
   end
   coroutine.resume(coroutine.create(function()
       Count = Count + 1
       print("Decompiling",v.Name,Count.."/"..#scripts)
       writefile(game.PlaceId.."/"..v.Name.. " ".. Count.. ".lua",decompile(v))
       Coros = Coros - 1
   end))
   Coros = Coros + 1
end
print("Writing info.md")
writefile(game.PlaceId.."/".. "!info.md","Decompiled ".. game.PlaceId.. ".\n".. Count.. " scripts were decompiled.\nTook ".. math.floor(tick() - Time).. " seconds.")
print("Complete.")