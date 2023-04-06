local firearmObject = shared.require("FirearmObject")

if not Hooks.firearmObject then
    Hooks.firearmObject = {}
end

local recoilx = 0
local recoily = 0

local function norecoil(state)
    if state then
        if not Hooks.firearmObject.new then
            Hooks.firearmObject.new = hookfunction(firearmObject.new, function(...)
               local firearm = Hooks.firearmObject.new(...)
               
               local mt = getrawmetatable(firearm._spreadspring)
               setreadonly(mt, false)
               local oldNewIndex = mt.__newindex
               mt.__newindex = newcclosure(function(self, key, val)
                if key == "a" then
                    if typeof(val) == "Vector3" then
                        local rcsAccel = Vector3.new(val.X*(1-recoily), val.Y*(1-recoilx), val.Z)
                        return oldNewIndex(self, key, rcsAccel)
                    end
                end
                return oldNewIndex(self,key,val)
               end)
               return firearm
            end)
        end
    else
        if Hooks.firearmObject.new then
            hookfunction(firearmObject.new, Hooks.firearmObject.new)
            Hooks.firearmObject.new = nil
        end
    end
    
end

Interface.Rcs = {
    setState = norecoil,
    setRecoilX = function(v)
        recoilx = v
    end,
    setRecoilY = function(v)
        recoily = v
    end,
}