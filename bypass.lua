local runService = game:GetService("RunService")
local replicatedFirst = game:GetService("ReplicatedFirst")

replicatedFirst.ChildAdded:Connect(function(actor)
    if actor:IsA("Actor") then
        replicatedFirst.ChildAdded:Wait()
        for _, localScript in next, actor:GetChildren() do
            localScript.Parent = replicatedFirst
        end
    end
end)

local stepped__index;
stepped__index = hookmetamethod(runService.Stepped, "__index", function(self, funcname)
    local func = stepped__index(self, funcname)
    if funcname == "ConnectParallel" and not checkcaller() then
        hookfunction(func, newcclosure(function(event, callback)
            return stepped__index(self, "Connect")(event, function()
                return self:Wait() and callback()
            end)
        end))
    end
    return func
end)

local shared=getrenv().shared

while true do
    if shared.close then
        local closefunc
        closefunc = hookfunction(shared.close, function()
            getgenv().ModulesLoaded = true
            closefunc()
        end)
        getgenv().shared.require = shared.require
        printconsole("[Scepter] ANTICHEAT BYPASSED\n",255,255,0)
        break
    end
    task.wait()
end