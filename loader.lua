local version_info = {
    debug = true,
    version = "0.1",
}

local root_url = version_info.debug and "http://localhost:8000/" or "https://raw.githubusercontent.com/cyr0zn/Specter/main/"

local out = version_info.debug and function(T, ...)
    return warn("debug: "..T:format(...))
end or function() end

local function import(file)
    out("Importing File \"%s\"", file)

    local x, a = pcall(function()
        return loadstring(game:HttpGet(root_url .. file))()
    end)
    if not x then
        return warn('failed to import', file)
    end
end

getgenv().import = import
getgenv().details = version_info

import('main.lua')