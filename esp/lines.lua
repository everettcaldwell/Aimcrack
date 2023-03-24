local rs = game:GetService("RunService")
local camera = workspace.CurrentCamera

local lines = {}
local drawCallback = nil

local lineSettings = {
    color = Color3.fromRGB(255,255,0),
    thickness = 2
}

local function skeleton(parts)
    -- torso -> head
    do
        local line = Drawing.new("Line")
        local v1 = camera:WorldToViewportPoint(parts.torso.Position)
        local v2 = camera:WorldToViewportPoint(parts.head.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(lines, line)
    end
    -- torso -> left arm
    do
        local line = Drawing.new("Line")
        local v1 = camera:WorldToViewportPoint(parts.torso.Position)
        local v2 = camera:WorldToViewportPoint(parts.larm.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(lines, line)
    end
    -- torso -> right arm
    do
        local line = Drawing.new("Line")
        local v1 = camera:WorldToViewportPoint(parts.torso.Position)
        local v2 = camera:WorldToViewportPoint(parts.rarm.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(lines, line)
    end
    -- torso -> left leg
    do
        local line = Drawing.new("Line")
        local v1 = camera:WorldToViewportPoint(parts.torso.Position)
        local v2 = camera:WorldToViewportPoint(parts.lleg.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(lines, line)
    end
    -- torso -> right leg
    do
        local line = Drawing.new("Line")
        local v1 = camera:WorldToViewportPoint(parts.torso.Position)
        local v2 = camera:WorldToViewportPoint(parts.rleg.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(lines, line)
    end
end

local function linesOn()
    print("lines enabled")
    drawCallback = rs.RenderStepped:Connect(function()
        for _,v in pairs(lines) do
            if v then
                v:Remove()
            end
        end
        lines = {}
        for _, enemyPlayer in ipairs(EnemyTeam():GetPlayers()) do
            local tpo, isReady = GetThirdPerson(enemyPlayer)
            if tpo and isReady then
                local parts = tpo:getCharacterHash()
                local _, visible = camera:WorldToViewportPoint(parts.head.Position)
                if visible then
                    skeleton(parts)
                end
            end
        end
    end)
end

local function linesOff()
    print("lines disabled")
    if drawCallback then
        drawCallback:Disconnect()
        for _,v in ipairs(lines) do
            v:Remove()
        end
        lines = {}
    end
end

local function lines(state) 
    if state then linesOn() else linesOff() end 
end

getgenv().LineSettings = lineSettings
getgenv().Lines = lines