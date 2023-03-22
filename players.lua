local replicationInterface = shared.require("ReplicationInterface")
local playerService = game:GetService("Players")
local teamService = game:GetService("Teams")

local function getThirdPerson(player)
    local ro = replicationInterface.getEntry(player)
    if ro then
        local tpo = ro:getThirdPersonObject()
        if tpo then
            return tpo, ro:isReady()
        end
    end
end

local function getModel(model) -- expensive
    local p
    ReplicationInterface.operateOnAllEntries(function(_player, _replicationObject)
        local _tpo = _replicationObject:getThirdPersonObject()
        if _tpo then
            local cModel = _tpo:getCharacterModel()
            if cModel then
                if rawequal(cModel,model) then
                    p = _player
                end
            end
        end
    end)
    return p
end

-- Returns the Team instance of the opposite team.
local function enemyTeam()
    if playerService.LocalPlayer.Team == teamService:GetTeams()[1] then
        return teamService:GetTeams()[2]
    else
        return teamService:GetTeams()[1]
    end
end

-- Functions
getgenv().GetThirdPerson = getThirdPerson
getgenv().GetModel = getModel
getgenv().EnemyTeam = enemyTeam

-- Services
getgenv().PlayerService = playerService
getgenv().TeamService = teamService


-- Interfaces
getgenv().ReplicationInterface = replicationInterface
