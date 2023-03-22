local runService=game:GetService("RunService")
local replicatedFirst=game:GetService("ReplicatedFirst")

replicatedFirst.ChildAdded:Connect(function(d) -- Disables parallel execution of 'Framework'. This is the bypass.
    if d:IsA("Actor")then 
        replicatedFirst.ChildAdded:Wait()
        for e,f in next,d:GetChildren() do 
            f.Parent=replicatedFirst 
        end 
    end 
end)

local g;
g=hookmetamethod(runService.Stepped,"__index",function(self,h)
    local i=g(self,h) -- returns Stepped:<Connect,ConnectParallel> event function
    if h=="ConnectParallel" and not checkcaller()then
        hookfunction(i,newcclosure(function(j,k) -- hook ConnectParallel(self,callback())
            return g(self,"Connect")(j,function() -- 1) g(self, "Connect") returns the Connect event function. 2) Stepped:Connect(self, callback()) is called
                return self:Wait() and k() -- waits until the Stepped event is fired and then executes the original callback function
            end)
        end))
    end;
    return i 
end)


 local shared=getrenv().shared;
 repeat task.wait()
 until shared.close;
 getgenv().shared.require=shared.require 
 
 printconsole("[Scepter] ANTICHEAT BYPASSED\n",255,255,0)
