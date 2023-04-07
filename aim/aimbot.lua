local rs = game:GetService("RunService")
local cameraInterface = shared.require("CameraInterface")
local characterEvents = shared.require("CharacterEvents")

local mainCameraObject = nil

local showFov = false
local targetPart = "head"
local fov = 20
local fovRenderColor = Color3.fromRGB(255,255,0)

local function canHit(targetCharacter, targetPart)
    local ignore = { workspace.Terrain, workspace.Ignore, PlayerService.LocalPlayer.Character }
    table.insert(ignore, targetCharacter)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = ignore
    raycastParams.IgnoreWater = true
    
    local dir = targetPart.Position - mainCameraObject._currentCamera.CFrame.Position
    local raycastHit = workspace:Raycast(mainCameraObject._currentCamera.CFrame.Position, dir, raycastParams)
    if raycastHit then
        return false
    else
        return true
    end
end

local function getClosestPlayer()
    local visibleTargets = {}
    for _, enemyPlayer in ipairs(EnemyTeam():GetPlayers()) do
        local tpo, isReady = GetThirdPerson(enemyPlayer)
        if tpo and isReady then
            local character = tpo:getCharacterModel()
            local parts = tpo:getCharacterHash()
            local pos, visible = mainCameraObject._currentCamera:WorldToViewportPoint(parts[targetPart].Position)
            if visible and canHit(character, parts[targetPart]) then
                table.insert(visibleTargets, {part=parts[targetPart], screenCoords = Vector2.new(pos.X, pos.Y)})
            end
        end
    end

    if not visibleTargets then return end

    local closestTarget = visibleTargets[1]
    for k,target in ipairs(visibleTargets) do
        local vecDiff = target.screenCoords - mainCameraObject._currentCamera.ViewportSize/2
        if vecDiff.Magnitude < closestTarget.screenCoords.Magnitude then
            closestTarget = target
        end
    end

    return closestTarget
end

local fovDraws = {}
local renderstepped = nil
local function aimbot(state)
    local function disconnect()
        if renderstepped then
            renderstepped:Disconnect()
            for _,v in pairs(fovDraws) do
                v:Remove()
            end
            fovDraws = {}
        end
    end
    if state then
        disconnect()
        renderstepped = rs.RenderStepped:Connect(function()
            for _,v in pairs(fovDraws) do
                v:Remove()
            end
            fovDraws = {}

            if cameraInterface:getCameraType() == "MainCamera" then
                mainCameraObject = cameraInterface:getActiveCamera()
            else
                return
            end
            local fovRadius = fov/mainCameraObject._currentCamera.FieldOfView*mainCameraObject._currentCamera.ViewportSize.Y/2

            if showFov then
                local circle = Drawing.new("Circle")
                circle.Thickness = 2
                circle.Color = fovRenderColor
                circle.Visible = true
                circle.Radius = fovRadius
                circle.Position = mainCameraObject._currentCamera.ViewportSize/2
                table.insert(fovDraws, circle)
            end

            local target = getClosestPlayer()
            
            if target then
                local relCoords = target.screenCoords-mainCameraObject._currentCamera.ViewportSize/2
                if relCoords.Magnitude < fovRadius then
                    mainCameraObject:setLookVector(target.part.Position - mainCameraObject._currentCamera.CFrame.Position)
                end
            end
        end)
    else
        disconnect()
    end
end

characterEvents.onSpawned:connect(function()
    if cameraInterface:getCameraType() == "MainCamera" then
        mainCameraObject = cameraInterface:getActiveCamera()
    end
end)

characterEvents.onDespawning:connect(function()
    mainCameraObject = nil
end)

Interface.Aimbot = {
    setState = aimbot,
    setFovRenderColor = function(v)
        fovRenderColor = v
    end,
    setTargetPart = function(v)
        targetPart = string.lower(v)
    end,
    setFov = function(v)
        fov = v
    end,
    showFov = function(v)
        showFov = v
    end
}