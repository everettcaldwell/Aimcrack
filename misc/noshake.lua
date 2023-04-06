local mainCameraObject = shared.require("MainCameraObject")

if not Hooks.mainCameraObject then
    Hooks.mainCameraObject = {}
end

local function noshake(state)
    if state then
        if not Hooks.mainCameraObject.shake then
            Hooks.mainCameraObject.shake = hookfunction(mainCameraObject.shake, function(...)
                return
            end)
        end
    else
        if Hooks.mainCameraObject.shake then
            hookfunction(mainCameraObject.shake, Hooks.mainCameraObject.shake)
        end
    end
    
end

if not Interface.Misc then 
    Interface.Misc = {}
end
Interface.Misc.Noshake = noshake