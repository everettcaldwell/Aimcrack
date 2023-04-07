local firearmObject = shared.require("FirearmObject")

if not Hooks.firearmObject then
    Hooks.firearmObject = {}
end

local rcsX = 0
local rcsY = 0

local rcsEnable = false
Hooks.firearmObject.new = hookfunction(firearmObject.new, function(...) -- static hook, reverts only on unload
    local firearm = Hooks.firearmObject.new(...)
    
    local mt = getrawmetatable(firearm._spreadspring)
    setreadonly(mt, false)
    local oldNewIndex = mt.__newindex
    mt.__newindex = newcclosure(function(self, key, val)
        if key == "a" then
            if typeof(val) == "Vector3" then
                local rcsAccel = Vector3.new(rcsEnable and val.X*(1-rcsY) or val.X, rcsEnable and val.Y*(1-rcsX) or val.Y, val.Z)
                return oldNewIndex(self, key, rcsAccel)
            end
        end
        return oldNewIndex(self,key,val)
    end)
   return firearm
end)

local function noshake(state)
    if state then
        if not Hooks.firearmObject.getWeaponStat then 
            Hooks.firearmObject.getWeaponStat = hookfunction(firearmObject.getWeaponStat, function(self, name)
                local stats = {
                    camkickmin = 0,
                    camkickmax = 0,
                    aimcamkickmin = 0,
                    aimcamkickmax = 0,
                }
                if stats[name] ~= nil then
                    return stats[name]
                end
                return Hooks.firearmObject.getWeaponStat(self, name)
            end)
        end
    else
        if Hooks.firearmObject.getWeaponStat then
            hookfunction(firearmObject.getWeaponStat, Hooks.firearmObject.getWeaponStat)
            Hooks.firearmObject.getWeaponStat = nil
        end
    end
end

Interface.Rcs = {
    setState = function(v)
        rcsEnable = v
    end,
    setRecoilX = function(v)
        rcsX = v
    end,
    setRecoilY = function(v)
        rcsY = v
    end,
    Noshake = noshake,
}