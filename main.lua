-- global tables
getgenv().Hooks = {}

import('bypass.lua')

repeat task.wait()
until getgenv().ModulesLoaded
print("Modules loaded. Injecting")

import('players.lua')

--esp
import('esp/lines.lua')
import('esp/chams.lua')

--aim
import('aim/silent.lua')
import('ui.lua')

norecoil(true)