local firearmObject = shared.require("FirearmObject")
local function norecoil(state)
    if state then
        if not Hooks.getweaponstat then
            Hooks.getweaponstat = hookfunction(firearmObject.getWeaponStat, function(self, statname)
                local stathooks = {
                    camkickspeed = 0,
                    aimcamkickspeed = 0,
                    hipfirespread = 0,
                    modelkickspeed = 2^31-1,
                }
                if stathooks[statname] then
                    return stathooks[statname]
                end
                local val = Hooks.getweaponstat(self, statname)
                return val
            end)
            -- TODO: Force apply weapon stats
        end
    else
        hookfunction(firearmObject.getWeaponStat, Hooks.getweaponstat)
        Hooks.getweaponstat = nil
    end
end

Interface.Rcs = {
    setState = norecoil
}