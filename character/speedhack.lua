local rs = game:GetService("RunService")
local characterEvents = shared.require("CharacterEvents")
local characterInterface = shared.require("CharacterInterface")
local renderstepped = nil

local multiplier = 1
characterEvents.onSpawned:connect(function()
    local characterObject = characterInterface.getCharacterObject()
    renderstepped = rs.RenderStepped:Connect(function()
        characterObject:setWalkSpeedMult(multiplier)
    end)
end)

local function setspeed(speed)
    multiplier = speed
end


characterEvents.onDespawning:connect(function()
    renderstepped:Disconnect()
    renderstepped = nil
end)

getgenv().setspeed = setspeed
