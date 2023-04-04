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



characterEvents.onDespawning:connect(function()
    renderstepped:Disconnect()
    renderstepped = nil
end)

if not Interface.Character then -- change check to mt __index
    Interface.Character = {}
end

Interface.Character.SetSpeed = function (v)
    multiplier = v
end
