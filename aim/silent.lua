local rs = game:GetService("RunService")
local cameraInterface = shared.require("CameraInterface")
local characterInterface = shared.require("CharacterInterface")
local characterEvents = shared.require("CharacterEvents")
local contentDatabase = shared.require("ContentDatabase")
local weaponControllerInterface = shared.require("WeaponControllerInterface")
local playerDataStoreClient = shared.require("PlayerDataStoreClient")
local activeLoadoutUtils = shared.require("ActiveLoadoutUtils")
local playerDataUtils = shared.require("PlayerDataUtils")
local firearmObject = shared.require("FirearmObject")

local mainCameraObject = nil

local silentSettings = {
    enabled = true,
    targetPart = "head",
    fov = 20,
    fovRingColor = Color3.fromRGB(255,255,0)
}

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
            local pos, visible = mainCameraObject._currentCamera:WorldToViewportPoint(parts[silentSettings.targetPart].Position)
            if visible and canHit(character, parts[silentSettings.targetPart]) then
                table.insert(visibleTargets, {part=parts[silentSettings.targetPart], screenCoords = Vector2.new(pos.X, pos.Y)})
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

local fovRings = {}
local renderstepped = nil
local function silent(state)
    local function disconnect()
        if renderstepped then
            renderstepped:Disconnect()
            for i,v in pairs(fovRings) do
                v:Remove()
            end
            fovRings = {}
        end
    end
    if state then
        disconnect()
        renderstepped = rs.RenderStepped:Connect(function() 
            for i,v in pairs(fovRings) do
                v:Remove()
            end

            local fovRadius = silentSettings.fov/mainCameraObject._currentCamera.FieldOfView*mainCameraObject._currentCamera.ViewportSize.Y/2
            -- drawing
            fovRings = {}
            local circle = Drawing.new("Circle")
            circle.Thickness = 2
            circle.Color = silentSettings.fovRingColor
            circle.Visible = true
            circle.Radius = fovRadius
            circle.Position = mainCameraObject._currentCamera.ViewportSize/2
            table.insert(fovRings, circle)

            local target = getClosestPlayer()
            
            if target then
                local relCoords = target.screenCoords-mainCameraObject._currentCamera.ViewportSize/2
                if relCoords.Magnitude < fovRadius then
                    --mousemoverel(relCoords.X, relCoords.Y)
                    mainCameraObject:setLookVector(target.part.Position - mainCameraObject._currentCamera.CFrame.Position)
                end
            end
        end)
    else
        disconnect()
    end
end

local function norecoil(state)
    if state then
        Hooks.weapondatafunc = hookfunction(firearmObject.getWeaponStat, function(self, statname)
            local stathooks = {
                camkickspeed = 0,
                aimcamkickspeed = 0,
                hipfirespread = 0,
                modelkickspeed = 2^31-1
            }
            if stathooks[statname] then
                return stathooks[statname]
            end
            return Hooks.weapondatafunc(self, statname)
        end)
        weaponControllerInterface.spawn(activeLoadoutUtils.getActiveLoadoutData(playerDataStoreClient.getPlayerData()), playerDataUtils.getAttLoadoutData(playerDataStoreClient.getPlayerData())) -- Forces another weapon data query so that our hooked values are applied
    end
end

characterEvents.onSpawned:connect(function()
    if silentSettings.enabled then
        if cameraInterface:getCameraType() == "MainCamera" then
            mainCameraObject = cameraInterface:getActiveCamera()
            silent(true)
        end
    end
end)
characterEvents.onDespawning:connect(function()
    if silentSettings.enabled then silent(false) end
end)

getgenv().norecoil = norecoil
getgenv().SilentSettings = silentSettings