local rs = game:GetService("RunService")
local camera = workspace.CurrentCamera
local drawCallback = nil

local silentSettings = {
    fov = 20,
    fovRingColor = Color3.fromRGB(255,255,0)
}

local function canHit(part)
    local ignoreList = { workspace.Terrain, workspace.Ignore, PlayerService.LocalPlayer, part}

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = ignoreList
    raycastParams.IgnoreWater = true
    
    local dir = part.Position - camera.CFrame.Position
    local raycastHit = workspace:Raycast(camera.CFrame.Position, dir, raycastParams)
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
            local parts = tpo:getCharacterHash()
            local pos, visible = camera:WorldToViewportPoint(parts.head.Position)
            if visible and canHit(parts.head) then
                table.insert(visibleTargets, {part=parts.head, screenCoords = Vector2.new(pos.X, pos.Y)})
            end
        end
    end

    if not visibleTargets then return end

    local closestTarget = visibleTargets[1]
    for k,target in ipairs(visibleTargets) do
        local vecDiff = target.screenCoords - camera.ViewportSize/2
        if vecDiff.Magnitude < closestTarget.screenCoords.Magnitude then
            closestTarget = target
        end
    end

    return closestTarget
end

local fovRings = {}
local function silentOn()
    drawCallback = rs.RenderStepped:Connect(function() 
        for i,v in pairs(fovRings) do
            v:Remove()
        end

        local fovRadius = silentSettings.fov/camera.FieldOfView*camera.ViewportSize.Y/2
        -- drawing
        fovRings = {}
        local circle = Drawing.new("Circle")
        circle.Thickness = 2
        circle.Color = silentSettings.fovRingColor
        circle.Visible = true
        circle.Radius = fovRadius
        circle.Position = camera.ViewportSize/2
        table.insert(fovRings, circle)

        local target = getClosestPlayer()
        
        if target then
            local relCoords = target.screenCoords-camera.ViewportSize/2
            if relCoords.Magnitude < fovRadius then
                mousemoverel(relCoords.X, relCoords.Y)
            end
        end
    end)
end

local function silentOff()
    if drawCallback then 
        drawCallback:Disconnect()
    end
    for i,v in pairs(fovRings) do
        v:Remove()
    end
    fovRings = {}
end

local function silent(state)
    if state then silentOn() else silentOff() end
end

getgenv().SilentSettings = silentSettings
getgenv().Silent = silent