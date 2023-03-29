local highlightFolder = Instance.new("Folder", game)

-- Variables
local unusedHighlights = {}
local usedHighlights = {}

local function updateHighlightColor(color)
    for i,v in ipairs(usedHighlights) do
        v.FillColor = color
        v.OutlineColor = color
    end

    for i,v in ipairs(unusedHighlights) do
        v.FillColor = color
        v.OutlineColor = color
    end
end

for i = 1, 31 do
    local highlight = Instance.new("Highlight")

    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineTransparency = 0.5
    highlight.Adornee = nil
    highlight.Parent = highlightFolder

    table.insert(unusedHighlights, highlight)
end

local enemyAddedConnection = nil
local enemyRemovedConnection = nil

local function removeHighlight(enemy)
    usedHighlights[enemy].Adornee = nil

    table.insert(unusedHighlights, usedHighlights[enemy])
    usedHighlights[enemy] = nil
end

local function highlightEnemy(enemy)
    usedHighlights[enemy] = table.remove(unusedHighlights, 1)

    local highlight = usedHighlights[enemy]
    highlight.Adornee = enemy
end

local function highlightEnemies()
    local opposingTeam = workspace.Players[EnemyTeam().TeamColor.Name]

    for i,v in ipairs(opposingTeam:GetChildren()) do
        highlightEnemy(v)
    end

    enemyAddedConnection = opposingTeam.ChildAdded:Connect(highlightEnemy)
    enemyRemovedConnection = opposingTeam.ChildRemoved:Connect(removeHighlight)
end

local function clearHighlights()
    enemyAddedConnection:Disconnect()
    enemyRemovedConnection:Disconnect()

    for k,_ in pairs(usedHighlights) do
        removeHighlight(k)
    end
end


PlayerService.LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()
    clearHighlights()
    highlightEnemies()
end)


getgenv().Chams = function (state) 
    if state then
        highlightEnemies()
    else
        clearHighlights()
    end
end

getgenv().UpdateHighlightColor = updateHighlightColor