raycastSingleExit = function(castFrom, rayDir, dFilter)
    local raycastParams = RaycastParams.new();
    raycastParams.FilterType = Enum.RaycastFilterType.Whitelist;
    raycastParams.FilterDescendantsInstances = { dFilter };
    raycastParams.IgnoreWater = true;
    return workspace:Raycast(castFrom + rayDir, -rayDir, raycastParams);
end

raycast = function(castFrom, rayDir, _descendantsFilter, somefunc, keepFilter)
    local raycastHit = nil;
    local raycastParams = RaycastParams.new();
    raycastParams.FilterDescendantsInstances = _descendantsFilter;
    raycastParams.IgnoreWater = true;
    while true do
        raycastHit = workspace:Raycast(castFrom, rayDir, raycastParams);
        if not somefunc then
            break;
        end;
        if not raycastHit then
            break;
        end;
        if not somefunc(raycastHit.Instance) then
            break;
        end;
        table.insert(_descendantsFilter, raycastHit.Instance);
        raycastParams.FilterDescendantsInstances = _descendantsFilter;		
    end;
    if not keepFilter then
        for i = #_descendantsFilter, #_descendantsFilter + 1, -1 do
            _descendantsFilter[i] = nil;
        end;
    end;
    return raycastHit;
end

-- bullet check
local l__timehit__1 = shared.require("physics").timehit;
local l__bulletLifeTime__2 = shared.require("PublicSettings").bulletLifeTime;
local ignoreList = { workspace.Terrain, workspace.Ignore, workspace.CurrentCamera };
local raycastModule = shared.require("Raycast");
local function isGlass(p1)
	if not p1.CanCollide then
		return true;
	end;
	if p1.Transparency ~= 1 then
		return;
	end;
	return true;
end;

return function(_castFrom, p3, p4, p5, p6, p7)
	local timetohit = l__timehit__1(_castFrom, p4, p5, p3);
	local v3 = true;
	if timetohit == timetohit then
		v3 = true;
		if timetohit ~= (1 / 0) then
			v3 = timetohit == (-1 / 0);
		end;
	end;
	if v3 or l__bulletLifeTime__2 < timetohit then
		return false;
	end;
	local dFilter = { ignoreList };
	local v5 = true;
	local v6 = false;
	local v7 = 0;
	local v8 = p7 and 0.016666666666666666;
	local castFrom = _castFrom;
	local _p4 = p4;
	local v11 = p6;
	while v7 < timetohit do
		local v12 = timetohit - v7;
		if v8 < v12 then
			v12 = v8;
		end;
		local rayDir = v12 * _p4 + v12 * v12 / 2 * p5;
		local raycastHit = raycastModule.raycast(castFrom, rayDir, dFilter, isGlass, true);
		if raycastHit then
			local hitInstance = raycastHit.Instance;
			local hitPosition = raycastHit.Position;
			local rayDirUnit = rayDir.unit;
			local wallbangHit = raycastModule.raycastSingleExit(hitPosition, hitInstance.Size.magnitude * rayDirUnit, hitInstance);
			if wallbangHit then
				v11 = v11 - rayDirUnit:Dot(wallbangHit.Position - hitPosition); -- = v11 - v11^2
				if v11 < 0 then
					v5 = false;
					break;
				end;
				v6 = true;
			end;
			local v19 = rayDir:Dot(hitPosition - castFrom) / rayDir:Dot(rayDir) * v12;
			castFrom = hitPosition + 0.01 * (castFrom - hitPosition).unit;
			_p4 = _p4 + v19 * p5;
			v7 = v7 + v19;
			table.insert(dFilter, hitInstance);
		else
			castFrom = castFrom + rayDir;
			_p4 = _p4 + v12 * p5;
			v7 = v7 + v12;
		end;	
	end;
	return v5, v6, v11;
end;
