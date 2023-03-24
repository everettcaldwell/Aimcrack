DEBUG_VERBOSE = false

printconsole("Waiting for game to load...",255,255,255)
repeat task.wait()
until game:IsLoaded()
printconsole("Game loaded, running hooks",255,255,255)

local moduleloader = require(game:GetService("ReplicatedFirst").ModuleLoader)
local require_func
for k,v in pairs(moduleloader) do
    if k == "require" then
        require_func = v 
        print("lua searcher found the 'require' function")
    end
end

-- Iterator can be used to load faster (1695 modules are loaded)
if require_func then
    oldrequire = hookfunction(require_func, function(moduleCache, moduleName, dealloc) --module_cache, module_name, deallocBool
        if DEBUG_VERBOSE then
            print(string.format("require(%s,%s,%s)", tostring(moduleCache), moduleName, tostring(dealloc)))
        end
        return oldrequire(moduleCache, moduleName, dealloc)
    end)
end

printconsole("Waiting for modules to load...",255,255,255)
task.wait(5)
printconsole("Scepter loaded!",0,255,0)


