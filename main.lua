-- global tables
getgenv().Scepter = {}
getgenv().Hooks = {}

import('bypass.lua')

repeat task.wait()
until getgenv().ModulesLoaded
print("Modules loaded. Injecting")

import('players.lua')

--esp
import('esp/lines.lua')
import('esp/playerchams.lua')
import('esp/objectchams.lua')

--aim
import('aim/silent.lua')

--character
import('character/speedhack.lua')
import('character/nofall.lua')
import('ui.lua')