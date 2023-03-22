
local moduleloader = {};
moduleloader.__index = moduleloader;
function moduleloader.new(p1)
	local cacheStruct = {
		_cache = {}, 
		_requireStack = {}, 
		_server = game:GetService("RunService"):IsServer()
	};
	for k, someinstance in next, p1 do
		for k2, someChildInstance in next, someinstance:GetDescendants() do
			if someChildInstance:IsA("ModuleScript") then
				if someChildInstance._cache[someChildInstance.Name] then
					warn(string.format("Warning: Duplicate name of %q already exists! Undefined behavior!", someChildInstance.Name));
				end;
				someChildInstance._cache[someChildInstance.Name] = {
					object = someChildInstance, 
					module = nil, 
					requires = 0
				};
			end;
		end;
	end;
	return setmetatable(cacheStruct, moduleloader); -- instance of this module (moduleloader) returned when cache is indexed
end;
function moduleloader.require(module_cache, module_name, deallocBool)
	local cached_module = module_cache._cache[module_name];
	local not_found_errMsg = string.format("Module %q not found!", module_name);
	if not cached_module then
		error(not_found_errMsg, 0);
	end;
	cached_module.requires = cached_module.requires + 1;
	if cached_module.module then
		return cached_module.module;
	end;
	if table.find(module_cache._requireStack, module_name) then
		table.insert(module_cache._requireStack, module_name);
		error(string.format("Reciprocal require attempted! RequireStack: %s", table.concat(module_cache._requireStack, " -> ")), 0);
	end;
	table.insert(module_cache._requireStack, module_name);
	if module_cache._server then
		cached_module.module = require(cached_module.object);
	else
		local v9, v10 = pcall(require, cached_module.object);
		if v9 then
			cached_module.module = v10;
		else
			error(string.format("Error when requiring: %s", table.concat(module_cache._requireStack, " -> ")), 0);
		end;
	end;
	table.remove(module_cache._requireStack);
	if type(cached_module.module) == "table" and type(cached_module.module._init) == "function" then
		cached_module.module:_init(module_cache);
	end;
	if deallocBool then
		cached_module.object.Parent = nil;
	end;
	return cached_module.module;
end;
function moduleloader.add(module_cache, module_name, module)
	if module_cache._cache[module_name] then
		error(string.format("%s Is already registered", module_name));
	end;
	module_cache._cache[module_name] = {
		module = module, 
		requires = 0
	};
end;
function moduleloader.requireCache(moduleCache)
	for module in next, moduleCache._cache do
		moduleCache:require(module); -- method can be called because of the metatable at the top of the script
	end;
end;
function moduleloader.ClearScripts(moduleCacheStruct) -- deallocates all of the modules. Likely used by the close() function the Framework localscript
	local l_next = next;
	local moduleCache = moduleCacheStruct._cache;
	local i = nil;
	while true do
		local k, v = l_next(moduleCache, i);
		if not k then
			break;
		end;
		if v.object then
			v.object.Parent = nil;
		end;
		if v.requires == 0 then
			warn("Unused module", k);
		end;	
	end;
end;
return moduleloader;

