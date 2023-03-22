local version_info = {
    debug = true,
    version = "0.1",
}

local root_url = version_info.debug and "http://localhost:8000/" or "https://raw.githubusercontent.com/cyr0zn/Specter/main/"

local debug_print = version_info.debug and function(T, ...)
    return warn("debug: "..T:format(...))
end or function() end

local function import(file)
    debug_print("Importing File \"%s\"", file)

    local x, a = pcall(function()
        return loadstring(game:HttpGet(root_url .. file))()
    end)
    if not x then
        return warn(string.format("failed to import %s\n\t--> %s", file, a))
    end
end

getgenv().import = import
getgenv().version_info = version_info
getgenv().debug_print = version_info and debug_print

import('main.lua')