local runService = game:GetService("RunService")
local characterInterface = shared.require("ReplicationInterface")
local hudNameTagInterface = shared.require("HudNameTagInterface")
local hudNameTagObject = shared.require("HudNameTagObject")

local camera = workspace.CurrentCamera

local lineSettings = {
    color = Color3.fromRGB(255,255,0),
    thickness = 2
}
local drawstack = {}
local function skeleton(parts)
    local v1 = camera:WorldToViewportPoint(parts.torso.Position)
    -- torso -> head
    do
        local line = Drawing.new("Line")
        local v2 = camera:WorldToViewportPoint(parts.head.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(drawstack, line)
    end
    -- torso -> left arm
    do
        local line = Drawing.new("Line")
        local v2 = camera:WorldToViewportPoint(parts.larm.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(drawstack, line)
    end
    -- torso -> right arm
    do
        local line = Drawing.new("Line")
        local v2 = camera:WorldToViewportPoint(parts.rarm.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(drawstack, line)
    end
    -- torso -> left leg
    do
        local line = Drawing.new("Line")
        local v2 = camera:WorldToViewportPoint(parts.lleg.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(drawstack, line)
    end
    -- torso -> right leg
    do
        local line = Drawing.new("Line")
        local v2 = camera:WorldToViewportPoint(parts.rleg.Position)
        line.Color = lineSettings.color
        line.Thickness = lineSettings.thickness
        line.Visible = true
        line.From = Vector2.new(v1.X, v1.Y)
        line.To =  Vector2.new(v2.X, v2.Y)
        table.insert(drawstack, line)
    end
end

local function box(parts)
    -- cross product
    local baseoffset = Vector3.new(0,1,0)
    local vhead = Vector3.new(0,4,0)+baseoffset
    local base = (parts.lleg.Position + parts.rleg.Position)/2-baseoffset
    local screendir = camera.CFrame:VectorToWorldSpace(Vector3.new(1,0,0)) -- right vector
    local xfactor = 1.4
    -- anchors
    local basel = camera:WorldToViewportPoint(base-screendir*xfactor)
    local baser = camera:WorldToViewportPoint(base+screendir*xfactor)
    local head = camera:WorldToViewportPoint(base+vhead)

    -- left edge
    do
        local line = Drawing.new("Line")
        line.Color = Color3.new(0,0,1)
        line.Thickness = 1
        line.Visible = true
        line.From = Vector2.new(basel.X, basel.Y)
        line.To =  Vector2.new(basel.X, head.Y)
        table.insert(drawstack, line)
    end

    -- right edge
    do
        local line = Drawing.new("Line")
        line.Color =  Color3.new(0,0,1)
        line.Thickness = 1
        line.Visible = true
        line.From = Vector2.new(baser.X, baser.Y)
        line.To =  Vector2.new(baser.X, head.Y)
        table.insert(drawstack, line)
    end

    -- top edge
    do
        local line = Drawing.new("Line")
        line.Color = Color3.new(0,0,1)
        line.Thickness = 1
        line.Visible = true
        line.From = Vector2.new(basel.X, head.Y)
        line.To =  Vector2.new(baser.X, head.Y)
        table.insert(drawstack, line)
    end

    -- bottom edge
    do
        local line = Drawing.new("Line")
        line.Color = Color3.new(0,0,1)
        line.Thickness = 1
        line.Visible = true
        line.From = Vector2.new(basel.X, basel.Y)
        line.To =  Vector2.new(baser.X, baser.Y)
        table.insert(drawstack, line)
    end

    local anchors = {}
    anchors.head = head
    anchors.basel = basel
    anchors.baser = baser
    return anchors
end

local function healthbar(health, anchors)
    local length = (anchors.head.Y-anchors.basel.Y)*health/100


    local offset = 2
    local line = Drawing.new("Line")
    line.Color = Color3.new(0,1,0)
    line.Thickness = 2
    line.Visible = true
    -- draw on left side
    line.From = Vector2.new(anchors.basel.X-offset, anchors.basel.Y)
    line.To =  Vector2.new(anchors.basel.X-offset, anchors.basel.Y + length)
    table.insert(drawstack, line)
end

local function nametag(player, anchors, dist)
    local vsize = 350
    local size = vsize/dist
    local offset = Vector2.new(0, size)
    local anchor = Vector2.new(anchors.basel.X, anchors.head.Y) - offset
    local tag = Drawing.new("Text")
    tag.Text = player.Name
    tag.Color = Color3.new(1,0,0)
    tag.Size = size
    tag.Position = anchor
    tag.Visible = true

    table.insert(drawstack, tag)
end

Hooks.nametagstep = hookfunction(hudNameTagObject.step, function(self) -- TODO: hook operateonallentries and remove enemy players to regain team nametag functionality
    return
end)

local function step()
    for _,v in pairs(drawstack) do
        if v then
            v:Remove()
        end
    end
    drawstack = {}
    characterInterface.operateOnAllEntries(function(player, replicationObject)
        if not replicationObject:isReady() or player.TeamColor == PlayerService.LocalPlayer.TeamColor then
            return
        end
        local parts = replicationObject:getThirdPersonObject():getCharacterHash()
        local _, visible = camera:WorldToViewportPoint(parts.head.Position)
        if visible then
            skeleton(parts)
            local anchors = box(parts)
            healthbar(replicationObject:getHealth(), anchors)
            nametag(player, anchors, (parts.head.Position-camera.CFrame.Position).Magnitude)
        end
    end)
end

local renderstepped = nil
local function lines(state)
    if state then
        if not renderstepped then
            renderstepped = runService.RenderStepped:Connect(function()
                step()
            end)
        end
    else
        if renderstepped then
            renderstepped:Disconnect()
            for _,v in ipairs(drawstack) do
                v:Remove()
            end
            drawstack = {}
            renderstepped = nil
        end
    end
end

getgenv().LineSettings = lineSettings
getgenv().Lines = lines