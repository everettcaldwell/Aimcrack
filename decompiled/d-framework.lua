local rs = game:GetService("RunService");
local heartbeat = rs.Heartbeat; -- Fires every frame after the physics simulation has completed
local stepped = rs.Stepped; -- fires every frame prior to physics simulation, during render stage
local steppedConnect = stepped.Connect;
local steppedConnectParallel = stepped.ConnectParallel;
if rawequal(steppedConnect, steppedConnectParallel) then
	return;
end;
local trollStr = nil;
-- fires first
steppedConnect(rs.RenderStepped, function() -- fires every frame prior to the frame being rendered (before stepped), callback is executed synchronously
	trollStr = nil;
end);
-- fires second
-- if steppedConnectParallel was hooked to return steppedConnect
steppedConnectParallel(stepped, function()
	trollStr = "Trolled"; 
end);
while true do
	wait();
	if game:IsLoaded() and shared.require then
		break;
	end;
end;
while true do -- Iterates every heartbeat event, which is called third and last
	heartbeat:Wait();
	if trollStr then
		break;
	end;
end;