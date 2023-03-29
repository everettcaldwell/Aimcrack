
local runtimeService = game:GetService("RunService")
local replicationInterface = shared.require("ReplicationInterface")
local characterEvents = shared.require("CharacterEvents")

local function constructViewport()
    local playerGui = PlayerService.LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui

    local viewportFrame = Instance.new("ViewportFrame")
    viewportFrame.Size = UDim2.new(1, 0, 1, 0)
    viewportFrame.BackgroundTransparency = 1
    viewportFrame.Parent = screenGui
    viewportFrame.CurrentCamera = workspace.CurrentCamera
    return viewportFrame
end

local vpFrame = constructViewport()

local function step()
    -- weapon chams
    replicationInterface.operateOnAllEntries(function(player, replicationObject)
        if not replicationObject:isAlive() or player.TeamColor == PlayerService.LocalPlayer.TeamColor then
            return
        end
        local weaponModel = replicationObject:getThirdPersonObject():getWeaponModel():Clone()
        for _, part in ipairs(weaponModel:GetChildren()) do
            part.Color = Color3.new(1,0,0)
        end
        weaponModel.Parent = vpFrame
    end)
end

runtimeService.RenderStepped:Connect(function()
    step()
end)

runtimeService.Stepped:Connect(function()
    for k,v in ipairs(vpFrame:GetChildren()) do
        v:Destroy()
    end
end)

characterEvents.onSpawned:connect(function()
    vpFrame = constructViewport()
end)

