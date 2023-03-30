
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

local renderstepped = nil
local stepped = nil
local onSpawned = nil
local function weaponchams(state)
    if state then
        if not renderstepped then
            renderstepped = runtimeService.RenderStepped:Connect(function()
                step()
            end)
            stepped = runtimeService.Stepped:Connect(function()
                for k,v in ipairs(vpFrame:GetChildren()) do
                    v:Destroy()
                end
            end)
            onSpawned = characterEvents.onSpawned:connect(function()
                vpFrame = constructViewport()
            end)
        end
    else
        if renderstepped then renderstepped:Disconnect() end
        if stepped then stepped:Disconnect() end
        if onSpawned then onSpawned:Disconnect() end
        renderstepped = nil
        stepped = nil
        onSpawned = nil
    end
end

getgenv().weaponchams = weaponchams